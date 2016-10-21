//
//  DJColorfulSlider.m
//  Lotery
//
//  Created by 代俊 on 2016/10/20.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import "DJColorfulSlider.h"
#import "DJGradientView.h"
#import "DJColorfulSliderIndicate.h"

@interface DJColorfulSlider ()

@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, strong) DJColorfulSliderIndicate *sliderIndicate;
@property (nonatomic, strong) DJGradientView *gradient;

@property (nonatomic, assign) NSInteger number;//线段数

@end

@implementation DJColorfulSlider

- (NSArray *)colors {
    if (!_colors) {
        _colors = [[NSArray alloc]initWithObjects:GradientColor1,GradientColor2,GradientColor3, nil];
    }
    return _colors;
}

- (NSArray *)locations {
    if (!_locations) {
        _locations = [[NSArray alloc]initWithObjects:@(0),@(0.3),@(1), nil];
    }
    return _locations;
}

- (NSInteger)max {
    if (!_max) {
        _max = 600;
    }
    return _max;
}

- (NSInteger)min {
    return _min;
}

- (NSArray *)numberWords {
    if (!_numberWords) {
        _numberWords = @[@"信用差",@"信用中等",@"信用良好",@"信用优秀"];
    }
    return _numberWords;
}

- (NSInteger)number {
    return self.numberWords.count-1;
}

- (void)setUp {
    DJGradientView *gradient = [[DJGradientView alloc]initWithFrame:CGRectMake(10, 30, self.bounds.size.width-20, 20)];
    [self addSubview:gradient];
    [gradient gradientWithColors:self.colors locations:self.locations];
    
    DJColorfulSliderIndicate *sliderIndicate = [[DJColorfulSliderIndicate alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    sliderIndicate.backgroundColor = [UIColor clearColor];
    sliderIndicate.userInteractionEnabled = YES;
    sliderIndicate.center = CGPointMake(gradient.bounds.size.height / 2.f + gradient.frame.origin.x, 15);
    [self addSubview:sliderIndicate];
    self.sliderIndicate = sliderIndicate;
    [self setsliderIndicateTextColorWithText:[NSString stringWithFormat:@"%ld",self.min]];
    self.gradient = gradient;
    [self addNumbersWithMin:self.min max:self.max number:self.number];
    
}

- (void)addNumbersWithMin:(NSInteger)min max:(NSInteger)max number:(NSInteger)number {
    [self.gradient drawMarksWithNumber:number];
    self.gradient.min = min;
    self.gradient.max = max;
    NSInteger per = (max - min) / number;
    for (int i = 0; i < number+1; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 10)];
        label.text = [NSString stringWithFormat:@"%ld",min + per * i];
        label.textColor = [self colorOfPoint:CGPointMake(self.gradient.frame.origin.x + self.gradient.frame.size.height / 2.f + ([label.text integerValue] - self.min) / per * 10 * self.gradient.perMarkWidth, CGRectGetMinY(self.gradient.frame))];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.center = CGPointMake(self.gradient.frame.origin.x + self.gradient.frame.size.height / 2.f + ([label.text integerValue] - self.min) / per * 10 * self.gradient.perMarkWidth, self.bounds.size.height - label.bounds.size.height / 2 * 3 + 2);
        [self addSubview:label];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 10)];
        label1.text = [NSString stringWithFormat:@"%@",self.numberWords[i]];
        label1.textColor = [self colorOfPoint:CGPointMake(self.gradient.frame.origin.x + self.gradient.frame.size.height / 2.f + ([label.text integerValue] - self.min) / per * 10 * self.gradient.perMarkWidth, CGRectGetMinY(self.gradient.frame))];
        label1.font = [UIFont systemFontOfSize:11];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.center = CGPointMake(self.gradient.frame.origin.x + self.gradient.frame.size.height / 2.f + ([label.text integerValue] - self.min) / per * 10 * self.gradient.perMarkWidth, self.bounds.size.height - label.bounds.size.height / 2 + 5);
        [self addSubview:label1];
    }
    
}

- (void)setsliderIndicateTextColorWithText:(NSString *)text {
    UIColor *color = [self colorOfPoint:CGPointMake(self.sliderIndicate.center.x, CGRectGetMinY(self.gradient.frame))];
    UIColor *testC = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    if ([color isEqual:testC]) {
        color = [UIColor colorWithCGColor:(CGColorRef)self.colors[0]];
    }
    [self.sliderIndicate setTintColor:color text:text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.sliderIndicate]) {
        self.canMove = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    if (p.x >= self.gradient.frame.origin.x + self.gradient.frame.size.height / 2.f && p.x <= self.gradient.frame.origin.x + self.gradient.bounds.size.width - self.gradient.frame.size.height / 2.f - self.gradient.perMarkWidth * 6 && self.canMove) {
        self.sliderIndicate.center = CGPointMake(p.x, self.sliderIndicate.center.y);
        CGFloat originX = self.gradient.frame.origin.x;
        CGFloat realX = p.x - originX - self.gradient.frame.size.height / 2.f;
        CGFloat allX = self.gradient.frame.size.width - self.gradient.frame.size.height - self.gradient.perMarkWidth * 6;
        NSString *text = [NSString stringWithFormat:@"%.lf",realX * (self.max - self.min) / allX + self.min];
        [self setsliderIndicateTextColorWithText:text];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.canMove = NO;
}

- (UIColor *)colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
//    NSLog(@"r:%d g:%d b:%d a:%d",pixel[0],pixel[1],pixel[2],pixel[3]);
    return color;
}


@end
