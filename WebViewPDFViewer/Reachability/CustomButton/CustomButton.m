//
//  CustomButton.m
//  MovieViewer
//
//  Created by Takuya Aso on 2015/07/17.
//  Copyright (c) 2015年 Takuya Aso All rights reserved.
//

#import "CustomButton.h"


@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return self;
    _borderColor = [UIColor blackColor];
    _borderWidth = 0;
    _cornerRadius = 0.0;
    
    return self;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

@end