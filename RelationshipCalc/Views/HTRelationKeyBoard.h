//
//  HTRelationKeyBoard.h
//  RelationshipCalc
//
//  Created by apple on 2018/2/5.
//  Copyright © 2018年 KS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, RelationKeyType) {
    RelationKeyTypeVal,
    RelationKeyTypeDel,
    RelationKeyTypeAC,
    RelationKeyTypeEqual
};

@protocol HTRelationKeyBoardDelegate <NSObject>
- (void)keyboardSelectedType:(RelationKeyType)type relationValue:(NSString *)relationStr;
@end

@interface HTRelationKeyBoard : UIView
@property(nonatomic,weak)id<HTRelationKeyBoardDelegate> delegate;
- (void)setRelationBtnEnabled:(BOOL)enabled;
@end
