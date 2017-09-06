//
//  Snake.h
//  Snake
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakePoint.h"

@interface Snake : NSObject
@property  (nonatomic) enum Direction dir;
@property  (nonatomic, retain) SnakePoint *point;

- (id)init:(int)_x y:(int)_y;

- (void)setNextNode:(Snake *)node;
- (void)setPoint:(int)x y:(int)y;

- (Snake *)getNext;
- (void)changeDirection:(enum Direction)dir;

@end
