//
//  TXCycleScrollView.m
//  TXCycleScrollView
//
//  Created by 陈爱彬 on 17/1/9.
//  Copyright © 2017年 陈爱彬. All rights reserved.
//

#import "TXCycleScrollView.h"
#import "TXCycleCollectionViewCell.h"

static NSString *kCellIndentifier = @"cellIndentifier";

@interface TXCycleScrollView()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate>
{
    UIImageView *_zeroItemsImageView;
    UICollectionView *_collectionView;
    UIPageControl *_pageControl;
    UICollectionViewFlowLayout *_layout;
}
@property (nonatomic,strong) NSArray *bannerList;
@property (nonatomic,strong) NSTimer *timer;

@end
@implementation TXCycleScrollView

- (void)dealloc
{
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setupCycleScrollView];
    }
    return self;
}
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.autoScroll = YES;
    self.autoScrollTimeInterval = 2.f;
    self.continuous = YES;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.bannerContentMode = UIViewContentModeScaleAspectFill;
}
- (void)setupCycleScrollView
{
    _zeroItemsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _zeroItemsImageView.image = _zeroItemsImage;
    _zeroItemsImageView.contentMode = self.bannerContentMode;
    _zeroItemsImageView.clipsToBounds = YES;
    [self addSubview:_zeroItemsImageView];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = self.scrollDirection;
    _layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[TXCycleCollectionViewCell class] forCellWithReuseIdentifier:kCellIndentifier];
    [self addSubview:_collectionView];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 20)];
    [_pageControl addTarget:self action:@selector(onPageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //TODO:
    _collectionView.frame = self.bounds;
    _layout.itemSize = self.bounds.size;
}
#pragma mark - getter and setter
- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [self startTimer];
    }else{
        [self stopTimer];
    }
}
- (void)setContinuous:(BOOL)continuous
{
    _continuous = continuous;
}
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    _layout.scrollDirection = _scrollDirection;
}
- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    if (_autoScroll) {
        [self startTimer];
    }
}
- (void)setContentMode:(UIViewContentMode)contentMode
{
    _bannerContentMode = contentMode;
    _zeroItemsImageView.contentMode = _bannerContentMode;
    [_collectionView reloadData];
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    [_collectionView reloadData];
}
- (void)setZeroItemsImage:(UIImage *)zeroItemsImage
{
    _zeroItemsImage = zeroItemsImage;
    dispatch_async(dispatch_get_main_queue(), ^{
        _zeroItemsImageView.image = _zeroItemsImage;
    });
}
- (void)setImageUrls:(NSArray *)imageUrls
{
    if (!imageUrls || ![imageUrls count]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _zeroItemsImageView.image = _zeroItemsImage;
        });
        return;
    }
    _imageUrls = imageUrls;
    if (_continuous) {
        NSMutableArray *list = [NSMutableArray array];
        if (imageUrls.count > 1) {
            [list addObject:imageUrls.lastObject];
            [list addObjectsFromArray:imageUrls];
            [list addObject:imageUrls.firstObject];
            self.bannerList = [list copy];
        }else{
            self.bannerList = imageUrls;
        }
    }else{
        self.bannerList = imageUrls;
    }
    _pageControl.numberOfPages = imageUrls.count;
    [_collectionView reloadData];
    if (_continuous && imageUrls.count > 1) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    if (_autoScroll) {
        [self startTimer];
    }
}
#pragma mark - Helper
- (void)startTimer
{
    [self stopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(onScrollTimerHandled:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}
- (void)onScrollTimerHandled:(NSTimer *)timer
{
    NSInteger page = [self currentPage];
    NSInteger scrollPage = page;
    if (_continuous) {
        scrollPage = page + 1;
    }else{
        scrollPage = MIN(page + 1, self.bannerList.count - 1);
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:scrollPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
- (void)onPageControlValueChanged:(UIPageControl *)pageControl
{
    NSInteger page = [pageControl currentPage];
    NSInteger scrollPage = page;
    if (_continuous) {
        scrollPage = page + 1;
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:scrollPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
- (NSInteger)currentPage
{
    NSInteger page = 0;
    if (_layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        page = (_collectionView.contentOffset.x + _layout.itemSize.width * 0.5) / _layout.itemSize.width;
    }else {
        page = (_collectionView.contentOffset.y + _layout.itemSize.height * 0.5) / _layout.itemSize.height;
    }
    return MAX(0, page);
}
- (void)resetContentOffset
{
    NSInteger page = [self currentPage];
    if (_continuous) {
        NSInteger scrollPage = 0;
        NSInteger index = 0;
        if (page == 0) {
            scrollPage = self.bannerList.count - 2;
            index = self.bannerList.count - 3;
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:scrollPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else if (page == self.bannerList.count - 1) {
            scrollPage = 1;
            index = 0;
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:scrollPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else{
            index = page - 1;
        }
        _pageControl.currentPage = index;
        
    }else{
        _pageControl.currentPage = page;
    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self stopTimer];
    }
}
#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bannerList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TXCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIndentifier forIndexPath:indexPath];
    id itemData = self.bannerList[indexPath.item];
    cell.contentMode = _bannerContentMode;
    cell.placeholderImage = _placeholderImage;
    cell.itemData = itemData;
    return cell;
}
#pragma mark - UICollectionViewDelegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        NSInteger index = indexPath.item;
        if (self.continuous) {
            if (indexPath.item == 0) {
                index = self.bannerList.count - 3;
            }else if (indexPath.item == self.bannerList.count - 1) {
                index = 0;
            }else{
                index = indexPath.item - 1;
            }
        }
        [_delegate cycleScrollView:self didSelectItemAtIndex:index];
    }
}
#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_autoScroll) {
        [self stopTimer];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_autoScroll) {
        [self startTimer];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetContentOffset];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self resetContentOffset];
}
@end
