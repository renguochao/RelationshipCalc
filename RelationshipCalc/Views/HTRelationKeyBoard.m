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
#define kRelationBtnStartTag 100
#define kRelationWrittenVals [NSArray arrayWithObjects:@"夫",@"妻",@"",@"",@"父",@"母",@"兄",@"弟",@"姐",@"妹",@"子",@"女",nil]
#define kRelationOralVals [NSArray arrayWithObjects:@"丈夫",@"妻子",@"",@"",@"爸爸",@"妈妈",@"哥哥",@"弟弟",@"姐姐",@"妹妹",@"儿子",@"女儿",nil]

@implementation HTRelationKeyBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat btnW =  self.width / 4.0f;
        CGFloat btnH =  self.height / 4.0f;
        for (int i = 0;i < 13;i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:22];
            btn.tag = kRelationBtnStartTag + i;
            if (i == 2) {
                [btn setImage:[UIImage imageNamed:@"backspace"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"backspace"] forState:UIControlStateHighlighted];
            } else if (i == 3) {
                [btn setTitle:@"AC" forState:UIControlStateNormal];
                [btn setTitleColor:[HTColor redColor] forState:UIControlStateNormal];
            } else if (i == 12) {
                btn.titleLabel.font = [UIFont systemFontOfSize:22];
                [btn setBackgroundColor:[HTColor colorWithHex:0xEB7015]];
                btn.titleLabel.font = [UIFont systemFontOfSize:40];
                [btn setTitle:@"=" forState:UIControlStateNormal];
                btn.frame = CGRectMake(0 , 3 *  btnH , self.width, btnH);
                [btn setTitleColor:[HTColor colorWithHex:0xFDBB97] forState:UIControlStateDisabled];
            } else {
                [btn setTitle:kRelationWrittenVals[i] forState:UIControlStateNormal];
                [btn setTitleColor:[HTColor colorWithHex:0x454A5E] forState:UIControlStateNormal];
                [btn setTitleColor:[HTColor colorWithHex:0xADAFB3] forState:UIControlStateDisabled];
            }

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
    if ([self.delegate respondsToSelector:@selector(keyboardSelectedType:relationValue:)]) {
        NSInteger btnIndex = sender.tag - kRelationBtnStartTag;
        if (btnIndex == 2) {
            [self setRelationBtnEnabled:YES];
            [self.delegate keyboardSelectedType:RelationKeyTypeDel relationValue:nil];
        } else if (btnIndex == 3) {
            [self setRelationBtnEnabled:YES];
            [self.delegate keyboardSelectedType:RelationKeyTypeAC relationValue:nil];
        } else if (btnIndex == 12) {
            [self.delegate keyboardSelectedType:RelationKeyTypeEqual relationValue:nil];
        } else {
            [self.delegate keyboardSelectedType:RelationKeyTypeVal relationValue:kRelationOralVals[btnIndex]];
        }
    }
}

- (void)setRelationBtnEnabled:(BOOL)enabled {
    for (int i = 0;i < 13;i++) {
        if (i == 2 || i == 3) {
            continue;
        }
        UIButton *btn = [self viewWithTag:kRelationBtnStartTag + i];
        btn.enabled = enabled;
    }
}

@end
