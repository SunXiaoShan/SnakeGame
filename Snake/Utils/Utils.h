//
//  Utils.h
//  Snake
//
//  Created by Phineas_Huang on 05/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void) performInMainThread:(void (^)()) block;
+ (void) performInBackground:(NSString *) identifier executeBlock:(void (^)()) block;

@end
