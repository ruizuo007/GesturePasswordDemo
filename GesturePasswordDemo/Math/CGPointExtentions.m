//
//  mathutil.c
//  GesturePasswordDemo
//
//  Created by allinpay-shenlong on 15/6/23.
//  Copyright (c) 2015年 graystone-labs.org. All rights reserved.
//

#include "CGPointExtentions.h"

CGFloat length(const CGPoint v) {
    
    return sqrtf(lengthSQ(v));
}

CGFloat distance(const CGPoint v1, const CGPoint v2) {
    
    return sqrtf(distanceSQ(v1, v2));
}