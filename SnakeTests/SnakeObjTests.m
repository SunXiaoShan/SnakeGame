//
//  SnakeObjTests.m
//  SnakeTests
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Snake.h"

@interface SnakeObjTests : XCTestCase
@property  (nonatomic, retain) Snake *snake;
@end

@implementation SnakeObjTests

- (void)setUp {
    [super setUp];
    
    self.snake = nil;
    int xList[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    for (int i=0; i<9; i++) {
        Snake *body = [[Snake alloc] init:xList[i] y:0];
        [self insertSnake:body];
    }
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

- (void)testCheckSnake {
    int index = 0;
    Snake *snake = self.snake;
    while (snake != nil) {
        index ++;
        snake = [snake getNext];
    }
    XCTAssert(index == 9, "the length of snake's body isn't 9");
}

- (void)testCheckPosition {
    Snake *snake = self.snake;
    Snake *buff = [snake getNext];
    while (buff != nil) {
        
        int x = snake.point.x;
        int y = snake.point.y;
        int _x = buff.point.x;
        int _y = buff.point.y;

        XCTAssertTrue((ABS(x-_x)+ABS(y-_y))==1, @"the position is invalid +");
        XCTAssertTrue((ABS(x-_x)*ABS(y-_y))==0, @"the position is invalid *");
        snake = buff;
        buff = [buff getNext];
    }
}

@end
