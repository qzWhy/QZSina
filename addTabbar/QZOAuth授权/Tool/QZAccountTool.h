//
//  QZAccountTool.h
//  addTabbar
//
//  Created by 000 on 16/12/5.
//  Copyright © 2016年 faner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZAccount.h"
@class QZAccount;
@interface QZAccountTool : NSObject
/**
 *  存储帐号信息
 *
 *  @param account 帐号模型
 */
+ (void)saveAccount: (QZAccount *)account;
/**
 *  返回帐号信息
 *
 *  @return 帐号模型 （如果帐号过期  返回nil）
 */
+ (QZAccount *)account;
@end
