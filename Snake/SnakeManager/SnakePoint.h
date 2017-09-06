//
//  SnakePoint.h
//  Snake
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnakePoint : NSObject
@property  (nonatomic) int x;
@property  (nonatomic) int y;

- (id)init:(int)_x y:(int)_y;
- (void)setPoint:(int)x y:(int)y;
@end
