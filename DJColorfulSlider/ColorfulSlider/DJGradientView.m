//
//  DJGradientView.m
//  Lotery
//
//  Created by 代俊 on 2016/10/20.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import "DJGradientView.h"

@interface DJGradientView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation DJGradientView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (CGFloat)perMarkWidth {
    CGFloat perMarkWidth = 1.f * (self.bounds.size.width - self.bounds.size.height) / (self.marks);
    return perMarkWidth;
}

- (void)gradientWithColors:(NSArray *)colors locations:(NSArray *)locations {
    //实现背景渐变
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer addSublayer:self.gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 0);
    
    //设置颜色数组
    self.gradientLayer.colors = colors;
    
    //设置颜色分割点（范围：0-1）
    self.gradientLayer.locations = locations;
    
}

- (void)drawMarksWithNumber:(NSInteger)number{
        
    NSInteger surplus = 5;
    _marks = surplus + number * 10 + 1;
    self.layer.cornerRadius = self.bounds.size.height / 2.f;
    self.clipsToBounds = YES;
    CGFloat perMarkWidth = (self.bounds.size.width - self.bounds.size.height) / (number * 10 + 1 + surplus);
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < number * 10 + 1 + surplus; i++) {
        CGFloat x = i * perMarkWidth + self.bounds.size.height / 2;
        CGFloat y = self.bounds.size.height / 4;
        [path moveToPoint:CGPointMake(x, 1)];
        if (i == 0 || (i % 5 == 0 && i % 10 != 0)) {
            //中长线
            y = self.bounds.size.height / 2;
            [path addLineToPoint:CGPointMake(x, y)];
        }
        else if (i % 10 == 0 && i != 0) {
            //长线
            y = self.bounds.size.height;
            [path addLineToPoint:CGPointMake(x, y-1)];
            [path moveToPoint:CGPointMake(x+0.3, 1)];
            [path addLineToPoint:CGPointMake(x+0.3, y-1)];
        }
        else {
            //短线
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = 0.7;
    layer.strokeColor = [[UIColor colorWithWhite:0.95 alpha:0.8] CGColor];
    [self.layer addSublayer:layer];
    
    
    
}

@end
