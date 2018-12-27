//
//  MTGetDate.m
//  monthTimer
//
//  Created by mt y on 2018/7/10.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTGetDate.h"

@implementation MTGetDate

//当前时间的
+ (NSDateComponents *)weekDateCompontents:(NSDate *)date {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday|kCFCalendarUnitWeekOfMonth fromDate:date];
    
    return components;
}
+ (BOOL)dayIsOk:(NSDateComponents *)DateWeek dateFormat:(NSString *)dateStr
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:dateStr];
    
    NSDateComponents *dataa =  [self weekDateCompontents:date];
    if (dataa.weekOfMonth == DateWeek.weekOfMonth && DateWeek.year == dataa.year && DateWeek.month == dataa.month && DateWeek.day == dataa.day) {
        return YES;
    }
    return NO;
}
+ (BOOL)weekIsOk:(NSDateComponents *)DateWeek dateFormat:(NSString *)dateStr
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:dateStr];
    
    NSDateComponents *dataa =  [self weekDateCompontents:date];
    if (dataa.weekOfMonth == DateWeek.weekOfMonth && DateWeek.year == dataa.year && DateWeek.month == dataa.month) {
        return YES;
    }
    return NO;
}
+ (BOOL)monthIsOk:(NSDateComponents *)Datemonth dateFormat:(NSString *)dateStr
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:dateStr];
    
    NSDateComponents *dataa =  [self weekDateCompontents:date];
    if (Datemonth.year == dataa.year && Datemonth.month == dataa.month) {
        return YES;
    }
    return NO;
}
+(NSDate *)getDate:(NSString *)date
{
    　NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date1 =[dateFormat dateFromString:date];
    return date1;
}
+(NSString *)getCurrentDate
{
    NSDateFormatter* dateFormat1 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSString *currentDateStr = [dateFormat1 stringFromDate:[NSDate date]];
    
    return currentDateStr;
}
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                              toDate:toDate
                                               options:NSCalendarWrapComponents];
     return comp.day/30;
 }
@end
