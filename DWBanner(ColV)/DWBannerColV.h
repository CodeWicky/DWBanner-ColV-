//
//  DWBannerColV.h
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/4.
//  Copyright © 2016年 Wicky. All rights reserved.
//


/*
 DWBannerColV
 
 version 1.0.0
 实现自动轮播功能
 实现手动滚动暂停轮播功能
 实现Banner点击回调
 添加暂停、恢复轮播接口
 以防连续滑动边界问题
 SDWebImage请自行引入
 
 version 1.0.1
 实现自定义滚动方法功能
 */
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,DWScrollDirection){
    DWScrollDirectionDown,
    DWScrollDirectionUp,
    DWScrollDirectionRight,
    DWScrollDirectionLeft
};
@protocol DWBannerColVDelegate <NSObject>

@optional
///Banner图改变触发代理
-(void)DWBannerColVDidChange:(NSInteger)currentIndex;

@end
@interface DWBannerColV : UICollectionView

@property (nonatomic ,weak) id<DWBannerColVDelegate> bannerColVDelegate;
@property (nonatomic ,assign) NSInteger currentPage;
@property (nonatomic ,assign) DWScrollDirection scrollDirection;
///初始化方法
/*
 frame          尺寸
 imageArray     数据源：图片地址，网络本地均可
 timeInterval   轮播时间间隔：0为不自动轮播
 handler        点击回调block
 */
-(instancetype)initWithFrame:(CGRect)frame
                  imageArray:(__kindof NSArray *)imageArray
                timeInterval:(CGFloat)timeInterval
             scrollDirection:(DWScrollDirection)scrollDirection
                     handler:(void (^)(NSInteger clickedIndex,DWBannerColV * banner))handler;
///暂停轮播
-(void)suspendBanner;
///恢复轮播
-(void)resumeBanner;
@end
