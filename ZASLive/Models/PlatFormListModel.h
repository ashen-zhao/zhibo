//
//  PlatFormListModel.h
//  ZASLive
//
//  Created by Ashen on 2018/10/23.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlatFormListModel : NSObject
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
//[
// {
//     "id": 68,
//     "name": "绝地求生",
//     "slug": "juediqiusheng",
//     "first_letter": "J",
//     "status": 0,
//     "prompt": 1,
//     "image": "http://static01.quanmin.tv/201712/991de922-2ea7-453b-9e0b-91f83da672f9.jpg",
//     "thumb": "http://static01.quanmin.tv/201712/4baacde9-ce6e-4a38-9bbe-7e712c823ed3.jpg",
//     "priority": 0,
//     "screen": 0
// },
// {
//     "id": 91,
//     "name": "绝地求生手游",
//     "slug": "jdqssy",
//     "first_letter": "J",
//     "status": 0,
//     "prompt": 1,
//     "image": "http://static01.quanmin.tv/201802/49cd507e-13ec-4090-82e9-6f41a6c4b7b0.png",
//     "thumb": "http://static01.quanmin.tv/201802/587628b6-e976-4eef-8586-79d7cd0d7596.png",
//     "priority": 1,
//     "screen": 0
// }, 
@end

