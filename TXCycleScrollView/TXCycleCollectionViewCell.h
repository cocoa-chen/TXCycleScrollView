//
//  TXCycleCollectionViewCell.h
//  TXCycleScrollView
//
//  Created by 陈爱彬 on 17/1/9.
//  Copyright © 2017年 陈爱彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXCycleCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) UIImage *placeholderImage;
@property (nonatomic,assign) UIViewContentMode contentMode;
@property (nonatomic,strong) id itemData;


@end
