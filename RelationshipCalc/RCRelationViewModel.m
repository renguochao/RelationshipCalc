//
//  RCRelationViewModel.m
//  RelationshipCalc
//
//  Created by Guochao Ren on 2018/2/4.
//  Copyright © 2018年 KS. All rights reserved.
//

#import "RCRelationViewModel.h"

@interface RCRelationViewModel ()

/**
 关系链-称谓映射字典
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<NSString *> *> *dictRcMapping;

/**
 简化关系链使用的正则表达式
 */
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *arrFilter;


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
        
    }
    return self;
}

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

- (NSString *)simplifyRelationChain:(NSString *)relationChain {
    
    
    return nil;
}







@end
