//
//  PlatFormRoomsViewController.m
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import "PlatFormRoomsViewController.h"
#import "PlatFormRoomsModel.h"
#import "ZASNetHelper.h"
#import "PlatFormRoomsCell.h"
#import "PlatFormRoomsModel.h"
#import "PlayLiveViewController.h"
#import "Tools.h"

@interface PlatFormRoomsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataSources;
@end

@implementation PlatFormRoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _typeName;
    _flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.width / 2);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;

    [ZASNetHelper requestPlatFormRoomsWithParames:_typeId success:^(NSDictionary *response) {
            NSArray *tempA = response[@"data"];
            for (NSDictionary *list in tempA) {
                PlatFormRoomsModel * model = [[PlatFormRoomsModel alloc] init];
                [model setValuesForKeysWithDictionary:list];
                [self.dataSources addObject:model];
            }
            [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [Tools showText: error.localizedDescription];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlatFormRoomsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlatFormRoomsCell" forIndexPath:indexPath];
    [cell setData:_dataSources[indexPath.item]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Play" bundle:nil];
    PlayLiveViewController *vc = [sb instantiateInitialViewController];
    vc.dataSources = _dataSources;
    vc.currentIndex = indexPath.item;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - lazyLoading

- (NSMutableArray *)dataSources {
    if (_dataSources) {
        return _dataSources;
    }
    _dataSources = [NSMutableArray arrayWithCapacity:10];
    return _dataSources;
}


@end
