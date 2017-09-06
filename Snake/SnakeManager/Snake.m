//
//  Snake.m
//  Snake
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "Snake.h"

@interface Snake()
@property  (nonatomic, retain) Snake *next;
@end

@implementation Snake

- (id)init {
    self = [super init];
    if (self != nil) {
        [self initDirection];
        _next = nil;
    }
    return self;
}

- (id)init:(int)_x y:(int)_y {
    self = [super init];
    if (self != nil) {
        self.point = [[SnakePoint alloc] init:_x y:_y];
        [self initDirection];
        _next = nil;
    }
    return self;
}

- (void)initDirection {
    _dir = DIR_LEFT;
}

- (void)setNextNode:(Snake *)node {
    self.next = node;
}

- (void)setPoint:(int)x y:(int)y {
    [self.point setPoint:x y:y];
}

- (Snake *)getNext {
    return self.next;
}

- (void)changeDirection:(enum Direction)dir {
    self.dir = dir;
}

@end
