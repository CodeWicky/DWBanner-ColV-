//
//  DWBannerView.h
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/5.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/*
 DWBannerView
 
 简介：一句话生成Banner控件
 
 version 1.0.0
 集成DWBannerColV全部功能
 添加指示器
 添加标题栏
 
 version 1.0.1
 实现自定义滚动方向功能
 修复反向滚动标题栏更新错误bug
 */

#import <UIKit/UIKit.h>
#import "DWBannerColV.h"


@interface DWBannerView : UIView

///初始化方法
/*
 frame          尺寸
 imageArray     数据源：图片地址，网络本地均可
 titleArray     标题源：可为nil，则无标题栏。
                       非空数组时有标题栏。
                       两数据源元素个数可不对应。
 timeInterval   轮播时间间隔：0为不自动轮播
 hasIndicator   是否包含指示器
 handler        点击回调block
 */
-(instancetype)initWithFrame:(CGRect)frame
                  imageArray:(__kindof NSArray *)imageArray
                  titleArray:(__kindof NSArray *)titleArray
                timeInterval:(CGFloat)timeInterval
             scrollDirection:(DWScrollDirection)scrollDirection
                hasIndicator:(BOOL)hasIndicator
                     handler:(void (^)(NSInteger, DWBannerColV *))handler;
///暂停轮播
-(void)suspendBanner;
///恢复轮播
-(void)resumeBanner;
@end
