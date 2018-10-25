//
//  Tools.h
//  ZASLive
//
//  Created by Ashen on 2018/10/24.
//  Copyright © 2018 <http://www.devashen.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tools : NSObject
@property (nonatomic, assign) BOOL isOpened;
+ (Tools *)share;
- (void)openDoor:(void(^)(void))open close:(void(^)(void))close vc:(UIViewController *)vc;
+ (NSDictionary *)dicFromObject:(NSObject *)object;
+ (void)showText:(NSString *)msg;
@end
