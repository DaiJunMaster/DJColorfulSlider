//
//  DJGradientView.h
//  Lotery
//
//  Created by 代俊 on 2016/10/20.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJGradientView : UIView

@property (nonatomic, assign, readonly) NSInteger marks;
@property (nonatomic, assign, readonly) CGFloat perMarkWidth;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;

- (void)gradientWithColors:(NSArray *)colors locations:(NSArray *)locations;
- (void)drawMarksWithNumber:(NSInteger)number;

@end
