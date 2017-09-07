//
//  SnakeManager.m
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "SnakeManager.h"

#define DefaultPositionX 100
#define DefaultPositionY 200

#define TAG @"Manager"

@interface SnakeManager()
@property  (nonatomic, retain) Snake *snakeList;
@property  (nonatomic, retain) Fruit *fruit;
@property (nonatomic) dispatch_source_t timerSource;
@end

@implementation SnakeManager

static SnakeManager *instance;

+ (SnakeManager *)getInstance {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[SnakeManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        [self setupSnake];
        [self setupFruit];
        [self routineTask];
    }
    return self;
}

- (void)resetSnakeData {
    [self setupSnake];
    [self setupFruit];
    
    [self.delegate resetGame];
}

- (void)startGame {
    Snake *snake = self.snakeList;
    [snake setDir:DIR_LEFT];
}

- (void)setupSnake {
    Snake *first = [[Snake alloc] init:DefaultPositionX y:DefaultPositionY];
    [first setDir:DIR_STOP];
    Snake *second = [[Snake alloc] init];
    [second setPoint:[self getNextPosition:first.dir node:first]];
    [first setNextNode:second];
    self.snakeList = first;
}

- (SnakePoint *)getNextPosition:(enum Direction)dir node:(Snake *)node {
    int x = node.point.x;
    int y = node.point.y;
    switch (dir) {
        case DIR_UP:
            y--;
            break;
        case DIR_DOWN:
            y++;
            break;
        case DIR_LEFT:
            x--;
            break;
        case DIR_RIGHT:
            x++;
            break;
        case DIR_STOP:
            break;
    }
    
    return [[SnakePoint alloc] init:x y:y];
}

- (void)setupFruit {
    self.fruit = [Fruit new];
    [self.fruit setPoint:[[SnakePoint alloc] init:DefaultPositionX-20 y:DefaultPositionY]];
    [self resetFruitState];
}

- (void)shiftSnake:(int)x y:(int)y {
    Snake *list = self.snakeList;
    int lastX = x, lastY = y;
    while (list != nil) {
        int buffx = lastX;
        int buffy = lastY;
        lastX = list.point.x;
        lastY = list.point.y;
        [list setPoint:buffx y:buffy];
        
        list = [list getNext];
    }
}

- (void)slide {
    Snake *snake = self.snakeList;
    int x = snake.point.x;
    int y = snake.point.y;
    switch ([snake dir]) {
        case DIR_UP:
            y--;
            break;
        case DIR_DOWN:
            y++;
            break;
        case DIR_LEFT:
            x--;
            break;
        case DIR_RIGHT:
            x++;
            break;
            
        default:
            return;
    }
    [self shiftSnake:x y:y];
    
    [Utils performInMainThread:^{
        [self.delegate refreshView];
    }];
}

- (BOOL)checkValidSnake {
    // check bound
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    Snake *snake = self.snakeList;
    if (snake.point.x <0 || snake.point.x > w) {
        return NO;
    }
    if (snake.point.y <0 || snake.point.y > h) {
        return NO;
    }
    
    Snake *buff = [snake getNext];
    while (buff != nil) {
        if (snake.point.x == buff.point.x && snake.point.y == buff.point.y) {
            return NO;
        }
        
        buff = [buff getNext];
    }
    
    return YES;
}

- (BOOL)isFruitPosition {
    Snake *snakeHead = self.snakeList;
    return (snakeHead.point.x==self.fruit.point.x && snakeHead.point.y==self.fruit.point.y);
}

- (void)eatFruit {
    if (NO == [self isFruitPosition]) {
        return;
    }
    
    Snake *snakeHead = [[Snake alloc] init:self.fruit.point.x y:self.fruit.point.y];
    [snakeHead setNextNode:self.snakeList];
    self.snakeList = snakeHead;
    [self.fruit setEatenState:YES];
}

- (void)resetFruitState {
    if (NO == [self.fruit isEaten]) { return; }
    
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    
    int randomX = arc4random() % w;
    int randomY = arc4random() % h;
    
    BOOL isValid = YES;
    Snake *list = self.snakeList;
    while (nil != list) {
        isValid &= (list.point.x!=randomX && list.point.y!=randomY);
        if (NO == isValid) {
            break;
        }
        
        list = [list getNext];
    }
    
    if (isValid) {
        [self.fruit.point setPoint:randomX y:randomY];
        [self.fruit setEatenState:NO];
        
        [Utils performInMainThread:^{
            [self.delegate resetFruit]; // delegate
        }];
    } else {
        [self resetFruitState];
    }
}

- (void)routineTask {
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, backgroundQueue);
    dispatch_source_set_timer(self.timerSource, dispatch_time(DISPATCH_TIME_NOW, 0), 0.5*NSEC_PER_SEC, 0*NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timerSource, ^{
        [self log:@"routine"];
        [self updateSnake];
    });
    dispatch_resume(self.timerSource);
}

- (void)updateSnake {
    [self slide];
    if (NO == [self checkValidSnake]) {
        Snake *snake = self.snakeList;
        [snake setDir:DIR_STOP];
        [Utils performInMainThread:^{
            [self.delegate gameOver];
        }];
        return;
    }
    [self resetFruitState];
    [self eatFruit];
    
    [self debugLog];
}

- (Snake *)getSnake {
    return self.snakeList;
}

- (Fruit *)getFruit {
    return self.fruit;
}

- (void)changeDirection:(enum Direction)dir {
    Snake *snake = self.snakeList;
    [snake changeDirection:dir];
}

- (enum Direction)getDir {
    Snake *snake = self.snakeList;
    return snake.dir;
}

- (void)debugLog {
   [self showSlidePath:self.snakeList];
}

- (void)showSlidePath:(Snake *)node {
    [self log:[NSString stringWithFormat:@"node: x:%d y:%d", node.point.x, node.point.y]];
}

- (void)log:(NSString *)context {
    NSLog(@"%@ : %@", TAG, context);
}

- (void)injectSnake:(Snake *)snake {
    self.snakeList = snake;
}

- (void)injectFruit:(Fruit *)fruit {
    self.fruit = fruit;
}

@end
