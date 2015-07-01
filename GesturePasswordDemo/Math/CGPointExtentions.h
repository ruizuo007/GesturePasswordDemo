//
//  mathutil.h
//  GesturePasswordDemo
//
//  Created by allinpay-shenlong on 15/6/23.
//  Copyright (c) 2015年 graystone-labs.org. All rights reserved.
//

#ifndef GesturePasswordDemo_mathutil_h
#define GesturePasswordDemo_mathutil_h

#import <CoreGraphics/CGGeometry.h>

#import <math.h>
#import <objc/objc.h>

#ifdef __cplusplus
extern "C" {
#endif


static inline CGPoint sub(const CGPoint v1, const CGPoint v2) {
    
    return CGPointMake(v1.x - v2.x, v1.y - v2.y);
}

static inline CGFloat dot(const CGPoint v1, const CGPoint v2) {
    
    return (v1.x * v2.x + v1.y * v2.y);
}
    
static inline BOOL equal(const CGPoint v1, const CGPoint v2) {
        
    return ((v1.x == v2.x) && (v1.y == v2.y));
}

static inline CGFloat lengthSQ(const CGPoint v) {
    
    return dot(v, v);
}

static inline CGFloat distanceSQ(const CGPoint v1, const CGPoint v2) {
    
    return lengthSQ(sub(v1, v2));
}

CGFloat length(const CGPoint v);
    
CGFloat distance(const CGPoint v1, const CGPoint v2);
    
#ifdef __cplusplus
}
#endif
    
#endif
