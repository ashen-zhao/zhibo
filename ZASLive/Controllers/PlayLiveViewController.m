//
//  PlayLiveViewController.m
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import "PlayLiveViewController.h"
#import "PlayCell.h"
#import "PlatFormRoomsModel.h"

@interface PlayLiveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableSet *tempCell;
@property (nonatomic, assign) BOOL isViewDidLayoutSubviews;
@end

@implementation PlayLiveViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _flowLayout.itemSize = UIScreen.mainScreen.bounds.size;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _collectionView.scrollsToTop = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (_isViewDidLayoutSubviews) {
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    _isViewDidLayoutSubviews = YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayCell" forIndexPath:indexPath];
    PlatFormRoomsModel *m = _dataSources[indexPath.row];
    [cell setData:m];
    for (PlayCell *c in self.tempCell) {
        if (cell != c) {
            [c.playerVc pause];
        }
    }
    [self.tempCell addObject:cell];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self fixAudioOverlap:scrollView];
}

- (void)fixAudioOverlap:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height;
    PlayCell *cell = (PlayCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell.playerVc prepareToPlay];
    [cell.playerVc play];
    for (PlayCell *c in self.tempCell) {
        if (cell != c) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [c.playerVc pause];
            });
        }
    }
  

}
#pragma mark - lazyLoading

- (NSMutableArray *)dataSources {
    if (_dataSources) {
        return _dataSources;
    }
    _dataSources = [NSMutableArray arrayWithCapacity:10];
    return _dataSources;
}

- (NSMutableSet *)tempCell {
    if (_tempCell) {
        return _tempCell;
    }
    _tempCell = [NSMutableSet setWithCapacity:10];
    return _tempCell;
}

@end
