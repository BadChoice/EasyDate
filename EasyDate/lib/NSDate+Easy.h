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
+(NSDate*)thisWeek;
+(NSDate*)lastWeek;
+(NSDate*)nextWeek;
+(NSDate*)thisMonth;
+(NSDate*)lastMonth;
+(NSDate*)nextMonth;

+(NSDate*)parse:(NSString*)datestring;
+(NSDate*)parse:(NSString*)datestring timezone:(NSString*)timezone;

+(NSDate*)dateFor:(NSString*)dateType;
+(NSDate*)dateFor:(NSString*)dateType timeZone:(NSString*)timezone;

-(NSString*)toDateTimeString;
-(NSString*)toDateString;
-(NSString*)toDeviceTimezoneString;

@end
