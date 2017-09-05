//
//  Utils.m
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)performInBackground:(NSString *) identifier executeBlock:(void (^)()) block{
    const char *queueId = [[NSString stringWithFormat:@"%@.%@", [[NSBundle mainBundle] bundleIdentifier], identifier] UTF8String];
    dispatch_queue_t queue = dispatch_queue_create(queueId, NULL);
    dispatch_async(queue, block);
}

+ (void)performInMainThread:(void (^)()) block {
    dispatch_async(dispatch_get_main_queue(),block);
}

@end
