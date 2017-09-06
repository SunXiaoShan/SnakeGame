//
//  ViewController.m
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "ViewController.h"
#import "SnakeManager.h"

@interface ViewController () <SnakeManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSetup;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [SnakeManager getInstance].delegate = self;;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSetupGame:(id)sender {
}

- (void)resetFruit {
    
}

- (void)fruitIsEaten {
    
}

- (void)gameOver {
    
}


@end
