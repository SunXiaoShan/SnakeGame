//
//  FruitTests.m
//  SnakeTests
//
//  Created by Phineas_Huang on 07/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Fruit.h"

@interface FruitTests : XCTestCase
@property  (nonatomic, retain) Fruit *fruit;
@end

@implementation FruitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.fruit = nil;
    self.fruit = [Fruit new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFruitState {
    XCTAssertFalse([self.fruit isEaten], @"");
    [self.fruit setEatenState:YES];
    XCTAssertTrue([self.fruit isEaten], @"");
}

@end
