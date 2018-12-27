//
//  MTGetDate.h
//  monthTimer
//
//  Created by mt y on 2018/7/10.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTGetDate : NSObject
+ (NSDateComponents *)weekDateCompontents:(NSDate *)date;
+ (BOOL)dayIsOk:(NSDateComponents *)DateWeek dateFormat:(NSString *)dateStr;//得到是否一天
+ (BOOL)weekIsOk:(NSDateComponents *)DateWeek dateFormat:(NSString *)dateStr;//得到是否一个周
+ (BOOL)monthIsOk:(NSDateComponents *)Datemonth dateFormat:(NSString *)dateStr;//得到是否一个月
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;//获取月数
+(NSDate *)getDate:(NSString *)date;
+(NSString *)getCurrentDate;
@end
