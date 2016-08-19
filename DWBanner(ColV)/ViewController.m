//
//  ViewController.m
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/4.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "ViewController.h"
#import "DWBannerView.h"


@interface ViewController ()<DWBannerColVDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * picUrl = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpeg"];
    DWBannerView * banner = [[DWBannerView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 200) imageArray:@[picUrl,@"http://pic1.5442.com/2015/0715/02/01.jpg",@"http://img4.duitang.com/uploads/item/201506/09/20150609021045_WAmft.jpeg"] titleArray:@[@"",@"我就是一个测试,我要假装我有很多字，很多字很多字很多字"] timeInterval:2 scrollDirection:DWScrollDirectionRight hasIndicator:YES handler:^(NSInteger clickedIndex, DWBannerColV *banner) {
        if (clickedIndex % 2) {
            NSLog(@"suspend");
            [banner suspendBanner];
        }
        else
        {
            NSLog(@"resume");
            [banner resumeBanner];
        }
    }];
    banner.backgroundColor = [UIColor redColor];
    [self.view addSubview:banner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
