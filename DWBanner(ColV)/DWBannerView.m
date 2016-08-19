//
//  DWBannerView.m
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/5.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWBannerView.h"
#import "DWPageControl.h"

@interface DWBannerView ()<DWBannerColVDelegate>

@property (nonatomic ,strong) DWBannerColV * banner;
@property (nonatomic ,strong) DWPageControl * pgCtl;
@property (nonatomic ,strong) __kindof NSArray * titleArray;
@property (nonatomic ,strong) UILabel * lbTitle;

@end

@implementation DWBannerView

#pragma mark ---接口方法---
-(instancetype)initWithFrame:(CGRect)frame
                  imageArray:(__kindof NSArray *)imageArray
                  titleArray:(__kindof NSArray *)titleArray
                timeInterval:(CGFloat)timeInterval
             scrollDirection:(DWScrollDirection)scrollDirection
                hasIndicator:(BOOL)hasIndicator
                     handler:(void (^)(NSInteger, DWBannerColV *))handler
{
    self = [super initWithFrame:frame];
    if (self) {
        self.banner = [[DWBannerColV alloc] initWithFrame:self.bounds imageArray:imageArray timeInterval:timeInterval scrollDirection:scrollDirection handler:handler];
        [self addSubview:self.banner];
        if (titleArray || hasIndicator) {
            self.banner.bannerColVDelegate = self;
        }
        if (titleArray) {
            CGSize size = [[UIPageControl new] sizeForNumberOfPages:imageArray.count];
            UIView * blackV = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - size.height, frame.size.width, size.height)];
            blackV.userInteractionEnabled = NO;
            blackV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
            [self addSubview:blackV];
            self.titleArray = titleArray;
            if (hasIndicator) {
                self.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - size.width - 30, size.height)];
            }
            else
            {
                self.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, size.height)];
            }
            [blackV addSubview:self.lbTitle];
            self.lbTitle.textColor = [UIColor whiteColor];
            self.lbTitle.text = [self titleStringAtIndex:0];
        }
        if (hasIndicator) {
            if (titleArray) {
                self.pgCtl = [[DWPageControl alloc] initWithSuperView:self.lbTitle.superview position:(DWPageControlPositionBottomRight) count:imageArray.count];
                [self.lbTitle.superview addSubview:self.pgCtl];
            }
            else
            {
                self.pgCtl = [[DWPageControl alloc] initWithSuperView:self position:DWPageControlPositionBottomCenter count:imageArray.count];
                [self addSubview:self.pgCtl];
            }
        }
    }
    return self;
}

-(void)suspendBanner
{
    [self.banner suspendBanner];
}

-(void)resumeBanner
{
    [self.banner resumeBanner];
}

#pragma mark ---工具方法---
-(NSString *)titleStringAtIndex:(NSInteger)index
{
    if (index > -1 && index < self.titleArray.count) {
        return self.titleArray[index];
    }
    return nil;
}

#pragma mark ---DWBannerColV代理---
-(void)DWBannerColVDidChange:(NSInteger)currentIndex
{
    self.lbTitle.text = [self titleStringAtIndex:currentIndex];
    [self.pgCtl showPage:currentIndex];
}
@end
