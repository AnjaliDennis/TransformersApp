//
//  BattlefieldTransformerViewControllerTests.m
//  TransformersAppTests
//
//  Created by Anjali Pragati Dennis on 01/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BattlefieldTransformerViewController.h"
#import "TransformerDataModel.h"

@interface BattlefieldTransformerViewControllerTests : XCTestCase
@property (nonatomic) BattlefieldTransformerViewController *battlefieldTransformerViewController;

@end

@implementation BattlefieldTransformerViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
   // self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
   // [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    self.battlefieldTransformerViewController = [[BattlefieldTransformerViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void) testSortTransformers {
    self.battlefieldTransformerViewController.dataSource = [[BattlefieldTransformerTableViewDatasourceAndDelegate alloc] init];
    self.battlefieldTransformerViewController.dataSource.transformerDataModelArray = [[NSMutableArray alloc] init];
    TransformerDataModel *transformerDataModel1 = [[TransformerDataModel alloc] initWithTransformerId:@"-LLbrUN3dQkeejt9vTZc" name:@"Transformer1" strength:@"10" intelligence:@"10" speed:@"4" endurance:@"8" rank:@"5" courage:@"9" firepower:@"10" skill:@"9" team:@"Decepticon" teamIcon:@"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"];
    TransformerDataModel *transformerDataModel2 = [[TransformerDataModel alloc] initWithTransformerId:@"-LLbrUN3dQkeejt9vTZc" name:@"Transformer2" strength:@"10" intelligence:@"10" speed:@"4" endurance:@"8" rank:@"10" courage:@"9" firepower:@"10" skill:@"9" team:@"Decepticon" teamIcon:@"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"];
    TransformerDataModel *transformerDataModel3 = [[TransformerDataModel alloc] initWithTransformerId:@"-LLbrUN3dQkeejt9vTZc" name:@"Transformer3" strength:@"10" intelligence:@"10" speed:@"4" endurance:@"8" rank:@"7" courage:@"9" firepower:@"10" skill:@"9" team:@"Autobot" teamIcon:@"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"];
    TransformerDataModel *transformerDataModel4 = [[TransformerDataModel alloc] initWithTransformerId:@"-LLbrUN3dQkeejt9vTZc" name:@"Transformer4" strength:@"10" intelligence:@"10" speed:@"4" endurance:@"8" rank:@"7" courage:@"9" firepower:@"10" skill:@"9" team:@"Autobot" teamIcon:@"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"];
    [self.battlefieldTransformerViewController.dataSource.transformerDataModelArray addObject:transformerDataModel1];
    [self.battlefieldTransformerViewController.dataSource.transformerDataModelArray addObject:transformerDataModel2];
    [self.battlefieldTransformerViewController.dataSource.transformerDataModelArray addObject:transformerDataModel3];
    [self.battlefieldTransformerViewController.dataSource.transformerDataModelArray addObject:transformerDataModel4];
    
    self.battlefieldTransformerViewController.dataSource.sortedAutobotsDataModelArray = [[NSMutableArray alloc] init];
    self.battlefieldTransformerViewController.dataSource.sortedDecepticonsDataModelArray = [[NSMutableArray alloc] init];
    
    [self.battlefieldTransformerViewController sortTransformers];
    XCTAssertEqual(self.battlefieldTransformerViewController.dataSource.transformerDataModelArray.count,4,@"Count value of main array is incorrect");
     XCTAssertEqual(self.battlefieldTransformerViewController.dataSource.sortedAutobotsDataModelArray.count,2,@"Count value of sorted autobot array is incorrect");
     XCTAssertEqual(self.battlefieldTransformerViewController.dataSource.sortedDecepticonsDataModelArray.count,2,@"Count value of sorted decepticon array is incorrect");
    XCTAssertEqual([self.battlefieldTransformerViewController.dataSource.sortedAutobotsDataModelArray firstObject].rank.intValue,7,@"Rank values are not equal");
    XCTAssertEqual([self.battlefieldTransformerViewController.dataSource.sortedAutobotsDataModelArray lastObject].rank.intValue,7,@"Rank values are not equal");
    XCTAssertEqual([self.battlefieldTransformerViewController.dataSource.sortedDecepticonsDataModelArray firstObject].rank.intValue,10,@"Rank values are not equal");
    XCTAssertEqual([self.battlefieldTransformerViewController.dataSource.sortedDecepticonsDataModelArray lastObject].rank.intValue,5,@"Rank values are not equal");
}



@end
