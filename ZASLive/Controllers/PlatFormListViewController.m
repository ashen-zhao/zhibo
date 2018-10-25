//
//  PlatFormListViewController.m
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import "PlatFormListViewController.h"
#import "ZASNetHelper.h"
#import "PlatFormListCell.h"
#import "PlatFormListModel.h"
#import "PlatFormRoomsViewController.h"
#import "UserModel.h"
#import "Tools.h"

@interface PlatFormListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, assign) BOOL doorOpened;
@end

@implementation PlatFormListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    UIColor *whiteColor = [UIColor blackColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    

    self.navigationItem.title = @"这个世界怎么了";
    _flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.width / 2);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    [self requestData];
}

#pragma mark - Methods


- (void)requestData {
    [self.dataSources removeAllObjects];
    [ZASNetHelper requestPlatFormListWithParames:nil success:^(id response) {
        NSArray *lists = response;
        for (NSDictionary *list in lists) {
            PlatFormListModel * model = [[PlatFormListModel alloc] init];
            [model setValuesForKeysWithDictionary:list];
            [self.dataSources addObject:model];
        }
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        [Tools showText:error.localizedDescription];
    }];
}

#pragma mark - Actions

- (IBAction)refreshAction:(id)sender {
    if (!_doorOpened) {
        return;
    }
    [self requestData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  _dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlatFormListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlatFormListCell" forIndexPath:indexPath];
    [cell setData:_dataSources[indexPath.item]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Rooms" bundle:nil];
    PlatFormRoomsViewController *vc = [sb instantiateInitialViewController];
    PlatFormListModel *list = _dataSources[indexPath.row];
    vc.typeId = list.slug;
    vc.typeName = list.name;
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
