//
//  GesturePasswordPoint.m
//  GesturePasswordDemo
//
//  Created by allinpay-shenlong on 15/6/23.
//  Copyright (c) 2015年 graystone-labs.org. All rights reserved.
//

#import "GesturePasswordButton.h"

@implementation GesturePasswordButton

#pragma mark -

- (CGRect)backgroundRectForBounds:(CGRect)bounds {
    
    return _backgroundRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    return _pointRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
