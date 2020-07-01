//
//  TransformerNetworkAPITests.m
//  TransformersAppTests
//
//  Created by Anjali Pragati Dennis on 30/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TransformerNetworkAPI.h"

@interface TransformerNetworkAPITests : XCTestCase
@property (nonatomic) NSString *transformerId;
@property (nonatomic) TransformerNetworkAPI *transformerNetworkAPI;

@end

@implementation TransformerNetworkAPITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    // self.continueAfterFailure = NO;
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //  [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    self.transformerId =@"";
    self.transformerNetworkAPI = [[TransformerNetworkAPI alloc] init];
    
    //setting up data for delete and update test cases
    [self testCreateTransformer];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


-(void) testGetTokenWithCompletionHandler {
    NSURL *URL = [NSURL URLWithString:@"https://transformers-api.firebaseapp.com/allspark"];
    NSString *description = [NSString stringWithFormat:@"GET %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    [self.transformerNetworkAPI getTokenWithCompletionHandler:^(NSError * _Nonnull error) {
        XCTAssertNil(error, "Error should be nil");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void) testCreateTransformer {
    NSURL *URL = [NSURL URLWithString:@"https://transformers-api.firebaseapp.com/transformers"];
    NSString *description = [NSString stringWithFormat:@"POST %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    TransformerDataModel *transformerDataModel = [[TransformerDataModel alloc] initWithTransformerId:@"" name:@"Megatron" strength:@"10" intelligence:@"10" speed:@"4" endurance:@"8" rank:@"10" courage:@"9" firepower:@"10" skill:@"9" team:@"D" teamIcon:@""];
    XCTAssertNotNil(transformerDataModel, "Data model should not be nil");
    //TransformerNetworkAPI *transformerNetworkAPI = [[TransformerNetworkAPI alloc] init];
    [self.transformerNetworkAPI createTransformer:transformerDataModel :^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
        XCTAssertNotNil(dataDictionary, "Data should not be nil");
        self.transformerId = [dataDictionary objectForKey:@"id"];
        XCTAssertNil(error, "Error should be nil");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:15.0 handler:nil];
}

-(void) testGetTransformerListWithCompletionHandler {
    NSURL *URL = [NSURL URLWithString:@"https://transformers-api.firebaseapp.com/transformers"];
    NSString *description = [NSString stringWithFormat:@"GET %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    //TransformerNetworkAPI *transformerNetworkAPI = [[TransformerNetworkAPI alloc] init];
    [self.transformerNetworkAPI getTransformerListWithCompletionHandler:^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
        XCTAssertNotNil(dataDictionary, "Data should not be nil");
        XCTAssertNil(error, "Error should be nil");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void) testDeleteTransformer {
    NSURL *URL = [NSURL URLWithString:@"https://transformers-api.firebaseapp.com/transformers"];
    NSString *description = [NSString stringWithFormat:@"DELETE %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    [self.transformerNetworkAPI deleteTransformer:self.transformerId :^(BOOL status) {
        XCTAssert(status, "Status should not be false");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void) testUpdateTransformer {
    NSURL *URL = [NSURL URLWithString:@"https://transformers-api.firebaseapp.com/transformers"];
    NSString *description = [NSString stringWithFormat:@"PUT %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    TransformerDataModel *transformerDataModel = [[TransformerDataModel alloc] initWithTransformerId:self.transformerId name:@"Megatron" strength:@"10" intelligence:@"10" speed:@"4" endurance:@"8" rank:@"10" courage:@"9" firepower:@"10" skill:@"9" team:@"D" teamIcon:@"https://tfwiki.net/mediawiki/images2/archive/8/8d/201104 10191659%21Symbol_decept_reg.png"];
    XCTAssertNotNil(transformerDataModel, "Data model should not be nil");
    
    [self.transformerNetworkAPI updateTransformer:transformerDataModel :^(NSDictionary * _Nonnull dataDictionary, NSError * _Nonnull error) {
        XCTAssertNotNil(dataDictionary, "Data should not be nil");
        XCTAssertNil(error, "Error should be nil");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}


@end
