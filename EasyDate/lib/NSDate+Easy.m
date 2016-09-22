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

static NSDateFormatter * cachedDateFormatter;
static NSDateFormatter * cachedDateTimeFormatter;
static NSDateFormatter * cachedDeviceTimezoneDateFormatter;
static NSDateFormatter * cachedDeviceTimezoneDateTimeFormatter;

//============================================
#pragma mark - Named Constructors
//============================================
+(NSDate*)now       { return [self dateFor:@"now"];         }
+(NSDate*)today     { return [self dateFor:@"today"];       }
+(NSDate*)yesterday { return [self dateFor:@"yesterday"];   }
+(NSDate*)tomorrow  { return [self dateFor:@"tomorrow"];    }
+(NSDate*)thisMinute{ return [self dateFor:@"thisMinute"];  }
+(NSDate*)lastMinute{ return [self dateFor:@"lastMinute"];  }
+(NSDate*)nextMinute{ return [self dateFor:@"nextMinute"];  }
+(NSDate*)weekStart { return [self dateFor:@"weekStart"];   }
+(NSDate*)lastWeek  { return [self dateFor:@"lastWeek"];    }
+(NSDate*)nextWeek  { return [self dateFor:@"nextWeek"];    }
+(NSDate*)monthStart{ return [self dateFor:@"monthStart"];  }
+(NSDate*)lastMonth { return [self dateFor:@"lastMonth"];   }
+(NSDate*)nextMonth { return [self dateFor:@"nextMonth"];   }

+(NSDate*)now       :(NSString*)timezone { return [self dateFor:@"now"        timeZone:timezone date:NSDate.date]; }
+(NSDate*)today     :(NSString*)timezone { return [self dateFor:@"today"      timeZone:timezone date:NSDate.date]; }
+(NSDate*)yesterday :(NSString*)timezone { return [self dateFor:@"yesterday"  timeZone:timezone date:NSDate.date]; }
+(NSDate*)tomorrow  :(NSString*)timezone { return [self dateFor:@"tomorrow"   timeZone:timezone date:NSDate.date]; }
+(NSDate*)thisMinute:(NSString*)timezone { return [self dateFor:@"thisMinute" timeZone:timezone date:NSDate.date]; }
+(NSDate*)lastMinute:(NSString*)timezone { return [self dateFor:@"lastMinute" timeZone:timezone date:NSDate.date]; }
+(NSDate*)nextMinute:(NSString*)timezone { return [self dateFor:@"nextMinute" timeZone:timezone date:NSDate.date]; }
+(NSDate*)weekStart :(NSString*)timezone { return [self dateFor:@"weekStart"  timeZone:timezone date:NSDate.date]; }
+(NSDate*)lastWeek  :(NSString*)timezone { return [self dateFor:@"lastWeek"   timeZone:timezone date:NSDate.date]; }
+(NSDate*)nextWeek  :(NSString*)timezone { return [self dateFor:@"nextWeek"   timeZone:timezone date:NSDate.date]; }
+(NSDate*)monthStart:(NSString*)timezone { return [self dateFor:@"monthStart" timeZone:timezone date:NSDate.date]; }
+(NSDate*)lastMonth :(NSString*)timezone { return [self dateFor:@"lastMonth"  timeZone:timezone date:NSDate.date]; }
+(NSDate*)nextMonth :(NSString*)timezone { return [self dateFor:@"nextMonth"  timeZone:timezone date:NSDate.date]; }

-(NSDate*)today     { return [self.class dateFor:@"today"       date:self];   }
-(NSDate*)yesterday { return [self.class dateFor:@"yesterday"   date:self];   }
-(NSDate*)tomorrow  { return [self.class dateFor:@"tomorrow"    date:self];   }
-(NSDate*)thisMinute{ return [self.class dateFor:@"thisMinute"  date:self];   }
-(NSDate*)lastMinute{ return [self.class dateFor:@"lastMinute"  date:self];   }
-(NSDate*)nextMinute{ return [self.class dateFor:@"nextMinute"  date:self];   }
-(NSDate*)weekStart { return [self.class dateFor:@"weekStart"   date:self];   }
-(NSDate*)lastWeek  { return [self.class dateFor:@"lastWeek"    date:self];   }
-(NSDate*)nextWeek  { return [self.class dateFor:@"nextWeek"    date:self];   }
-(NSDate*)monthStart{ return [self.class dateFor:@"monthStart"  date:self];   }
-(NSDate*)lastMonth { return [self.class dateFor:@"lastMonth"   date:self];   }
-(NSDate*)nextMonth { return [self.class dateFor:@"nextMonth"   date:self];   }

//============================================
#pragma mark - Parse Constructors
//============================================
+(NSDate*)parse:(NSString*)datestring{
    return [self parse:datestring timezone:@"UTC"];
}

+(NSDate*)parse:(NSString*)datestring timezone:(NSString*)timezone{
    NSDate * date = [self.class dateFor:datestring timeZone:timezone date:nil];
    if(date) return date;
    
    if(datestring.length == 19){
        NSDateFormatter * formatter = [self.class formatter:EASYDATE_DEFAULT_DATETIME_FORMAT timezone:timezone];
        return [formatter dateFromString:datestring];
    }
    else{
        NSDateFormatter * formatter = [self.class formatter:EASYDATE_DEFAULT_DATE_FORMAT timezone:timezone];
        return [formatter dateFromString:datestring];
    }
}

+(NSDate*)dateFor:(NSString*)dateType{
    return [self dateFor:dateType timeZone:@"UTC" date:NSDate.date];
}

+(NSDate*)dateFor:(NSString*)dateType date:(NSDate*)date{
    return [self dateFor:dateType timeZone:@"UTC" date:date];
}

+(NSDate*)dateFor:(NSString*)dateType timeZone:(NSString*)timezone date:(NSDate*)date{
    if( strEqual(dateType,@"now") ) {
        return NSDate.date;
    }
    
    if(!date) {
        date = NSDate.date;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit flags;
    
    if(strEqual(dateType,@"weekStart") || strEqual(dateType,@"lastWeek") || strEqual(dateType,@"nextWeek")){
        flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday );
    }
    else if(strEqual(dateType, @"thisMinute") || strEqual(dateType,@"nextMinute") || strEqual(dateType,@"lastMinute")){
        flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute);
        timezone = nil;
    }
    else{
        flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    }
    
    NSDateComponents *comps = [calendar components:flags fromDate:date];
    
    if(timezone){
        [comps setTimeZone:[self.class makeTimezone:timezone]];
    }
    
    if( strEqual(dateType,@"yesterday") ) {
        comps.day--;
    }
    else if( strEqual(dateType,@"tomorrow") ) {
        comps.day++;
    }
    else if( strEqual(dateType,@"thisMinute") ) {
        //comps.day++;
    }
    else if( strEqual(dateType,@"nextMinute") ) {
        comps.minute++;
    }
    else if( strEqual(dateType,@"lastMinute") ) {
        comps.minute--;
    }
    else if( strEqual(dateType,@"weekStart") ) {
        comps.weekday = 2; //Monday
    }
    else if( strEqual(dateType,@"lastWeek") ) {
        comps.weekday = 2; //Monday
        comps.weekOfYear--;
    }
    else if( strEqual(dateType,@"nextWeek") ) {
        comps.weekday = 2; //Monday
        comps.weekOfYear++;
    }
    else if( strEqual(dateType,@"monthStart") ) {
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
    
    NSDate* d = [calendar dateFromComponents:comps];
    return d;
}

//============================================
#pragma mark - Set Components
//============================================
-(NSDate*)withHour:(int)hour{
    return [self withHour:hour timezone:@"UTC"];
}

-(NSDate*)withHour:(int)hour timezone:(NSString*)timezone{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[self.class makeTimezone:timezone]];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    return [calendar dateBySettingHour:hour minute:comps.minute second:comps.second ofDate:self options:0];
}

-(NSDate*)withMinute:(int)minute{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitSecond) fromDate:self];
    return [calendar dateBySettingHour:comps.hour minute:minute second:comps.second ofDate:self options:0];
}

-(NSDate*)withSecond:(int)second{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self];
    return [calendar dateBySettingHour:comps.hour minute:comps.minute second:second ofDate:self options:0];
}

-(NSDate*)withYear  :(int)year{
    NSCalendar* calendar = NSCalendar.currentCalendar;
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    [comps setYear:year];
    return [NSCalendar.currentCalendar dateFromComponents:comps];
    
}
-(NSDate*)withMonth :(int)month{
    NSCalendar* calendar = NSCalendar.currentCalendar;
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    [comps setMonth:month];
    return [NSCalendar.currentCalendar dateFromComponents:comps];
}
-(NSDate*)withDay   :(int)day{
    NSCalendar* calendar = NSCalendar.currentCalendar;
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    [comps setDay:day];
    return [NSCalendar.currentCalendar dateFromComponents:comps];
}


//============================================
#pragma mark - String
//============================================
-(NSString*)toDateTimeString{
    return [self formatWithFormatter:self.class.cachedDateTimeFormatter];
}

-(NSString*)toDateString{
    return [self formatWithFormatter:self.class.cachedDateFormatter];
}

-(NSString*)toDeviceTimezoneString{
    return [self formatWithFormatter:self.class.cachedDeviceTimezoneDateTimeFormatter];
}

-(NSString*)toDeviceTimezoneDateString{
    return [self formatWithFormatter:self.class.cachedDeviceTimezoneDateFormatter];
}


-(NSString*)format:(NSString*)format{
    return [self format:format timezone:@"UTC"];
}

-(NSString*)format:(NSString*)format timezone:(NSString*)timezone{
    return [[self.class formatter:format timezone:timezone] stringFromDate:self];
}


-(NSString*)formatWithFormatter:(NSDateFormatter*)formatter{
    return [formatter stringFromDate:self];
}


//============================================
#pragma mark - Diff
//============================================
-(NSInteger)diffInDays:(NSDate*)toDateTime{
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate  interval:NULL forDate:self];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate    interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}


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
                fromDate:self];
    
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
    NSDateFormatter* formatter = [NSDateFormatter new];;
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

//============================================
#pragma mark - Formatter caches
//============================================
+(NSDateFormatter*)cachedDateTimeFormatter{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachedDateTimeFormatter = [self.class formatter:EASYDATE_DEFAULT_DATETIME_FORMAT timezone:@"UTC"];
    });
    return cachedDateTimeFormatter;
}

+(NSDateFormatter*)cachedDateFormatter{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachedDateFormatter = [self.class formatter:EASYDATE_DEFAULT_DATE_FORMAT timezone:@"UTC"];
    });
    return cachedDateFormatter;
}

+(NSDateFormatter*)cachedDeviceTimezoneDateFormatter{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachedDeviceTimezoneDateFormatter = [self.class formatter:EASYDATE_DEFAULT_DATE_FORMAT timezone:@"device"];
    });
    return cachedDeviceTimezoneDateFormatter;
}

+(NSDateFormatter*)cachedDeviceTimezoneDateTimeFormatter{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachedDeviceTimezoneDateTimeFormatter = [self.class formatter:EASYDATE_DEFAULT_DATETIME_FORMAT timezone:@"device"];
    });
    return cachedDeviceTimezoneDateTimeFormatter;
}

@end
