//
//  ViewController.m
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "ViewController.h"
#import "SnakeManager.h"

#import "FruitView.h"
#import "SnakeView.h"

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
    
    BaseView *v = [[FruitView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:v];
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

- (void)resetFruit {
    
}

- (void)fruitIsEaten {
    
}

- (void)gameOver {
    
}

- (void)resetGame {
    
}

- (void)refreshView {
   
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
