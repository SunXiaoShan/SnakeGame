//
//  BaseView.m
//  Snake
//
//  Created by Phineas_Huang on 06/09/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (UIColor *)getShapeColor {
    return [UIColor blueColor];
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat x = self.frame.origin.x + self.frame.size.width/2;
    CGFloat y = self.frame.origin.y + self.frame.size.height/2;
    CGFloat rad = self.frame.size.width/2;
    
    CGColorRef colorRef = [[self getShapeColor] CGColor];
    long _countComponents = CGColorGetNumberOfComponents(colorRef);
    CGFloat red = 0.0f;
    CGFloat green = 0.0f;
    CGFloat blue = 0.0f;
    CGFloat alpha = 0.0f;
    if (_countComponents == 4) {
        const CGFloat *_components = CGColorGetComponents(colorRef);
        red     = _components[0];
        green = _components[1];
        blue   = _components[2];
        alpha = _components[3];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, self.frame);
    
    UIColor* bColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    CGContextSetFillColorWithColor(context, bColor.CGColor);
    CGContextAddArc(context, x, y, rad, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFill);
}

@end
