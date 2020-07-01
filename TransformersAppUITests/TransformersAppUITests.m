//
//  TransformersAppUITests.m
//  TransformersAppUITests
//
//  Created by Anjali Pragati Dennis on 24/06/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TransformersAppUITests : XCTestCase

@end

@implementation TransformersAppUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void) testScreens {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCTAssertTrue([app.buttons[@"Refresh"] exists],@"Refresh button is missing");
    XCTAssertTrue([app.buttons[@"Create New"] exists],@"Create New button is missing");
    XCTAssertTrue([app.buttons[@"Battlefield"] exists],@"Battlefield button is missing");
    
    [[[XCUIApplication alloc] init].buttons[@"Create New"] tap];
    XCTAssertTrue([app.staticTexts[@"NAME:"] exists],@"Name label is missing");
    XCTAssertTrue([app.staticTexts[@"TEAM:"] exists],@"Team label is missing");
    XCTAssertTrue([app.buttons[@"Autobot"] exists],@"Segment control is missing");
    XCTAssertTrue([app.buttons[@"Decepticon"] exists],@"Segment control is missing");
    XCTAssertTrue([app.buttons[@"Create"] exists],@"Create button is missing");
    
    [[[XCUIApplication alloc] init].navigationBars[@"Create Transformer"].buttons[@"Back"] tap];
    [app.buttons[@"Battlefield"] tap];
    XCTAssertTrue([app.staticTexts[@"Start Battle to determine the Champion"] exists],@"Banner is missing");
    XCTAssertTrue([app.staticTexts[@"AUTOBOTS"] exists],@"Team name label header is missing");
    XCTAssertTrue([app.staticTexts[@"DECEPTICONS"] exists],@"Team name header label is missing");
    XCTAssertTrue([app.buttons[@"Start Battle"] exists],@"Create button is missing");
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[XCTOSSignpostMetric.applicationLaunchMetric] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
