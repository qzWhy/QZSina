//
//  QZAccount.h
//  addTabbar
//
//  Created by 000 on 16/12/5.
//  Copyright © 2016年 faner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZAccount : NSObject <NSCoding>
/*
    "access_token": "ACCESS_TOKEN",
    "expires_in": 1234,
    "remind_in":"798114",
    "uid":"12341234"
    如果四个都有 可以用kvc
*/
/**用于掉用access_token，接口获取授权后的access_token*/
@property (nonatomic, copy) NSString *access_token;

/** string  access_token的生命周期，单位秒数 */
@property (nonatomic, copy) NSNumber *expires_in;
//@property (nonatomic, copy) NSString *remind_in;
/**string  当前授权用户的UID*/
@property (nonatomic, copy) NSString *uid;
/**     帐号的创建时间 */
@property (nonatomic, strong) NSDate *created_time;
/** 用户昵称 */
@property (nonatomic, copy) NSString *name;
+ (instancetype)accountWithDic:(NSDictionary *)dict;
@end
