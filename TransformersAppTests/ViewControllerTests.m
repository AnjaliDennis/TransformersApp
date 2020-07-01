//
//  ViewControllerTests.m
//  TransformersAppTests
//
//  Created by Anjali Pragati Dennis on 30/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "TransformerDataModel.h"
#import "TransformerCollectionViewCell.h"

@interface ViewControllerTests : XCTestCase
@property (nonatomic) ViewController *viewController;
@end

@implementation ViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    //self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //[[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    self.viewController = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewController = nil;
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void) testParseData {
    self.viewController = [[ViewController alloc] init];
    NSDictionary *data = @{@"transformers":@[
    @{@"id" : @"-LLbrUN3dQkeejt9vTZc", @"name" : @"Megatron", @"strength" : @"10", @"intelligence" : @"10", @"speed" : @"4", @"endurance" : @"8", @"rank" : @"10", @"courage" : @"9", @"firepower" : @"10", @"skill" : @"9", @"team" : @"D", @"team_icon" : @"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"}
    ]};
    self.viewController.transformerDataModelArray = [[NSMutableArray alloc] init];
    [self.viewController parseData:data];
    XCTAssertEqual(self.viewController.transformerDataModelArray.count,1,@"Count values do not match");
    TransformerDataModel *testDataModel = [[TransformerDataModel alloc] init];
    testDataModel = [self.viewController.transformerDataModelArray firstObject];
    XCTAssertTrue([testDataModel.transformerId isEqualToString:@"-LLbrUN3dQkeejt9vTZc"],@"String values are not equal");
    XCTAssertTrue([testDataModel.name isEqualToString:@"Megatron"],@"String values are not equal");
    XCTAssertTrue([testDataModel.strength isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([testDataModel.intelligence isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([testDataModel.speed isEqualToString:@"4"],@"String values are not equal");
    XCTAssertTrue([testDataModel.endurance isEqualToString:@"8"],@"String values are not equal");
    XCTAssertTrue([testDataModel.rank isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([testDataModel.courage isEqualToString:@"9"],@"String values are not equal");
    XCTAssertTrue([testDataModel.firepower isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([testDataModel.skill isEqualToString:@"9"],@"String values are not equal");
    XCTAssertTrue([testDataModel.team isEqualToString:@"Decepticon"],@"String values are not equal");
    XCTAssertTrue([testDataModel.team_icon isEqualToString:@"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"],@"String values are not equal");
    //add for rating
}

-(void) testParseUpdatedData {
    self.viewController = [[ViewController alloc] init];
     NSDictionary *jsonResponseDict= @{ @"id" : @"-LLbrUN3dQkeejt9vTZc", @"name" : @"Megatron123", @"strength" : @"10", @"intelligence" : @"10", @"speed" : @"5", @"endurance" : @"8", @"rank" : @"10", @"courage" : @"9", @"firepower" : @"10", @"skill" : @"9", @"team" : @"D", @"team_icon" : @"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png",};
    TransformerDataModel *parsedResponseDataModel = [[TransformerDataModel alloc] init];
    parsedResponseDataModel = [self.viewController parseUpdatedData:jsonResponseDict];
    XCTAssertTrue([parsedResponseDataModel.transformerId isEqualToString:@"-LLbrUN3dQkeejt9vTZc"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.name isEqualToString:@"Megatron123"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.strength isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.intelligence isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.speed isEqualToString:@"5"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.endurance isEqualToString:@"8"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.rank isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.courage isEqualToString:@"9"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.firepower isEqualToString:@"10"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.skill isEqualToString:@"9"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.team isEqualToString:@"Decepticon"],@"String values are not equal");
    XCTAssertTrue([parsedResponseDataModel.team_icon isEqualToString:@"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"],@"String values are not equal");
    XCTAssertEqual(parsedResponseDataModel.rating.intValue,43,@"Rating values are not equal");
}

-(void) testviewLoad {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"transformerViewController"];
    [self.viewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    XCTAssertNotNil(self.viewController.view, @"View not initiated properly");
    NSArray *subviews = self.viewController.view.subviews;
       XCTAssertTrue([subviews containsObject:self.viewController.autobotCollectionView], @"View does not have a collection view subview");
    XCTAssertNotNil(self.viewController.autobotCollectionView, @"CollectionView not initiated");
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UICollectionViewDataSource) ], @"View does not conform");
     XCTAssertNotNil(self.viewController.autobotCollectionView.dataSource, @"Collction view datasource cannot be nil");
}

@end
