//
//  DWBannerColV.m
//  DWBanner(ColV)
//
//  Created by Wicky on 16/8/4.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWBannerColV.h"
#import "DWBannerCell.h"
#import <UIImageView+WebCache.h>
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface DWBannerColV ()<UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) __kindof NSArray * imageArr;
@property (nonatomic ,copy) void(^handler)(NSInteger,DWBannerColV *);
@property (nonatomic ,assign) NSInteger minNum;
@property (nonatomic ,assign) CGFloat timeInterval;
@property (nonatomic ,strong) NSTimer * timer;
@property (nonatomic ,assign) BOOL suspendManual;
@property (nonatomic ,assign) UICollectionViewScrollPosition scrollPosition;
@end

@implementation DWBannerColV
#pragma mark ---接口方法---

///初始化方法
-(instancetype)initWithFrame:(CGRect)frame
                  imageArray:(__kindof NSArray *)imageArray
                timeInterval:(CGFloat)timeInterval
             scrollDirection:(DWScrollDirection)scrollDirection
                     handler:(void (^)(NSInteger clickedIndex,DWBannerColV * banner))handler
{
    self = [self initWithFrame:frame scrollDirection:scrollDirection];
    if (self) {
        self.imageArr = imageArray;
        self.handler = handler;
        self.timeInterval = timeInterval;
        self.minNum = self.imageArr.count * 4;
        [self setOffsetAfterChangeImage];
        if (timeInterval > 0) {
            [self creatTimerWithTimeInterval:timeInterval];
        }
    }
    return self;
}

///暂停轮播
-(void)suspendBanner
{
    if (self.timeInterval > 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.suspendManual = YES;
    }
}

///回复轮播
-(void)resumeBanner
{
    if (self.timeInterval > 0) {
        [self creatTimerWithTimeInterval:self.timeInterval];
        self.suspendManual = NO;
    }
}

#pragma mark ---工具方法---
///构造方法
-(instancetype)initWithFrame:(CGRect)frame
             scrollDirection:(DWScrollDirection)scrollDirection
{
    float width = frame.size.width;
    float height = frame.size.height;
    UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (scrollDirection < DWScrollDirectionRight) {
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.pagingEnabled = YES;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[DWBannerCell class] forCellWithReuseIdentifier:@"DWBannerColVCell"];
        self.showsHorizontalScrollIndicator = NO;
        self.scrollDirection = scrollDirection;
    }
    return self;
}

///String转换Url
-(NSURL *)urlFromString:(NSString *)str
{
    if ([str hasPrefix:@"http://"]) {
        return [NSURL URLWithString:str];
    }
    return [NSURL fileURLWithPath:str];
}

///根据indexPath转换index
-(NSInteger)imageIndexFromIndexPath:(NSIndexPath *)indexPath
{
    if (self.imageArr.count) {
        NSInteger index = indexPath.row % self.imageArr.count;
        return index;
    }
    return NSIntegerMax;
}

///返回当前cell的indexPath
-(NSIndexPath *)currentIndexPath
{
    DWBannerCell * cell = [self currentCell];
    return [self indexPathForCell:cell];
}

///根据visibleCells返回当前显示的cell
-(DWBannerCell *)currentCell
{
    NSArray * arr = self.visibleCells;
    if (arr.count == 1) {
        return arr.firstObject;
    }
    DWBannerCell * cell1 = arr.firstObject;
    DWBannerCell * cell2 = arr.lastObject;
    BOOL cell1Less = ([self originDistance:cell1.frame.origin] < [self originDistance:cell2.frame.origin]);
    if (!(self.scrollDirection % 2)) {
        return cell1Less?cell1:cell2;
    }
    else
    {
        return cell1Less?cell2:cell1;
    }
}

///获取origin距（0，0）的距离
-(CGFloat)originDistance:(CGPoint)origin
{
    return origin.x + origin.y;
}

///自动矫正偏移量
-(void)setOffsetAfterChangeImage
{
    NSIndexPath * indexPath = [self currentIndexPath];
    if (indexPath.row < self.imageArr.count * 4 || indexPath.row >= self.imageArr.count * 5) {
        NSInteger index = indexPath.row % self.imageArr.count + self.minNum;
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:(self.scrollPosition) animated:NO];
    }
    if (self.bannerColVDelegate && [self.bannerColVDelegate respondsToSelector:@selector(DWBannerColVDidChange:)]) {
        [self.bannerColVDelegate DWBannerColVDidChange:self.currentPage];
    }
}

///创建一个计时器
-(void)creatTimerWithTimeInterval:(CGFloat)timeInterval
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

-(void)suspendTimer
{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerSuspendAction) userInfo:nil repeats:NO];
}

///计时器动作
-(void)timerAction
{
    NSIndexPath * indexPath = [self currentIndexPath];
    NSIndexPath * newIndexPath = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:indexPath.section];
    if (self.scrollDirection % 2 == 0) {
        newIndexPath = [NSIndexPath indexPathForItem:indexPath.row - 1 inSection:indexPath.section];
    }
    [self scrollToItemAtIndexPath:newIndexPath atScrollPosition:(self.scrollPosition) animated:YES];
}

///计时器暂停动作
-(void)timerSuspendAction
{
    if (self.timer) {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.timer fire];
}

#pragma mark ---colV代理---
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count * 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DWBannerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DWBannerColVCell" forIndexPath:indexPath];
    NSURL * picUrl;
    NSInteger index = [self imageIndexFromIndexPath:indexPath];
    if (self.imageArr.count && index != NSIntegerMax) {
        picUrl = [self urlFromString:self.imageArr[index]];
    }
    cell.imgV.image = nil;
    [cell.imgV sd_setImageWithURL:picUrl];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.timeInterval > 0 && !self.suspendManual) {
        [self suspendTimer];
    }
    if (self.handler) {
        self.handler(indexPath.row % self.imageArr.count,self);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timeInterval > 0 && !self.suspendManual) {
        [self suspendTimer];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self setOffsetAfterChangeImage];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setOffsetAfterChangeImage];
}

#pragma mark ---setter、getter---
-(NSInteger)currentPage
{
    NSIndexPath * indexPath = [self currentIndexPath];
    return [self imageIndexFromIndexPath:indexPath];
}

-(UICollectionViewScrollPosition)scrollPosition
{
    if (self.scrollDirection < DWScrollDirectionRight) {
        return UICollectionViewScrollPositionCenteredVertically;
    }
    return UICollectionViewScrollPositionCenteredHorizontally;
}
@end
