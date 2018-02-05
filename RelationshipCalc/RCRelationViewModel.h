//
//  RCRelationViewModel.h
//  RelationshipCalc
//
//  Created by Guochao Ren on 2018/2/4.
//  Copyright © 2018年 KS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRelationViewModel : NSObject

+ (instancetype)sharedInstance;

/**
 将输入字符串转换成关系链
 ex:
 "我的哥哥的妈妈的爸爸的儿子" -> ",ob,m,f,s"
 
 @param inputString 输入字符串
 @return 关系链
 */
- (NSString *)transformInputStringToRelationKey:(NSString *)inputString;

/**
 合并冗余的关系，简化关系链

 @param relationChain 关系链字符串
 @return 简化后的关系链
 */
- (NSString *)simplifyRelationChain:(NSString *)relationChain;

@end
