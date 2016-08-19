//
//  DWPageControl.m
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/5.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWPageControl.h"

@implementation DWPageControl

-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count
{
    CGSize size = [[UIPageControl new] sizeForNumberOfPages:count];
    frame.size = size;
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfPages = count;
        self.currentPage = 0;
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(instancetype)initWithCenter:(CGPoint)center
                        count:(NSInteger)count
{
    CGSize size = [[UIPageControl new] sizeForNumberOfPages:count];
    CGPoint origin = CGPointZero;
    origin.x = center.x - size.width / 2.0;
    origin.y = center.y - size.height / 2.0;
    CGRect frame = CGRectZero;
    frame.origin = origin;
    return [[DWPageControl alloc] initWithFrame:frame count:count];
}

-(instancetype)initWithSuperView:(__kindof UIView *)superView position:(DWPageControlPosition)position count:(NSInteger)count
{
    CGRect bounds = superView.bounds;
    CGRect frame;
    CGPoint center;
    CGSize size = [[UIPageControl new] sizeForNumberOfPages:count];
    switch (position) {
        case DWPageControlPositionTopLeft:
            frame = CGRectMake(10, 0, 0, 0);
            break;
        case DWPageControlPositionTopCenter:
            center = CGPointMake(bounds.size.width / 2.0, size.height / 2.0);
            return [[DWPageControl alloc] initWithCenter:center count:count];
            break;
        case DWPageControlPositionTopRight:
            frame = CGRectMake(bounds.size.width - 10 - size.width, 0, 0, 0);
            break;
        case DWPageControlPositionBottomLeft:
            frame = CGRectMake(10, bounds.size.height - size.height, 0, 0);
            break;
        case DWPageControlPositionBottomCenter:
            center = CGPointMake(bounds.size.width / 2.0, bounds.size.height - size.height / 2.0);
            return [[DWPageControl alloc] initWithCenter:center count:count];
            break;
        case DWPageControlPositionBottomRight:
            frame = CGRectMake(bounds.size.width - 10 - size.width, bounds.size.height - size.height, 0, 0);
            break;
        default:
            frame = CGRectMake(bounds.size.width - 10 - size.width, bounds.size.height - size.height, 0, 0);
            break;
    }
    return [[DWPageControl alloc] initWithFrame:frame count:count];
}

-(void)showPage:(NSInteger)page
{
    if (page < self.numberOfPages && page > -1) {
        self.currentPage = page;
    }
}
@end
