//
//  PlatFormListCell.h
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatFormListModel;
@interface PlatFormListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgvLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
- (void)setData:(PlatFormListModel *)model;
@end
