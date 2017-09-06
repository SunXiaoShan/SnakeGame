//
//  Fruit.m
//  Snake
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "Fruit.h"

@interface Fruit()
@property  (nonatomic) BOOL isEaten;
@end

@implementation Fruit

- (id)init {
    self = [super init];
    if (self != nil) {
        self.point = [[SnakePoint alloc] init];
    }
    return self;
}

- (void)setEatenState:(BOOL)isEaten {
    self.isEaten = isEaten;
}

- (BOOL)isEaten {
    return _isEaten;
}

@end
