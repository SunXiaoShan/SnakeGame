//
//  SnakeManagerTests.m
//  SnakeTests
//
//  Created by Phineas_Huang on 07/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SnakeManager.h"
#import "Utils.h"

@interface SnakeManagerTests : XCTestCase
@property  (nonatomic, retain) Snake *snake;
@property  (nonatomic, retain) Fruit *fruit;
@end

@implementation SnakeManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.snake = nil;
    int xList[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    for (int i=0; i<10; i++) {
        Snake *body = [[Snake alloc] init:xList[i] y:0];
        [self insertSnake:body];
    }
    
    self.fruit = nil;
    self.fruit = [Fruit new];
}

- (void)insertSnake:(Snake *)node {
    Snake *temp = self.snake;
    if (temp == nil) {
        self.snake = node;
        return;
    }
    while (temp != nil) {
        if ([temp getNext] != nil) {
            temp = [temp getNext];
        } else {
            [temp setNextNode:node];
            return;
        }
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckSingleton {
    SnakeManager *mn1 = [SnakeManager getInstance];
    SnakeManager *mn2 = [SnakeManager getInstance];
    SnakeManager *mn3 = [SnakeManager new];
    
    XCTAssertEqual(mn1, mn2, @"");
    XCTAssertNotEqual(mn1, mn3, @"");
}

- (void)testChangeDirection {
    //enum Direction
    SnakeManager *mn1 = [SnakeManager getInstance];
    [mn1 changeDirection:DIR_UP];
    XCTAssertEqual([mn1 getDir], DIR_UP);
    [mn1 changeDirection:DIR_DOWN];
    XCTAssertEqual([mn1 getDir], DIR_DOWN);
    [mn1 changeDirection:DIR_LEFT];
    XCTAssertEqual([mn1 getDir], DIR_LEFT);
    [mn1 changeDirection:DIR_RIGHT];
    XCTAssertEqual([mn1 getDir], DIR_RIGHT);
}

- (void)testInjectSnake {
    [self.snake setDir:DIR_DOWN];
    [[SnakeManager getInstance] injectSnake:self.snake];
    XCTAssertEqual([[SnakeManager getInstance] getDir], DIR_DOWN);
    
    XCTAssertEqual([[SnakeManager getInstance] getSnake], self.snake);
}

- (void)testInjectFruit {
    [[SnakeManager getInstance] injectFruit:self.fruit];
    XCTAssertEqual([[SnakeManager getInstance] getFruit], self.fruit);
}

- (void)testRestGame {
    [[SnakeManager getInstance] resetSnakeData];
    XCTAssertEqual([[SnakeManager getInstance] getDir], DIR_STOP);
}

- (void)testStartGame {
    [[SnakeManager getInstance] resetSnakeData];
    XCTAssertEqual([[SnakeManager getInstance] getDir], DIR_STOP);
    [[SnakeManager getInstance] startGame];
    XCTAssertNotEqual([[SnakeManager getInstance] getDir], DIR_STOP);
}

- (void)testSnakeEatsFruit {
    const int interval = 3;
    const int fruitX = 0;
    const int fruitY = 0;
    
    [self.snake setDir:DIR_LEFT];
    [self.fruit setEatenState:NO];
    XCTAssertFalse([self.fruit isEaten]);
    [self.fruit setPoint:[[SnakePoint alloc] init:fruitX y:fruitY]];
    
    [[SnakeManager getInstance] injectFruit:self.fruit];
    [[SnakeManager getInstance] injectSnake:self.snake];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"wait"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        Snake *snake = self.snake;
        int i=0;
        while(snake != nil) {
            i++;
            snake = [snake getNext];
        }
        XCTAssertEqual(i, 10);
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:interval handler:nil];
}


@end
