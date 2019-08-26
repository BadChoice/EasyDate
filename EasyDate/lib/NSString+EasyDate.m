//
//  NSString+EasyDate.m
//  EasyDate
//
//  Created by Jordi Puigdellívol on 14/8/16.
//  Copyright © 2016 revo. All rights reserved.
//

#import "NSString+EasyDate.h"
#import "NSDate+Easy.h"

@implementation NSString (EasyDate)

-(NSDate*)toDate{
    return [NSDate parse:self];
}

-(NSDate*)toDate:(NSString*)timezone{
    return [NSDate parse:timezone];
}

-(NSString*)timezoned{
    return [NSDate parse:self].toDeviceTimezoneString;
}

-(NSString*)dateTimezonedAndLocalized{
    return [NSDate parse:self].toDateTimezoneLocalized;
}

-(NSString*)dateTimeTimezonedAndLocalized{
    return [NSDate parse:self].toDateTimeTimezoneLocalized;
}

-(int)toSeconds{
    NSString *timeString = self;
    if (timeString.length > 8 ) timeString = [timeString substringFromIndex:11];
    int hours   = [timeString substringToIndex:2].intValue;
    int minutes = [timeString substringWithRange:NSMakeRange(3, 2)].intValue;
    int seconds = 0;
    if (timeString.length > 5) seconds = [timeString substringWithRange:NSMakeRange(6, 2)].intValue;
    return hours * 3600 + minutes * 60 + seconds;
}

-(int)toMinutes{
    NSString *timeString = self;
    if (timeString.length > 8 ) timeString = [timeString substringFromIndex:11];
    int hours   = [timeString substringToIndex:2].intValue;
    int minutes = [timeString substringWithRange:NSMakeRange(3, 2)].intValue;
    return hours * 60 + minutes;
}

@end
