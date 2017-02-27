//
//  DJColorfulSlider.h
//  Lotery
//
//  Created by 代俊 on 2016/10/20.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DJColorfulSliderDelegate <NSObject>

- (void)sliderDidSlidWithValue:(CGFloat)value;

@end

@interface DJColorfulSlider : UIView

#define BridgeColor(color) (__bridge id)color.CGColor

#define GradientColor1 (__bridge id)[UIColor colorWithRed:17/255.0 green:75/255.0 blue:171/255.0 alpha:1].CGColor
#define GradientColor2 (__bridge id)[UIColor colorWithRed:39/255.0 green:170/255.0 blue:176/255.0 alpha:1].CGColor
#define GradientColor3 (__bridge id)[UIColor colorWithRed:251/255.0 green:151/255.0 blue:0 alpha:1].CGColor

#define DJSliderMoreThanNum 0 //尾部多出的线段数 默认0


@property (nonatomic, copy) NSArray *colors;//渐变颜色
@property (nonatomic, copy) NSArray *locations;//渐变位置 0-1
@property (nonatomic, copy) NSArray *numberWords;//区间显示名称


@property (nonatomic, assign) NSInteger max;//最大值
@property (nonatomic, assign) NSInteger min;//最小值

@property (nonatomic, assign) id<DJColorfulSliderDelegate>delegate;

- (void)setUp;

@end
