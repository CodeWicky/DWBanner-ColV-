//
//  DWPageControl.h
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/5.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/*
 DWPageControl
 
 简介：自动添加的pageControl
 
 version：1.0.0
 
 自适应pageControl大小
 自动添加至六个预定位置
 */

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,DWPageControlPosition){
    DWPageControlPositionTopLeft,
    DWPageControlPositionTopCenter,
    DWPageControlPositionTopRight,
    DWPageControlPositionBottomLeft,
    DWPageControlPositionBottomCenter,
    DWPageControlPositionBottomRight
};
@interface DWPageControl : UIPageControl
-(instancetype)initWithCenter:(CGPoint)center
                        count:(NSInteger)count;
-(instancetype)initWithFrame:(CGRect)frame
                       count:(NSInteger)count;
-(instancetype)initWithSuperView:(__kindof UIView *)superView
                        position:(DWPageControlPosition)position
                           count:(NSInteger)count;
-(void)showPage:(NSInteger)page;
@end
