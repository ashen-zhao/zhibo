//
//  PlatFormRoomsCell.m
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import "PlatFormRoomsCell.h"
#import "PlatFormRoomsModel.h"
#import <UIImageView+WebCache.h>

@implementation PlatFormRoomsCell

- (void)setData:(PlatFormRoomsModel *)model {
//    [self.imgVLogo sd_setImageWithURL:[NSURL URLWithString:model.live_thumb] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//    }];
    self.lblName.text = model.title;
}
@end
