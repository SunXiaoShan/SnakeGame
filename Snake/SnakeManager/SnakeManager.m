//
//  SnakeManager.m
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "SnakeManager.h"

@interface SnakeManager()

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
 
    }
    return self;
}

@end
