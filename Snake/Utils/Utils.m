//
//  Utils.m
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (void)performInMainThread:(void (^)())block {
    dispatch_async(dispatch_get_main_queue(),block);
}

@end
