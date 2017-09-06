//
//  Fruit.h
//  Snake
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNode.h"

@interface Fruit : BaseNode

- (void)setEatenState:(BOOL)isEaten;
- (BOOL)isEaten;

@end
