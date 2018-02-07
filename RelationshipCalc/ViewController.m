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
#import "HTColor.h"
#import "Masonry.h"
#import "RCRelationViewModel.h"

@interface ViewController ()<HTRelationKeyBoardDelegate>
@property (nonatomic,strong) UILabel *relationLab;
@property (nonatomic,strong) UILabel *resultLab;
@property (nonatomic,strong) UILabel *equalRelationLab;
@property (nonatomic,strong) UILabel *equalResultLab;
@property (nonatomic,strong) HTRelationKeyBoard *relationKeyBoard;
@property (nonatomic,strong) RCRelationViewModel *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [RCRelationViewModel sharedInstance];
    [self setupUI];
    self.view.backgroundColor = [HTColor colorWithHex:0xEEF0EF];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupUI {
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"亲戚称呼计算";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [HTColor colorWithHex:0x9d9d9d];
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(statusHeight + 10));
    }];
    
    
    self.relationKeyBoard = [[HTRelationKeyBoard alloc] initWithFrame:CGRectMake(0, self.view.height - 300, self.view.width, 300)];
    self.relationKeyBoard.delegate = self;
    [self.view addSubview:self.relationKeyBoard];

    self.resultLab = [[UILabel alloc] init];
    self.resultLab.textColor = [HTColor colorWithHex:0x5c5c5c];
    self.resultLab.font = [UIFont systemFontOfSize:20];
    self.resultLab.numberOfLines = 2;
    self.resultLab.adjustsFontSizeToFitWidth = YES;
    self.resultLab.textAlignment = NSTextAlignmentRight;
    self.resultLab.text = @" ";
    [self.view addSubview:self.resultLab];
    [self.resultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.bottom.equalTo(self.relationKeyBoard.mas_top).offset(-20);
        make.left.equalTo(@20);
    }];
    
    self.relationLab = [[UILabel alloc] init];
    self.relationLab.textColor = [HTColor colorWithHex:0x020202];
    self.relationLab.textAlignment = NSTextAlignmentRight;
    self.relationLab.numberOfLines = 2;
    self.relationLab.font = [UIFont systemFontOfSize:40];
    self.relationLab.adjustsFontSizeToFitWidth = YES;
    self.relationLab.text = @"我";
    [self.view addSubview:self.relationLab];
    [self.relationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.bottom.equalTo(self.resultLab.mas_top).offset(-20);
        make.left.equalTo(@20);

    }];
    
    
    self.equalResultLab = [[UILabel alloc] init];
    self.equalResultLab.textColor = [HTColor colorWithHex:0x020202];
    self.equalResultLab.font = [UIFont systemFontOfSize:40];
    self.equalResultLab.numberOfLines = 2;
    self.equalResultLab.adjustsFontSizeToFitWidth = YES;
    self.equalResultLab.textAlignment = NSTextAlignmentRight;
    self.equalResultLab.text = @" ";
    self.equalResultLab.hidden = YES;
    [self.view addSubview:self.equalResultLab];
    [self.equalResultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.bottom.equalTo(self.relationKeyBoard.mas_top).offset(-20);
        make.left.equalTo(@20);
    }];
    
    self.equalRelationLab = [[UILabel alloc] init];
    self.equalRelationLab.textColor = [HTColor colorWithHex:0x5c5c5c];
    self.equalRelationLab.textAlignment = NSTextAlignmentRight;
    self.equalRelationLab.numberOfLines = 2;
    self.equalRelationLab.font = [UIFont systemFontOfSize:20];
    self.equalRelationLab.adjustsFontSizeToFitWidth = YES;
    self.equalRelationLab.text = @"我";
    self.equalRelationLab.hidden = YES;
    [self.view addSubview:self.equalRelationLab];
    [self.equalRelationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.bottom.equalTo(self.equalResultLab.mas_top).offset(-20);
        make.left.equalTo(@20);
        
    }];
}

- (void)keyboardSelectedType:(RelationKeyType)type relationValue:(NSString *)relationStr
{
    switch (type) {
        case RelationKeyTypeVal:
        {
            self.relationLab.text = [NSString stringWithFormat:@"%@的%@",self.relationLab.text,relationStr];

            //TODO: 计算关系
            [self.viewModel transformInputStringToRelationKey:self.relationLab.text];
            self.resultLab.text = [NSString stringWithFormat:@"%@的%@",self.resultLab.text,relationStr];
            [self.relationKeyBoard setRelationBtnEnabled:YES];
        }
            break;
        case RelationKeyTypeDel:
        {
            NSArray *relationArray = [self.relationLab.text componentsSeparatedByString:@"的"]; //字符串按照【分隔成数组
            if (relationArray.count == 1) {
                return;
            }
            NSString *lastRelation = [relationArray lastObject];
            self.relationLab.text = [self.relationLab.text substringWithRange:NSMakeRange(0,self.relationLab.text.length - lastRelation.length - 1)];
            //TODO: 计算关系
            self.resultLab.text = [NSString stringWithFormat:@"%@的",self.resultLab.text];
            [self.relationKeyBoard setRelationBtnEnabled:YES];
        }
            break;
        case RelationKeyTypeAC:
        {
            self.relationLab.text = @"我";
            self.resultLab.text = @" ";
        }
            break;
        case RelationKeyTypeEqual:
            break;
        default:
            break;
    }
    self.equalResultLab.hidden = RelationKeyTypeEqual != type;
    self.equalRelationLab.hidden = RelationKeyTypeEqual != type;
    self.resultLab.hidden = RelationKeyTypeEqual == type;
    self.relationLab.hidden = RelationKeyTypeEqual == type;
    self.equalResultLab.text = self.resultLab.text;
    self.equalRelationLab.text = self.relationLab.text;
}

@end
