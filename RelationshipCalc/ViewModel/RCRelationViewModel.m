//
//  RCRelationViewModel.m
//  RelationshipCalc
//
//  Created by Guochao Ren on 2018/2/4.
//  Copyright © 2018年 KS. All rights reserved.
//

#import "RCRelationViewModel.h"
#import "RCLogManager.h"

@interface RCRelationViewModel ()

/**
 关系链-称谓映射字典
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<NSString *> *> *dictRcMapping;

/**
 简化关系链使用的正则表达式
 */
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *arrFilter;

@property (nonatomic, strong) NSMutableSet<NSString *> *hashing;

@end

@implementation RCRelationViewModel

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RCRelationViewModel *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [RCRelationViewModel new];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSString *filterFilePath = [[NSBundle mainBundle] pathForResource:@"filter" ofType:@"json"];
        
        NSData *rcMappingData = [NSData dataWithContentsOfFile:dataFilePath];
        NSData *filterData = [NSData dataWithContentsOfFile:filterFilePath];
        
        NSError *error = nil;
        _dictRcMapping = [NSJSONSerialization JSONObjectWithData:rcMappingData options:NSJSONReadingAllowFragments error:&error];
        _arrFilter = [NSJSONSerialization JSONObjectWithData:filterData options:NSJSONReadingAllowFragments error:&error][@"filter"];
        _hashing = [[NSMutableSet alloc] init];
    }
    return self;
}

/**
 计算称谓

 @param inputString 输入
 @return 称谓
 */
- (NSString *)computeRelationWithInputString:(NSString *)inputString {
    NSMutableArray *result = [NSMutableArray array];
    NSString *relationKey = [self transformInputStringToRelationKey:inputString];
    
    NSArray *ids = [self simplifyRelationChain:relationKey];
    for (NSString *Id in ids) {
        NSArray *items = [self getDataById:Id];
        if (items.count > 0) {
            [result addObjectsFromArray:items];
        } else if ([Id characterAtIndex:0] == 'w' ||
                   [Id characterAtIndex:0] == 'h') {
            items = [self getDataById:[Id substringFromIndex:2]];
            if (items.count > 0) {
                [result addObjectsFromArray:items];
            }
        }
    }
    
    [self.hashing removeAllObjects];
    
    NSString *title = @"";
    if (result.count == 0) {
        title = @"关系有点远，再玩就坏了";
    } else {
        title = [result componentsJoinedByString:@"/"];
    }
    
    return title;
}

/**
 获取数据

 @param Id 关系链
 @return 查到的称谓
 */
- (NSArray *)getDataById:(NSString *)Id {
    NSMutableArray *items = [NSMutableArray array];
    
    if ([self.dictRcMapping.allKeys containsObject:Id]) {
        // 直接匹配称呼
        [items addObject:self.dictRcMapping[Id][0]];
    } else {
        items = [self getDataFromDictRcMapping:Id];
        if (items.count == 0) {
            // 忽略年龄条件查找
            Id = [self replaceMatchingStringWithInput:Id regExpString:@"&[ol]" template:@""];
            items = [self getDataFromDictRcMapping:Id];
        }
        if (items.count == 0) {
            // 忽略年龄条件查找
            Id = [self replaceMatchingStringWithInput:Id regExpString:@"[ol]" template:@"x"];
            items = [self getDataFromDictRcMapping:Id];
        }
        if (items.count == 0) {
            // 缩小访问查找
            NSString *l = [self replaceMatchingStringWithInput:Id regExpString:@"x" template:@"l"];
            items = [self getDataFromDictRcMapping:l];
            NSString *o = [self replaceMatchingStringWithInput:Id regExpString:@"x" template:@"o"];
            [items addObjectsFromArray:[self getDataFromDictRcMapping:o]];
        }
    }
    
    return items;
}

- (NSMutableArray *)getDataFromDictRcMapping:(NSString *)Id {
    NSMutableArray *result = [NSMutableArray array];
    
    // 忽略属性
    NSString *filterExp = @"&[olx]";
    [self.dictRcMapping enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<NSString *> * _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *filteredKey = [self replaceMatchingStringWithInput:key regExpString:filterExp template:@""];
        if ([filteredKey isEqualToString:Id]) {
            [result addObject:self.dictRcMapping[key][0]];
        }
    }];
    
    return result;
}

/**
 分词解析

 @param inputString 输入
 @return 分词后的结果
 */
- (NSString *)transformInputStringToRelationKey:(NSString *)inputString {
    __block NSString *result = @"";
    
    if (!inputString || inputString.length == 0) {
        return result;
    }
    
    NSArray *inputComponents = [inputString componentsSeparatedByString:@"的"];
    for (NSString *comp in inputComponents) {
        [self.dictRcMapping enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<NSString *> * _Nonnull obj, BOOL * _Nonnull stop) {
            for (NSString *str in obj) {
                // 从关系链-称谓映射表中查找对应的key（过滤“我”）
                if ([comp isEqualToString:str] &&
                    ![key isEqualToString:@""]) {
                    result = [result stringByAppendingString:[NSString stringWithFormat:@",%@", key]];
                    *stop = YES;
                    break;
                }
            }
        }];
    }
    
    return result;
}

/**
 简化选择器

 @param relationChain 输入
 @return 简化后的字符串
 */
- (NSMutableArray *)simplifyRelationChain:(NSString *)relationChain {
    NSMutableArray *result = [NSMutableArray new];
    
    if (![self.hashing containsObject:relationChain]) {
        [self.hashing addObject:relationChain];
        
        if (relationChain.length == 0) {
            [result addObject:relationChain];
        } else {
            BOOL status = YES;
            NSString *tmp = nil;
            do {
                tmp = relationChain;
                for (NSDictionary<NSString *, NSString *> *filter in self.arrFilter) {
                    NSString *exp = filter[@"exp"];
                    NSString *str = filter[@"str"];
                    
                    relationChain = [self replaceMatchingStringWithInput:relationChain regExpString:exp template:str];
                    DDLogDebug(@"exp:%@ - relationChain: %@", exp, relationChain);
                    
                    if ([relationChain containsString:@"#"]) {
                        NSArray *arr = [relationChain componentsSeparatedByString:@"#"];
                        for (NSString *j in arr) {
                            [result addObjectsFromArray:[self simplifyRelationChain:j]];
                        }
                        status = NO;
                        break;
                    }
                }
            } while (![tmp isEqualToString:relationChain]);
            
            if (status) {
                tmp = [self replaceMatchingStringWithInput:tmp regExpString:@",[01]" template:@""];
                if ([tmp length] > 0 && [tmp characterAtIndex:0] == ',') {
                    tmp = [tmp substringFromIndex:1];
                }
                [result addObject:tmp];
            }
            
        }
    }
    
    return result;
}

/**
 正则表达式替换

 @param inputString 输入
 @param regExpString 正则表达式
 @param template 替换文本
 @return 替换后的字符串
 */
- (NSString *)replaceMatchingStringWithInput:(NSString *)inputString
                                regExpString:(NSString *)regExpString
                                    template:(NSString *)template {
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpString
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
    NSString *result = [regExp stringByReplacingMatchesInString:inputString
                                                 options:NSMatchingReportProgress
                                                   range:NSMakeRange(0, inputString.length)
                                            withTemplate:template];
    return result;
}





@end
