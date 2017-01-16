//
//  TXCycleScrollView.h
//  TXCycleScrollView
//
//  Created by 陈爱彬 on 17/1/9.
//  Copyright © 2017年 陈爱彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TXCycleScrollView;
@protocol TXCycleScrollViewDelegate <NSObject>

@optional
- (void)cycleScrollView:(TXCycleScrollView *)cycleView didSelectItemAtIndex:(NSInteger)index;

@end

@interface TXCycleScrollView : UIView

@property (nonatomic,weak) id<TXCycleScrollViewDelegate> delegate;
@property (nonatomic,getter=isAutoScroll) BOOL autoScroll;
@property (nonatomic,getter=isContinuous) BOOL continuous;
@property (nonatomic,strong) NSArray *imageUrls;
@property (nonatomic,assign) NSTimeInterval autoScrollTimeInterval;
@property (nonatomic,assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic,assign) UIViewContentMode bannerContentMode;
@property (nonatomic,strong) UIImage *placeholderImage;
@property (nonatomic,strong) UIImage *zeroItemsImage;

@end
