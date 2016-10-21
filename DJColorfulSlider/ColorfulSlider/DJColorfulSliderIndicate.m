//
//  DJColorfulSliderIndicate.m
//  Lotery
//
//  Created by 代俊 on 2016/10/20.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import "DJColorfulSliderIndicate.h"

@interface DJColorfulSliderIndicate ()

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *tintColor;

@end

@implementation DJColorfulSliderIndicate

- (void)setTintColor:(UIColor *)color text:(NSString *)text {
    if (text) {
        _text = text;
    }
    else {
        _text = @"0";
    }
    if (color) {
        _tintColor = color;
    }
    else {
        _tintColor = [UIColor clearColor];
    }
    [self setNeedsDisplay];
}

- (NSString *)text {
    if (!_text) {
        _text = @"0";
    }
    return _text;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = [UIColor clearColor];
    }
    return _tintColor;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint sPoints[3];//坐标点
    sPoints[0] = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect)-1);//坐标1
    sPoints[1] = CGPointMake(CGRectGetMidX(rect)-4, CGRectGetMaxY(rect)-8);//坐标2
    sPoints[2] = CGPointMake(CGRectGetMidX(rect)+4, CGRectGetMaxY(rect)-8);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    UIFont *font = [UIFont boldSystemFontOfSize:15.0];//设置
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    para.alignment = NSTextAlignmentCenter;
    [self.text drawInRect:CGRectMake(0, 5, rect.size.width, 15) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:self.tintColor,NSParagraphStyleAttributeName:para}];
    
}


@end
