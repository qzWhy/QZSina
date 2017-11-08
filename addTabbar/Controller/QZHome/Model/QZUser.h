//
//  QZUser.h
//  addTabbar
//
//  Created by 000 on 16/12/7.
//  Copyright © 2016年 faner. All rights reserved.
// 用户模型

#import <Foundation/Foundation.h>

@interface QZUser : NSObject

//id	int64	用户UID 和 idstr是一样的
/** idstr	string	字符串型的用户UID */
@property (nonatomic, copy) NSString *idstr;
 /**name	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**profile_image_url	string	用户头像地址（中图），50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

@end
