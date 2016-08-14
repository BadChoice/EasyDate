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

@end
