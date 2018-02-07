//
//  RCLogManager.m
//  RelationshipCalc
//
//  Created by Guochao Ren on 2018/2/7.
//  Copyright © 2018年 KS. All rights reserved.
//

#import "RCLogManager.h"

#ifdef DEBUG
DDLogLevel ddLogLevel;
#else
DDLogLevel const ddLogLevel = DDLogLevelError;
#endif

@implementation RCLogManager

#pragma mark - auto regist log manager
+ (void)load {
    [self registLogManagerInstance];
}

#pragma mark - public interface
+ (RCLogManager *)registLogManagerInstance {
    static RCLogManager *logManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

#ifdef DEBUG
        ddLogLevel = DDLogLevelAll;
#endif

        logManager = [RCLogManager new];
        [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:DDLogLevelAll];
    });

    return logManager;
}

@end
