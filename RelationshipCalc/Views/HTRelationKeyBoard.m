//
//  HTRelationKeyBoard.m
//  RelationshipCalc
//
//  Created by apple on 2018/2/5.
//  Copyright © 2018年 KS. All rights reserved.
//
#import "HTRelationKeyBoard.h"
#import "UIView+Extension.h"
#import "HTColor.h"

@implementation HTRelationKeyBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arr = @[@"夫",@"妻",@"",@"",@"父",@"母",@"兄",@"弟",@"姐",@"妹",@"子",@"女"];
        CGFloat btnW =  self.width / 4.0f;
        CGFloat btnH =  self.height / 4.0f;
        for (int i = 0;i < 13;i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:22];
            btn.tag = i;
            if (i == 2) {
                [btn setImage:[UIImage imageNamed:@"backspace"] forState:UIControlStateNormal];
            } else if (i == 3) {
                [btn setTitle:@"AC" forState:UIControlStateNormal];
                [btn setTitleColor:[HTColor redColor] forState:UIControlStateNormal];
            } else if (i == 12) {
                btn.titleLabel.font = [UIFont systemFontOfSize:22];
                [btn setBackgroundColor:[HTColor colorWithHex:0xF8773B]];
                [btn setTitle:@"=" forState:UIControlStateNormal];
                btn.frame = CGRectMake(0 , 3 *  btnH , self.width, btnH);
            } else {
                [btn setTitle:arr[i] forState:UIControlStateNormal];
                [btn setTitleColor:[HTColor blackColor] forState:UIControlStateNormal];
            }

//            [btn.layer setBorderWidth:1.0];
//            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [btn addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            if (i != 12) {
                btn.frame = CGRectMake((i % 4 ) * btnW , (i / 4 ) *  btnH , btnW, btnH);
            }
            [self addSubview:btn];
        }
        
        for (int i = 0; i < 4; i++) {
            UIView *hLine = [[UIView alloc]init];
            hLine.backgroundColor = [HTColor colorWithHex:0xB4B4B4];
            hLine.frame = CGRectMake(0, i * btnH, self.width, 0.5);
            [self addSubview:hLine];
        }
        for (int i = 0; i < 3; i++) {
            UIView *vLine = [[UIView alloc]init];
            vLine.backgroundColor = [HTColor colorWithHex:0xB4B4B4];
            vLine.frame = CGRectMake((i+1) * btnW, 0, 0.5, self.height - btnH);
            [self addSubview:vLine];
        }
        
        self.backgroundColor = [HTColor colorWithHex:0xFFFEFF];
    }
    return self;
}

- (void)onButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardSelectedBtn:)]) {
        [self.delegate keyboardSelectedBtn:sender];
    }
}

@end
