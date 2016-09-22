//
//  NSDate+Easy.h
//  EasyDate
//
//  Created by Jordi Puigdellívol on 13/8/16.
//  Copyright © 2016 revo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EASYDATE_DEFAULT_DATETIME_FORMAT    @"yyyy-MM-dd HH:mm:ss"
#define EASYDATE_DEFAULT_DATE_FORMAT        @"yyyy-MM-dd"

@interface NSDate (Easy)

+(NSDate*)now;
+(NSDate*)today;
+(NSDate*)yesterday;
+(NSDate*)tomorrow;
+(NSDate*)thisMinute;
+(NSDate*)lastMinute;
+(NSDate*)nextMinute;
+(NSDate*)weekStart;
+(NSDate*)lastWeek;
+(NSDate*)nextWeek;
+(NSDate*)monthStart;
+(NSDate*)lastMonth;
+(NSDate*)nextMonth;

+(NSDate*)now       :(NSString*)timezone;
+(NSDate*)today     :(NSString*)timezone;
+(NSDate*)yesterday :(NSString*)timezone;
+(NSDate*)tomorrow  :(NSString*)timezone;
+(NSDate*)thisMinute:(NSString*)timezone;
+(NSDate*)lastMinute:(NSString*)timezone;
+(NSDate*)nextMinute:(NSString*)timezone;
+(NSDate*)weekStart :(NSString*)timezone;
+(NSDate*)lastWeek  :(NSString*)timezone;
+(NSDate*)nextWeek  :(NSString*)timezone;
+(NSDate*)monthStart:(NSString*)timezone;
+(NSDate*)lastMonth :(NSString*)timezone;
+(NSDate*)nextMonth :(NSString*)timezone;

-(NSDate*)today;
-(NSDate*)yesterday;
-(NSDate*)tomorrow;
-(NSDate*)thisMinute;
-(NSDate*)lastMinute;
-(NSDate*)nextMinute;
-(NSDate*)weekStart;
-(NSDate*)lastWeek;
-(NSDate*)nextWeek;
-(NSDate*)monthStart;
-(NSDate*)lastMonth;
-(NSDate*)nextMonth;

+(NSDate*)parse:(NSString*)datestring;
+(NSDate*)parse:(NSString*)datestring timezone:(NSString*)timezone;

+(NSDate*)dateFor:(NSString*)dateType date:(NSDate*)date;
+(NSDate*)dateFor:(NSString*)dateType;
+(NSDate*)dateFor:(NSString*)dateType timeZone:(NSString*)timezone date:(NSDate*)date;

-(NSString*)toDateTimeString;
-(NSString*)toDateString;
-(NSString*)toDeviceTimezoneString;
-(NSString*)toDeviceTimezoneDateString;
-(NSString*)format:(NSString*)format;
-(NSString*)format:(NSString*)format timezone:(NSString*)timezone;
-(NSString*)formatWithFormatter:(NSDateFormatter*)formatter;

//============================================
#pragma mark - Components
//============================================
/*-(NSInteger)year;
-(NSInteger)month;
-(NSInteger)day;
-(NSInteger)hour;
-(NSInteger)minute;
-(NSInteger)second;*/

-(NSDate*)withHour  :(int)hour;
-(NSDate*)withHour  :(int)hour timezone:(NSString*)timezone;
-(NSDate*)withMinute:(int)minute;
-(NSDate*)withSecond:(int)second;
-(NSDate*)withYear  :(int)year;
-(NSDate*)withMonth :(int)year;
-(NSDate*)withDay   :(int)year;

//============================================
#pragma mark - Diffs
//============================================
-(NSInteger)diffInDays:(NSDate*)toDateTime;

//============================================
#pragma mark - Operations
//============================================
-(NSDate*)addYear;
-(NSDate*)addYears:(NSInteger)amount;
-(NSDate*)substractYear;
-(NSDate*)substractYears:(NSInteger)amount;

-(NSDate*)addMonth;
-(NSDate*)addMonths:(NSInteger)amount;
-(NSDate*)substractMonth;
-(NSDate*)substractMonths:(NSInteger)amount;

-(NSDate*)addWeek;
-(NSDate*)addWeeks:(NSInteger)amount;
-(NSDate*)substractWeek;
-(NSDate*)substractWeeks:(NSInteger)amount;

-(NSDate*)addDay;
-(NSDate*)addDays:(NSInteger)amount;
-(NSDate*)substractDay;
-(NSDate*)substractDay:(NSInteger)amount;

-(NSDate*)addHour;
-(NSDate*)addHours:(NSInteger)amount;
-(NSDate*)substractHour;
-(NSDate*)substractHours:(NSInteger)amount;

-(NSDate*)addMinute;
-(NSDate*)addMinutes:(NSInteger)amount;
-(NSDate*)substractMinute;
-(NSDate*)substractMinutes:(NSInteger)amount;

-(NSDate*)addSecond;
-(NSDate*)addSeconds:(NSInteger)amount;
-(NSDate*)substractSecond;
-(NSDate*)substractSeconds:(NSInteger)amount;

//============================================
#pragma mark - Setters
//============================================
-(NSDate*)setTime:(NSString*)time;
-(NSDate*)setTime:(NSString*)time timezone:timezone;
@end
