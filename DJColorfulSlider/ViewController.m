//
//  ViewController.m
//  DJColorfulSlider
//
//  Created by 代俊 on 2016/10/21.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import "ViewController.h"
#import "DJColorfulSlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DJColorfulSlider *slider = [[DJColorfulSlider alloc]initWithFrame:CGRectMake(30, 400, 300, 70)];
    slider.locations = @[@(0),@(0.3),@(1)];
    slider.numberWords = @[@"我",@"是",@"代",@"胖"];
    slider.min = 123;
    slider.max = 456;
    [self.view addSubview:slider];
    [slider setUp];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
