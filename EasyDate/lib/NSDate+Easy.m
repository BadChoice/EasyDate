//
//  NSDate+Easy.m
//  EasyDate
//
//  Created by Jordi Puigdellívol on 13/8/16.
//  Copyright © 2016 revo. All rights reserved.
//

#import "NSDate+Easy.h"
#import "NSDate+DateTools.h"

#define strEqual(A,B) [A.lowercaseString isEqualToString:B.lowercaseString]

@implementation NSDate (Easy)

//============================================
#pragma mark - Named Constructors
//============================================
+(NSDate*)now       { return [self dateFor:@"now"];         }
+(NSDate*)today     { return [self dateFor:@"today"];       }
+(NSDate*)yesterday { return [self dateFor:@"yesterday"];   }
+(NSDate*)tomorrow  { return [self dateFor:@"tomorrow"];    }
+(NSDate*)thisWeek  { return [self dateFor:@"thisWeek"];    }
+(NSDate*)lastWeek  { return [self dateFor:@"lastWeek"];    }
+(NSDate*)nextWeek  { return [self dateFor:@"nextWeek"];    }
+(NSDate*)thisMonth { return [self dateFor:@"thisMonth"];   }
+(NSDate*)lastMonth { return [self dateFor:@"lastMonth"];   }
+(NSDate*)nextMonth { return [self dateFor:@"nextMonth"];   }

//============================================
#pragma mark - Parse Constructors
//============================================
+(NSDate*)parse:(NSString*)datestring{
    return [self parse:datestring timezone:@"UTC"];
}

+(NSDate*)parse:(NSString*)datestring timezone:(NSString*)timezone{
    NSDate * date = [self.class dateFor:datestring timeZone:timezone];
    if(date) return date;
    
    NSDateFormatter * formatter = [self.class formatter:nil timezone:timezone];
    return [formatter dateFromString:datestring];
}

+(NSDate*)dateFor:(NSString*)dateType{
    return [self dateFor:dateType timeZone:@"UTC"];
}

+(NSDate*)dateFor:(NSString*)dateType timeZone:(NSString*)timezone{
    if( strEqual(dateType,@"now") ) {
        return NSDate.date;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps =
    [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                fromDate:NSDate.date];
    
    [comps setTimeZone:[self.class makeTimezone:timezone]];
    
    if( strEqual(dateType,@"yesterday") ) {
        comps.day--;
    }
    else if( strEqual(dateType,@"tomorrow") ) {
        comps.day++;
    }
    else if( strEqual(dateType,@"thisWeek") ) {
        comps.weekday = calendar.firstWeekday;
    }
    else if( strEqual(dateType,@"lastWeek") ) {
        comps.weekday = calendar.firstWeekday;
        comps.weekOfYear--;
    }
    else if( strEqual(dateType,@"nextWeek") ) {
        comps.weekday = calendar.firstWeekday;
        comps.weekOfYear++;
    }
    else if( strEqual(dateType,@"thisMonth") ) {
        comps.day = 1;
    }
    else if( strEqual(dateType,@"lastMonth") ) {
        comps.day = 1;
        comps.month--;
    }
    else if( strEqual(dateType,@"nextMonth") ) {
        comps.day = 1;
        comps.month++;
    }
    else if(!strEqual(dateType,@"today"))
        return nil;
    
    return [calendar dateFromComponents:comps];
}

//============================================
#pragma mark - String
//============================================
-(NSString*)toDateTimeString{
    return [self format:EASYDATE_DEFAULT_DATETIME_FORMAT timezone:@"UTC"];
}

-(NSString*)toDateString{
    return [self format:EASYDATE_DEFAULT_DATE_FORMAT timezone:@"UTC"];
}

-(NSString*)toDeviceTimezoneString{
    return [self format:EASYDATE_DEFAULT_DATETIME_FORMAT timezone:@"device"];
}

-(NSString*)format:(NSString*)format{
    return [self format:format timezone:@"UTC"];
}

-(NSString*)format:(NSString*)format timezone:(NSString*)timezone{
    return [[self.class formatter:format timezone:timezone] stringFromDate:self];
}

/*+(NSString*)dateToDeviceTimezone:(NSString*)gmtDateString{
    
    if(gmtDateString == nil || [gmtDateString isEqual:[NSNull null]]) return nil;
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:EASYDATE_DEFAULT_DATETIME_FORMAT];
    
    //Create the date assuming the given string is in GMT
    df.timeZone     = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDate *date    = [df dateFromString:gmtDateString];
    
    //Create a date string in the local timezone
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    
    NSString *localDateString = [df stringFromDate:date];
    return localDateString;
}*/

//============================================
#pragma mark - Components
//============================================
-(NSInteger)year    { return self.year;     }
-(NSInteger)month   { return self.month;    }
-(NSInteger)day     { return self.day;      }
-(NSInteger)hour    { return self.hour;     }
-(NSInteger)minute  { return self.minute;   }
-(NSInteger)second  { return self.second;   }

//============================================
#pragma mark - Operations
//============================================
-(NSDate*)addYear                               { return [self dateByAddingYears:1];                }
-(NSDate*)addYears:(NSInteger)amount            { return [self dateByAddingYears:amount];           }
-(NSDate*)substractYear                         { return [self dateBySubtractingYears:1];           }
-(NSDate*)substractYears:(NSInteger)amount      { return [self dateBySubtractingYears:amount];      }

-(NSDate*)addMonth                              { return [self dateByAddingMonths:1];               }
-(NSDate*)addMonths:(NSInteger)amount           { return [self dateByAddingMonths:amount];          }
-(NSDate*)substractMonth                        { return [self dateBySubtractingMonths:1];          }
-(NSDate*)substractMonths:(NSInteger)amount     { return [self dateBySubtractingMonths:amount];     }

-(NSDate*)addWeek                               { return [self dateByAddingWeeks:1];                }
-(NSDate*)addWeeks:(NSInteger)amount            { return [self dateByAddingWeeks:amount];           }
-(NSDate*)substractWeek                         { return [self dateBySubtractingWeeks:1];           }
-(NSDate*)substractWeeks:(NSInteger)amount      { return [self dateBySubtractingWeeks:amount];      }

-(NSDate*)addDay                                { return [self dateByAddingDays:1];                 }
-(NSDate*)addDays:(NSInteger)amount             { return [self dateByAddingDays:amount];            }
-(NSDate*)substractDay                          { return [self dateBySubtractingDays:1];            }
-(NSDate*)substractDay:(NSInteger)amount        { return [self dateBySubtractingDays:amount];       }

-(NSDate*)addHour                               { return [self dateByAddingHours:1];                }
-(NSDate*)addHours:(NSInteger)amount            { return [self dateByAddingHours:amount];           }
-(NSDate*)substractHour                         { return [self dateBySubtractingHours:1];           }
-(NSDate*)substractHours:(NSInteger)amount      { return [self dateBySubtractingHours:amount];      }

-(NSDate*)addMinute                             { return [self dateByAddingMinutes:1];              }
-(NSDate*)addMinutes:(NSInteger)amount          { return [self dateByAddingMinutes:amount];         }
-(NSDate*)substractMinute                       { return [self dateBySubtractingMinutes:1];         }
-(NSDate*)substractMinutes:(NSInteger)amount    { return [self dateBySubtractingMinutes:amount];    }

-(NSDate*)addSecond                             { return [self dateByAddingSeconds:1];              }
-(NSDate*)addSeconds:(NSInteger)amount          { return [self dateByAddingSeconds:amount];         }
-(NSDate*)substractSecond                       { return [self dateBySubtractingSeconds:1];         }
-(NSDate*)substractSeconds:(NSInteger)amount    { return [self dateBySubtractingSeconds:amount];    }

//============================================
#pragma mark - Setters
//============================================
-(NSDate*)setTime:(NSString*)time{
    return [self setTime:time timezone:@"UTC"];
}

-(NSDate*)setTime:(NSString*)time timezone:timezone{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps =
    [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                fromDate:NSDate.date];
    
    [comps setTimeZone:[self.class makeTimezone:timezone]];
    
    NSArray* times = [time componentsSeparatedByString:@":"];    
    
    comps.hour      = [times[0] intValue];
    comps.minute    = [times[1] intValue];
    if(times.count == 3)
        comps.second    = [times[2] intValue];

    return [calendar dateFromComponents:comps];
}

//============================================
#pragma mark - Private Formatter
//============================================
+(NSDateFormatter*)formatter{
    return [self.class formatter:nil];
}

+(NSDateFormatter*)formatter:(NSString*)format{
    return [self.class formatter:format timezone:nil];
}

+(NSDateFormatter*)formatter:(NSString*)format timezone:(NSString*)timezone{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];;
    [formatter setDateFormat:format?format:EASYDATE_DEFAULT_DATETIME_FORMAT];
    
    if(timezone){
        [formatter setTimeZone:[self.class makeTimezone:timezone]];
    }
    return formatter;
}

+(NSTimeZone*)makeTimezone:(NSString*)timezone{
    if(strEqual(timezone, @"device")){
        return [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    }else{
        return [NSTimeZone timeZoneWithName:timezone];
    }
}

@end
