//
//  QZStatus.h
//  addTabbar
//
//  Created by 000 on 16/12/7.
//  Copyright © 2016年 faner. All rights reserved.
// 微博模型

#import <Foundation/Foundation.h>
@class QZUser;
@interface QZStatus : NSObject
/**idstr	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;
/**text	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;
/**user	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) QZUser *user;
@end
