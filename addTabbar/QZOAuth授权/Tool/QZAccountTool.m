//
//  QZAccountTool.m
//  addTabbar
//
//  Created by 000 on 16/12/5.
//  Copyright © 2016年 faner. All rights reserved.
//
#define QZAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.data"]
#import "QZAccountTool.h"
@implementation QZAccountTool

/**
 *  存储帐号信息
 *
 *  @param account 帐号模型
 */
+ (void)saveAccount:(QZAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:QZAccountPath];
}
/**
 *  返回帐号信息
 *
 *  @return 帐号模型 （如果帐号过期  返回nil）
 */
+ (QZAccount *)account
{
    //加载模型
    QZAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:QZAccountPath];
    /*验证帐号是否过期*/
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    //获得过期时间
//    NSData *expiresTime = [account.created_time ]
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //获得当前时间
    NSDate *now = [NSDate date];
    //如果now>=expiresTime过期
    /**NSOrderedAscending = -1L, 升序
     NSOrderedSame,
     NSOrderedDescending 降序
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result!=NSOrderedDescending) {//过期
        return nil;
    }
    return account;
}
@end
