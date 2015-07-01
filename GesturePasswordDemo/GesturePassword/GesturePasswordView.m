//
//  GesturePasswordView.m
//  GesturePasswordDemo
//
//  Created by allinpay-shenlong on 15/6/23.
//  Copyright (c) 2015年 graystone-labs.org. All rights reserved.
//

#import "GesturePasswordView.h"
#import "CGPointExtentions.h"
#import "GesturePasswordButton.h"

NSString *const kStrokeLineWidth = @"strokeLineWidth";//线宽

NSString *const kStrokeLineColor = @"strokeLineColor";//线颜色

NSString *const kStrokeLineAlpha = @"strokeLineAlpha";//线透明度

@interface GesturePasswordView () {
    
    CGFloat _littlePointRadius;//线划过时候的小圆点半径
    
    CGFloat _pointRadius;//手势点半径
    
    NSMutableArray *_points;
    
    NSMutableArray *_linePoints;
    
    NSMutableArray *_linePointIndexes;
    
    //
    UIBezierPath *_bezierPath;
}

@end

@implementation GesturePasswordView

- (void)dealloc {
    
    
}

- (void)awakeFromNib {
    
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

#pragma mark - common init methods

- (void)setup {
    
    _padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat tmpw = self.frame.size.width - _padding.left - _padding.right;
    CGFloat tmph = self.frame.size.height - _padding.top - _padding.bottom;
    _gap = MIN(tmpw / columns, tmph / rows);
    
    _pointRadius = _gap * 0.25;
    
    _isPasswordRight = YES;//
    
    _littlePointRadius = _pointRadius * 0.25;
    
    _points = [NSMutableArray array];
    
    _linePoints = [NSMutableArray array];
    
    _linePointIndexes = [NSMutableArray array];
    
    _gesturePasswordButtons = [NSMutableArray array];
    
    _bezierPath = [UIBezierPath bezierPath];
    
    [self fillPoints];
}

- (void)setBackground:(UIImage *)image {
    
    [self.layer setFrame:self.bounds];
    
    [self.layer setContents:(id)image.CGImage];
}

#pragma mark - 

#pragma mark - touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_linePoints removeAllObjects];
    
    [_linePointIndexes removeAllObjects];
    
    [_bezierPath removeAllPoints];
    
    [self setNeedsDisplay];
    
    [self onTouch:touches event:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self onTouch:touches event:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self onTouch:touches event:event];
}

#pragma mark - draw rect

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSaveGState(context);
    
    [self drawline:_linePoints attributes:nil context:context];
    
    [self drawAllCircles:context];
    
//    CGContextRestoreGState(context);
}

#pragma mark - draw line

- (void)drawline:(NSArray *)linePoints attributes:(NSDictionary *)attributes context:(CGContextRef)context {
    
    if ([linePoints count] <= 0) { return; }
    
    CGFloat width = attributes[kStrokeLineWidth] == nil ? 1.0 : [attributes[kStrokeLineWidth] floatValue];
    
    UIColor *color = attributes[kStrokeLineColor] == nil ? [self lineOrSelectedPointColor] : attributes[kStrokeLineColor];
    
//    CGFloat alpha = attributes[kStrokeLineAlpha] == nil ? 10.0 : [attributes[kStrokeLineAlpha] floatValue];
    
//    CGContextSetLineWidth(context, width);
    
//    CGContextSetAlpha(context, alpha);
    
//    CGContextSetStrokeColorWithColor(context, [color CGColor]);
  
    [color setStroke];

    [_bezierPath setLineWidth:width];
    
    NSInteger i = 0;
    
    NSValue *value = [linePoints objectAtIndex:i];
    
    CGPoint point = [value CGPointValue];
    
//    CGContextMoveToPoint(context, point.x, point.y);
    
    [_bezierPath moveToPoint:point];
    
    for (i = 1; i < [linePoints count]; i++) {
        
        value = [linePoints objectAtIndex:i];
        
        point = [value CGPointValue];
        
//        CGContextAddLineToPoint(context, point.x, point.y);
        
        [_bezierPath addLineToPoint:point];
    }
    
//    CGContextStrokePath(context);
    
    [_bezierPath stroke];
}

#pragma mark - draw points

- (void)fillPoints {
    
    [_points removeAllObjects];
    
    for (NSUInteger i = 0; i < rows; i++) {
        
        for (NSUInteger j = 0; j < columns; j++) {
            
            CGFloat tmpx = _padding.left + (j + 0.5) * _gap;
            
            CGFloat tmpy = _padding.top + (i + 0.5) * _gap;//囧 一开始搞反了 (x, y) -> (j, i)
 
            //不是 (x, y) -> (i, j)
            
            CGPoint p = CGPointMake(tmpx, tmpy);
            
            [_points addObject:[NSValue valueWithCGPoint:p]];
        }
    }
}

- (void)drawCircleAt:(CGPoint)centerPoint index:(NSUInteger)index context:(CGContextRef)context {
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextAddArc(context, centerPoint.x, centerPoint.y, _pointRadius, 0.0, (CGFloat)(M_PI * 2.0), 1);
    
    BOOL currentIsSelected = [_linePointIndexes containsObject:@(index)];
    
    UIColor *color;
    
    if (currentIsSelected) {
        
        color = [self lineOrSelectedPointColor];
    } else {
        
        color = [UIColor colorWithRed:144/255.0 green:149/255.0 blue:173/255.0 alpha:1.0];
    }
    
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextStrokePath(context);
    
    color = [UIColor colorWithRed:35/255.0 green:39/255.0 blue:54/255.0 alpha:1.0];
    
    //为了遮住圈内的线
    CGContextAddArc(context, centerPoint.x, centerPoint.y, _pointRadius, 0.0, (CGFloat)(M_PI * 2.0), 1);
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillPath(context);
    
    //
    
    if (currentIsSelected) {
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, _littlePointRadius, 0.0, (CGFloat)(M_PI * 2.0), 1);
        
        if (_isPasswordRight) {
            
            color = [UIColor colorWithRed:96/255.0 green:169/255.0 blue: 252/255.0 alpha:1.0];
        } else {
            
            color = [UIColor redColor];
        }
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        
        CGContextFillPath(context);
    }
}

- (void)drawAllCircles:(CGContextRef)context {
    
    for (NSUInteger i = 0; i < rows * columns; i++) {
        
        [self drawCircleAt:[(NSValue *)_points[i] CGPointValue] index:i context:context];
    }
}

#pragma mark - default line or selected point color

- (UIColor *)lineOrSelectedPointColor {
    
    UIColor *color;
    
    if (_isPasswordRight) {
        
        //选中的圆圈的边框颜色不一样
        
        color = [UIColor colorWithRed:96/255.0 green:169/255.0 blue:252/255.0 alpha:1.0];
    } else {
        
        color = [UIColor redColor];
    }
    
    return color;
}

#pragma mark -

- (NSUInteger)currentPointIndexOnTouch:(UITouch *)touch {
    
    for (NSValue *v in _points) {
        
        CGPoint p = [v CGPointValue];
        
        if (distance(p, [touch locationInView:self]) < _pointRadius) {
            
            return [_points indexOfObject:v];
        }
    }
    
    return -1;
}

#pragma mark - common part of touch event

- (void)onTouch:(NSSet *)touches event:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    NSUInteger index = [self currentPointIndexOnTouch:touch];
    
    if (index != -1 && ![_linePointIndexes containsObject:@(index)]) {
        
        [_linePointIndexes addObject:@(index)];
        
        [_linePoints addObject:_points[index]];
        
        [self setNeedsDisplay];
    }
}

#pragma mark -

- (NSString *)getOutput {
    
    NSMutableString *gesturePassword = [NSMutableString string];
    
    for (NSNumber *num in _linePointIndexes) {
        
        [gesturePassword stringByAppendingString:[num stringValue]];
    }
    
    return [NSString stringWithString:gesturePassword];
}

@end
