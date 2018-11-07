//
//  PlayCell.m
//  ZASLive
//
//  Created by Ashen on 2018/10/24.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import "PlayCell.h"
#import "PlatFormRoomsModel.h"
#import "Tools.h"
#import <UIImageView+WebCache.h>

@interface PlayCell()
@property (nonatomic, strong) PlatFormRoomsModel *roomsModel;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopY;
@property (nonatomic, strong) IJKFFMoviePlayerController *per_playerVc;


@end

@implementation PlayCell

- (void)dealloc {
    [_playerVc shutdown];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self doubleTapGesture];
    _titleTopY.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 12;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    NSMutableArray *loves = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"loved"]] ;
    if (loves) {
        NSArray *tempArr = [NSArray arrayWithArray:loves];
        if (tempArr.count == 0) {
            [loves addObject:[Tools dicFromObject:_roomsModel]];
            [Tools showText:@"收藏成功"];
        } else {
            if ([tempArr containsObject:[Tools dicFromObject:_roomsModel]]) {
                [loves removeObject:[Tools dicFromObject:_roomsModel]];
                [Tools showText:@"取消收藏"];
            } else {
                [Tools showText:@"收藏成功"];
                [loves addObject:[Tools dicFromObject:_roomsModel]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:loves forKey:@"loved"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [Tools showText:@"收藏成功"];
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
        [mArr addObject:[Tools dicFromObject:_roomsModel]];
        [[NSUserDefaults standardUserDefaults] setObject:mArr forKey:@"loved"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setData:(PlatFormRoomsModel *)model {
    [self.imgVThum sd_setImageWithURL:[NSURL URLWithString:model.live_thumb] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    _roomsModel = model;
    _lblTitle.text = model.title;
    _lblTitle.textColor = [UIColor redColor];
    [_imgVThum setHidden:YES];
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];    
    _playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_roomsModel.stream withOptions:options];
    _playerVc.shouldAutoplay = YES;
    _playerVc.view.frame = [UIScreen mainScreen].bounds;
    _playerVc.view.contentMode = UIViewContentModeScaleAspectFit;

    [self.contentView insertSubview:_playerVc.view belowSubview:_lblTitle];
    [_playerVc prepareToPlay];
    [_playerVc play];
    if (_per_playerVc) {
        [_per_playerVc shutdown];
        [_per_playerVc.view removeFromSuperview];
    }
    _per_playerVc = _playerVc;

}

- (UITapGestureRecognizer *)doubleTapGesture {
    if (_doubleTapGesture) {
        return _doubleTapGesture;
    }
    _doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    _doubleTapGesture.numberOfTapsRequired = 2;
    _doubleTapGesture.numberOfTouchesRequired = 1;
    [self.contentView addGestureRecognizer:_doubleTapGesture];
    return _doubleTapGesture;
}
@end
