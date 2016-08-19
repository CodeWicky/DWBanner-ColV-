//
//  DWBannerCell.m
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/4.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWBannerCell.h"

@implementation DWBannerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imgV];
        self.imgV.clipsToBounds = YES;
    }
    return self;
}
@end
