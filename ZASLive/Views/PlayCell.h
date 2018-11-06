//
//  PlayCell.h
//  ZASLive
//
//  Created by Ashen on 2018/10/24.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
@class PlatFormRoomsModel;
@interface PlayCell : UICollectionViewCell
@property (nonatomic, strong) IJKFFMoviePlayerController *playerVc;
@property (weak, nonatomic) IBOutlet UIButton *btnLoved;
@property (weak, nonatomic) IBOutlet UIImageView *imgVThum;
- (void)setData:(PlatFormRoomsModel *)model;
@end
