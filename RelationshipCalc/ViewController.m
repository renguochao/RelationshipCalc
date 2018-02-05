//
//  ViewController.m
//  RelationshipCalc
//
//  Created by Guochao Ren on 2018/1/29.
//  Copyright © 2018年 KS. All rights reserved.
//

#import "ViewController.h"
#import "HTRelationKeyBoard.h"
#import "UIView+Extension.h"
#import "Masonry.h"
@interface ViewController ()<HTRelationKeyBoardDelegate>
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UILabel *resultLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupUI {

    HTRelationKeyBoard *keyBoard = [[HTRelationKeyBoard alloc] initWithFrame:CGRectMake(0, self.view.height - 300, self.view.width, 300)];
    keyBoard.delegate = self;
    [self.view addSubview:keyBoard];
    
    self.contentLab = [[UILabel alloc] init];
//    self.
    
    self.resultLab = [[UILabel alloc] init];
    self.resultLab.textAlignment = NSTextAlignmentRight;
    self.resultLab.font = [UIFont systemFontOfSize:40];
    self.resultLab.adjustsFontSizeToFitWidth = YES;
    self.resultLab.text = @"我";
    [self.view addSubview:self.resultLab];
    [self.resultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.bottom.equalTo(keyBoard.mas_top).offset(-10);
    }];
}

- (void)keyboardSelectedBtn:(UIButton *)btn {
    
}

@end
