//
//  UtilsTests.m
//  SnakeTests
//
//  Created by Phineas_Huang on 07/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utils.h"

@interface UtilsTests : XCTestCase

@end

@implementation UtilsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformInMainThread {
    [Utils performInMainThread:^{
        XCTAssert([[NSThread currentThread] isMainThread], @"This method must be called on the main thread.");
    }];
}

@end
