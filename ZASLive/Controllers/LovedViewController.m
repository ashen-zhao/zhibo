//
//  LovedViewController.m
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import "LovedViewController.h"
#import "PlatFormRoomsModel.h"
#import "ZASNetHelper.h"
#import "PlatFormRoomsCell.h"
#import "PlatFormRoomsModel.h"
#import "PlayLiveViewController.h"
#import "MBProgressHud.h"
#import "Tools.h"

@interface LovedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataSources;
@end

@implementation LovedViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.dataSources removeAllObjects];
    NSMutableArray *loved = [[NSUserDefaults standardUserDefaults] objectForKey:@"loved"];
    for (NSDictionary *dict in loved) {
        PlatFormRoomsModel *model = [[PlatFormRoomsModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.dataSources addObject:model];
    }
    [self.collectionView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"万一没了呢";
    _flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width / 3, UIScreen.mainScreen.bounds.size.width / 3);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
}

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
    vc.currentIndex = indexPath.item;
    vc.dataSources = _dataSources;
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
