//
//  ViewController.m
//  GesturePasswordDemo
//
//  Created by allinpay-shenlong on 15/6/23.
//  Copyright (c) 2015年 graystone-labs.org. All rights reserved.
//

#import "ViewController.h"

#import "GesturePasswordView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GesturePasswordView *gpv = [[GesturePasswordView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:gpv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
