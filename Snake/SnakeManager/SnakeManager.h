//
//  SnakeManager.h
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Snake.h"
#import "SnakePoint.h"
#import "Fruit.h"

@protocol SnakeManagerDelegate<NSObject>
- (void)resetFruit;
- (void)fruitIsEaten;
- (void)gameOver;
- (void)resetGame;
- (void)refreshView;
@end

@interface SnakeManager : NSObject

+ (SnakeManager *)getInstance;
@property  (nonatomic, retain) id<SnakeManagerDelegate> delegate;
- (void)changeDirection:(enum Direction)dir;
- (enum Direction)getDir;
- (Snake *)getSnake;
- (Fruit *)getFruit;
- (void)resetSnakeData;
- (void)startGame;

@end
