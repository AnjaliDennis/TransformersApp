//
//  CreateTransformerViewControllerTests.m
//  TransformersAppTests
//
//  Created by Anjali Pragati Dennis on 30/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CreateTransformerViewController.h"
#import "TransformerDataModel.h"

@interface CreateTransformerViewControllerTests : XCTestCase
@property (nonatomic) CreateTransformerViewController *createTransformerViewController;

@end

@implementation CreateTransformerViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
//    
//    // In UI tests it is usually best to stop immediately when a failure occurs.
//    self.continueAfterFailure = NO;
//
//    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//    [[[XCUIApplication alloc] init] launch];
//
//    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    
    self.createTransformerViewController = [[CreateTransformerViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void) testParseAndStoreCreatedTransformer {
    NSDictionary *jsonResponseDict= @{ @"id" : @"-LLbrUN3dQkeejt9vTZc", @"name" : @"Megatron", @"strength" : @"10", @"intelligence" : @"10", @"speed" : @"4", @"endurance" : @"8", @"rank" : @"10", @"courage" : @"9", @"firepower" : @"10", @"skill" : @"9", @"team" : @"D", @"team_icon" : @"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png",};
    self.createTransformerViewController.createdTransformerDataModel = [[TransformerDataModel alloc] init];
    self.createTransformerViewController.createdTransformerDataModel = [self.createTransformerViewController parseAndStoreCreatedTransformer:jsonResponseDict];
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.transformerId isEqualToString:jsonResponseDict[@"id"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.name isEqualToString:jsonResponseDict[@"name"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.strength isEqualToString:jsonResponseDict[@"strength"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.intelligence isEqualToString:jsonResponseDict[@"intelligence"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.speed isEqualToString:jsonResponseDict[@"speed"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.endurance isEqualToString:jsonResponseDict[@"endurance"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.rank isEqualToString:jsonResponseDict[@"rank"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.courage isEqualToString:jsonResponseDict[@"courage"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.firepower isEqualToString:jsonResponseDict[@"firepower"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.skill isEqualToString:jsonResponseDict[@"skill"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.team isEqualToString:jsonResponseDict[@"team"]],@"String values are not equal");
    XCTAssertTrue([self.createTransformerViewController.createdTransformerDataModel.team_icon isEqualToString:jsonResponseDict[@"team_icon"]],@"String values are not equal");
}


@end
