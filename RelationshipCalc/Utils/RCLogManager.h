//
//  RCLogManager.h
//  RelationshipCalc
//
//  Created by Guochao Ren on 2018/2/7.
//  Copyright © 2018年 KS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
FOUNDATION_EXTERN DDLogLevel ddLogLevel;
#else
FOUNDATION_EXTERN DDLogLevel const ddLogLevel;
#endif

@interface RCLogManager : NSObject

@end
