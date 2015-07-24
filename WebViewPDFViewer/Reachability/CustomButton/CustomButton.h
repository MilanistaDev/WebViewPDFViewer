//
//  CustomButton.h
//  MovieViewer
//
//  Created by Takuya Aso on 2015/07/17.
//  Copyright (c) 2015年 Takuya Aso All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomButton : UIButton

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
