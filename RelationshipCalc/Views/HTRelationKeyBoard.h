//
//  HTRelationKeyBoard.h
//  RelationshipCalc
//
//  Created by apple on 2018/2/5.
//  Copyright © 2018年 KS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTRelationKeyBoardDelegate <NSObject>
- (void)keyboardSelectedBtn:(UIButton *)btn;

@end

@interface HTRelationKeyBoard : UIView
@property(nonatomic,weak)id<HTRelationKeyBoardDelegate> delegate;

@end
