//
//  SnakePoint.m
//  Snake
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "SnakePoint.h"

@implementation SnakePoint

- (id)init:(int)_x y:(int)_y {
    self = [super init];
    if (self != nil) {
        self.x = _x;
        self.y = _y;
    }
    return self;
}

- (void)setPoint:(int)x y:(int)y {
    self.x = x;
    self.y = y;
}

@end
