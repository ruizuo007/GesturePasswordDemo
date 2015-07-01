//
//  GesturePasswordView.h
//  GesturePasswordDemo
//
//  Created by allinpay-shenlong on 15/6/23.
//  Copyright (c) 2015年 graystone-labs.org. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *手势划线的参数配置
 *
 */

extern NSString *const kStrokeLineWidth;//线宽

extern NSString *const kStrokeLineColor;//线颜色

extern NSString *const kStrokeLineAlpha;//线透明度

/**
 *点阵的行数和列数
 *
 */

static const NSUInteger rows = 3;//默认3

static const NSUInteger columns = 3;//默认3

//当前手势密码状态
typedef NS_ENUM(NSInteger, GesturePasswordState) {
    
    GesturePasswordVerified = 0,//与存储的手势密码比对通过
    GesturePasswordNotCorrect = 1,//与存储的手势密码比对不一致
    GesturePasswordInvalid = 2,//不符合手势密码的一些格式规定 如最短等
    GesturePasswordInputOver = 3,//手势密码输入完了
};

//手势密码视图协议
@protocol GesturePasswordViewDelegate;

//手势密码按钮
@class GesturePasswordButton;

//** 手势密码视图 **//

@interface GesturePasswordView : UIView

@property (nonatomic, assign) UIEdgeInsets padding;//点阵上下左右边距 默认10

@property (nonatomic, assign) CGFloat gap;//两个点中心之间的距离

@property (nonatomic, assign) BOOL isPasswordRight;//手势密码是否正确

@property (nonatomic, assign) NSDictionary *lineConfigs;//手势线的配置

@property (nonatomic, assign) GesturePasswordState currentState;//当前手势密码状态

@property (nonatomic, strong) IBOutletCollection(GesturePasswordButton) NSMutableArray *_gesturePasswordButtons;

- (void)setup;

- (void)setBackground:(UIImage *)image;

- (NSString *)getOutput;

@end

//////////////////////////////////////////////////////////////////////////

@protocol GesturePasswordViewDelegate <NSObject>

- (void)gesturePasswordView:(GesturePasswordView *)gpv onFinish:(GesturePasswordState)state;

@end
