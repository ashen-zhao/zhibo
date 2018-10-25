//
//  PlatFormRoomsCell.h
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatFormRoomsModel;

@interface PlatFormRoomsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgVLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
- (void)setData:(PlatFormRoomsModel *)model;
@end


