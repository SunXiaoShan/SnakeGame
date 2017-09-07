//
//  SnakePointTests.m
//  SnakeTests
//
//  Created by Phineas_Huang on 07/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SnakePoint.h"

@interface SnakePointTests : XCTestCase

@end

@implementation SnakePointTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPoint {
    SnakePoint *point = [[SnakePoint alloc] init:99 y:98];
    XCTAssertEqual(point.x, 99, @"");
    XCTAssertEqual(point.y, 98, @"");
    
    [point setPoint:912 y:168];
    XCTAssertEqual(point.x, 912, @"");
    XCTAssertEqual(point.y, 168, @"");
}

@end
