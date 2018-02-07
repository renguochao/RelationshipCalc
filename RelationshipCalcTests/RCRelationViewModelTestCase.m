//
//  RCRelationViewModelTestCase.m
//  RelationshipCalcTests
//
//  Created by Guochao Ren on 2018/2/4.
//  Copyright © 2018年 KS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RCRelationViewModel.h"

@interface RCRelationViewModelTestCase : XCTestCase

@property (nonatomic, strong) RCRelationViewModel *viewModel;

@end

@implementation RCRelationViewModelTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [RCRelationViewModel sharedInstance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testComputeRelationWithInputString {
    NSString *str1 = @"我的哥哥的妈妈的爸爸的儿子";
    NSString *str2 = @"儿子的妈妈";
    
    NSString *result1 = [self.viewModel computeRelationWithInputString:str1];
    XCTAssertTrue([result1 isEqualToString:@"舅舅"]);
    
    NSString *result2 = [self.viewModel computeRelationWithInputString:str2];
    XCTAssertTrue([result2 isEqualToString:@"老婆"]);
}

- (void)testTransformInputStringToRelationKey {
    NSString *str1 = @"我的哥哥的妈妈的爸爸的儿子";
    NSString *str2 = @"儿子的妈妈";
    
    XCTAssertTrue([[self.viewModel transformInputStringToRelationKey:str1] isEqualToString:@",ob,m,f,s"]);
    XCTAssertTrue([[self.viewModel transformInputStringToRelationKey:str2] isEqualToString:@",s,m"]);

}

- (void)testSimplifyRelationChain {
    NSString *str1 = @",ob,m,f,s";
    NSString *str2 = @",s,m";
    
    NSArray *simpleArray1 = [self.viewModel simplifyRelationChain:str1];
    XCTAssertTrue([simpleArray1[0] isEqualToString:@"m,xb"]);
    
    NSArray *simpleArray2 = [self.viewModel simplifyRelationChain:str2];
    XCTAssertTrue([simpleArray2[0] isEqualToString:@"w"]);
}

@end
