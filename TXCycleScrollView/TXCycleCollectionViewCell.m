//
//  TXCycleCollectionViewCell.m
//  TXCycleScrollView
//
//  Created by 陈爱彬 on 17/1/9.
//  Copyright © 2017年 陈爱彬. All rights reserved.
//

#import "TXCycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface TXCycleCollectionViewCell()

@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation TXCycleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _contentMode = UIViewContentModeScaleAspectFill;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = _contentMode;
        [self addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}
- (void)setContentMode:(UIViewContentMode)contentMode
{
    _contentMode = contentMode;
    _imageView.contentMode = contentMode;
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
}
- (void)setItemData:(id)itemData
{
    _itemData = itemData;
    if ([_itemData isKindOfClass:[UIImage class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView.image = (UIImage *)_itemData;
        });
    }else if([_itemData isKindOfClass:[NSString class]]) {
        NSString *imageString = (NSString *)_itemData;
        if ([imageString hasPrefix:@"http"] || [imageString hasPrefix:@"https"]) {
            NSURL *url = [NSURL URLWithString:imageString];
            [_imageView sd_setImageWithURL:url placeholderImage:_placeholderImage options:SDWebImageRetryFailed | SDWebImageContinueInBackground completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                _imageView.image = image;
            }];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageNamed:imageString];
                if (!image) {
                    image = [UIImage imageWithContentsOfFile:imageString];
                }
                _imageView.image = image ?: _placeholderImage;
            });
        }
    }else if ([itemData isKindOfClass:[NSURL class]]) {
        [_imageView sd_setImageWithURL:(NSURL *)itemData placeholderImage:_placeholderImage options:SDWebImageRetryFailed | SDWebImageContinueInBackground completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _imageView.image = image;
        }];
    }else{
        _imageView.image = _placeholderImage;
    }
}
@end
