//
//  ViewController.m
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "ViewController.h"
#import "SnakeManager.h"

#define BUTTON_TITLE @"Try again!"
#define TAG @"ViewController"

@interface ViewController () <SnakeManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSetup;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [SnakeManager getInstance].delegate = self;
    [self setupGesture];
    
    [self.btnSetup setHidden:YES];
//    BaseView *v = [[SnakeView alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
//    [self.view addSubview:v];
    
   // BaseView *v1 = [[BaseView alloc] initWithFrame:CGRectMake(100, 150, 20, 20)];
    //[self.view addSubview:v1];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)] CGPath]];
    [circleLayer setStrokeColor:[[UIColor redColor] CGColor]];
    [circleLayer setFillColor:[[UIColor redColor] CGColor]];
    [[self.view layer] addSublayer:circleLayer];
    
    for (id layer in self.view.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGesture {
    UIPanGestureRecognizer *panGR =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [panGR setMaximumNumberOfTouches:1];
    [panGR setMinimumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGR];
}

- (IBAction)actionSetupGame:(id)sender {
    UIButton *btn = sender;
    [btn setTitle:BUTTON_TITLE forState:UIControlStateNormal];
    [btn setHidden:YES];
    
}

- (void)removeView {
    [[self.view.layer.sublayers copy] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CALayer * subLayer = obj;
        if ([subLayer isKindOfClass:[CAShapeLayer class]]) {
            [subLayer removeFromSuperlayer];
        }
    }];
}

- (void)drawSnake {
    Snake *snake = [[SnakeManager getInstance] getSnake];
    while (snake != nil) {
        int width = 10;
        int height = 10;
        int x = snake.point.x-width/2;
        int y = snake.point.y-height/2;
        
        [self drawObj:CGRectMake(x, y, width, height) color:[UIColor blueColor]];
        snake = [snake getNext];
    }
}

- (void)drawFruit {
    Fruit *fruit = [[SnakeManager getInstance] getFruit];
    if (NO == [fruit isEaten]) {
        int width = 10;
        int height = 10;
        int x = fruit.point.x-width/2;
        int y = fruit.point.y-height/2;
    
        [self drawObj:CGRectMake(x, y, width, height) color:[UIColor redColor]];
    }
}

- (void)drawObj:(CGRect)frame color:(UIColor *)color {
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat rad = frame.size.width/2;
    
    CGColorRef colorRef = [color CGColor];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, rad, rad)] CGPath]];
    [circleLayer setStrokeColor:colorRef];
    [circleLayer setFillColor:colorRef];
    [[self.view layer] addSublayer:circleLayer];
}

- (void)resetFruit {
    
}

- (void)fruitIsEaten {
    
}

- (void)gameOver {
    
}

- (void)resetGame {
    
}

- (void)refreshView {
    [self removeView];
    [self drawSnake];
    [self drawFruit];
}



- (void)pan:(UIPanGestureRecognizer *)sender {
    
    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
        UIPanGestureRecognizerDirectionUndefined,
        UIPanGestureRecognizerDirectionUp,
        UIPanGestureRecognizerDirectionDown,
        UIPanGestureRecognizerDirectionLeft,
        UIPanGestureRecognizerDirectionRight
    };
    
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                
                CGPoint velocity = [sender velocityInView:self.view];
                
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
                
                else {
                    if (velocity.x > 0) {
                        direction = UIPanGestureRecognizerDirectionRight;
                    } else {
                        direction = UIPanGestureRecognizerDirectionLeft;
                    }
                }
            }
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            switch (direction) {
                case UIPanGestureRecognizerDirectionUp: {
                    [self handleUpwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionDown: {
                    [self handleDownwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionLeft: {
                    [self handleLeftGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionRight: {
                    [self handleRightGesture:sender];
                    break;
                }
                default: {
                    break;
                }
            }
        }
            
        case UIGestureRecognizerStateEnded: {
            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
            
        default:
            break;
    }
    
}

- (void)handleUpwardsGesture:(UIPanGestureRecognizer *)sender {
    [self log:@"Up"];
    [[SnakeManager getInstance] changeDirection:DIR_UP];
}

- (void)handleDownwardsGesture:(UIPanGestureRecognizer *)sender {
    [self log:@"Down"];
    [[SnakeManager getInstance] changeDirection:DIR_DOWN];
}

- (void)handleLeftGesture:(UIPanGestureRecognizer *)sender {
    [self log:@"Left"];
    [[SnakeManager getInstance] changeDirection:DIR_LEFT];
}

- (void)handleRightGesture:(UIPanGestureRecognizer *)sender {
    [self log:@"Right"];
    [[SnakeManager getInstance] changeDirection:DIR_RIGHT];
}

- (void)log:(NSString *)context {
    NSLog(@"%@ : %@", TAG, context);
}

@end
