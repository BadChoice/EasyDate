//
//  EasyDateTests.m
//  EasyDateTests
//
//  Created by Jordi Puigdellívol on 13/8/16.
//  Copyright © 2016 revo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+Easy.h"

@interface EasyDateTests : XCTestCase

@end

@implementation EasyDateTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    NSDate* testDate = [NSDate parse:@"2016-01-01 18:00:00"];
    NSLog(@"TESTDATE: %@",testDate.description);
    NSLog(@"TESTDATE: %@",testDate.toDateTimeString);
    NSLog(@"TESTDATE: %@",testDate.toDeviceTimezoneString);
    
    NSDate* testDate2 = NSDate.now;
    NSLog(@"TESTDATE 2: %@",testDate2.description);
    NSLog(@"TESTDATE 2: %@",testDate2.toDateTimeString);
    NSLog(@"TESTDATE 2: %@",testDate2.toDeviceTimezoneString);
}

-(void)testDateFor{
    NSLog(@"Today (Device): %@",NSDate.today.toDeviceTimezoneString);
    NSLog(@"Today:      %@",NSDate.today);
    NSLog(@"Yesterday:  %@",NSDate.yesterday);
    NSLog(@"Tomorrow:   %@",NSDate.tomorrow);
    NSLog(@"-------------------------------------");
    NSLog(@"This week:  %@",NSDate.thisWeek);
    NSLog(@"Last week:  %@",NSDate.lastWeek);
    NSLog(@"Next week:  %@",NSDate.nextWeek);
    NSLog(@"-------------------------------------");
    NSLog(@"This month: %@",NSDate.thisMonth);
    NSLog(@"Last month: %@",NSDate.lastMonth);
    NSLog(@"Next month: %@",NSDate.nextMonth);
    NSLog(@"-------------------------------------");
}

-(void)testAddDate{
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
