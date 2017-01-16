//
//  ViewController.m
//  TXCycleScrollView
//
//  Created by 陈爱彬 on 17/1/9.
//  Copyright © 2017年 陈爱彬. All rights reserved.
//

#import "ViewController.h"
#import "TXCycleScrollView.h"

@interface ViewController ()
<TXCycleScrollViewDelegate>


@property (nonatomic,strong) NSArray *bannerList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupBannerView];
}

- (void)setupBannerView
{
    self.bannerList = @[
                    @"http://dynamic-image.yesky.com/740x-/uploadImages/2014/188/15/4EABKK639PIS.jpg",
                    @"http://img1.3lian.com/2015/a2/239/d/289.jpg",
                    @"http://img.hb.aicdn.com/66ec45fe337d20fdb5050aaf81048b8975a518aa1a0f7-J9kgSC_fw580",
                    @"http://img0.ph.126.net/Y3AM_Lxfz4fonBDQpNlkSQ==/6597234693400985046.jpg"
                    ];

    TXCycleScrollView *bannerView = [[TXCycleScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 200)];
    bannerView.delegate = self;
    bannerView.imageUrls = self.bannerList;
    [self.view addSubview:bannerView];
    
    TXCycleScrollView *bannerView2 = [[TXCycleScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerView.frame) + 20, self.view.bounds.size.width, 200)];
    bannerView2.delegate = self;
    bannerView2.autoScroll = NO;
    bannerView2.continuous = NO;
    bannerView2.imageUrls = self.bannerList;
    [self.view addSubview:bannerView2];
    
}
#pragma mark - TXCycleScrollViewDelegate methods
- (void)cycleScrollView:(TXCycleScrollView *)cycleView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"click %@ at index:%@",cycleView,@(index));
}
@end
