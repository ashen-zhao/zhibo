//
//  PlatFormListCell.m
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import "PlatFormListCell.h"
#import "PlatFormListModel.h"
#import <UIImageView+WebCache.h>

@implementation PlatFormListCell

- (void)setData:(PlatFormListModel *)model {
//    [self.imgvLogo sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//    }];
    self.lblName.text = model.name;
}
@end
