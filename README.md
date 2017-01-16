# TXCycleScrollView

This is an infinite scrollView for iOS,will autoScroll to next page.
First,edit you Podfile
```
pod 'TXCycleScrollView'
```
then edit you code like this.
```
self.bannerList = @[
                    @"http://dynamic-image.yesky.com/740x-/uploadImages/2014/188/15/4EABKK639PIS.jpg",
                    @"http://img1.3lian.com/2015/a2/239/d/289.jpg",
                    @"http://img.hb.aicdn.com/66ec45fe337d20fdb5050aaf81048b8975a518aa1a0f7-J9kgSC_fw580",
                    @"http://img0.ph.126.net/Y3AM_Lxfz4fonBDQpNlkSQ==/6597234693400985046.jpg"
                    ];
                    
TXCycleScrollView *bannerView = [[TXCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
bannerView.delegate = self;
bannerView.imageUrls = self.bannerList;
[self.view addSubview:bannerView];

TXCycleScrollView *bannerView2 = [[TXCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
bannerView2.delegate = self;
bannerView2.autoScroll = NO; //will not auto Scroll
bannerView2.continuous = NO; // infinite will be no
bannerView2.imageUrls = self.bannerList;
[self.view addSubview:bannerView2];
```
