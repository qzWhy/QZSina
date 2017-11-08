//
//  QZAccount.m
//  addTabbar
//
//  Created by 000 on 16/12/5.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZAccount.h"

@implementation QZAccount

+ (instancetype)accountWithDic:(NSDictionary *)dict
{
    QZAccount *account =[[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict [@"expires_in"];
    //获得帐号存储的时间（accessToken的产生时间）
    account.created_time = [NSDate date];
    return account;
}
/**
 *  当一个对象要归档进沙盒中时，就会掉用这个方法
 *
 *  目的：在这个方法中说明这个对象的哪些属性存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.created_time forKey:@"created_time"];
    [enCoder encodeObject:self.name forKey:@"name"];
}
/**
 *  当从沙盒中解挡一个对象时（从沙盒中加载一个对象时），就会掉用这个方法
 *  目的：从这个方法中说明沙盒中属性改怎么解析（需要取出哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self == [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
