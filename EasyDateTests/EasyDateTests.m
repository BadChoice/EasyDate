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
@property NSDate *controlDate;
@property NSDate *edgeDate;
@end

@implementation EasyDateTests

- (void)setUp {
    
    self.controlDate = [NSDate parse:@"2016-08-10 18:00:12"];
    self.edgeDate    = [NSDate parse:@"2016-08-10 00:30:00" timezone:@"device"];
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testString {
    XCTAssertTrue( [@"2016-08-10 18:00:12 +0000"    isEqualToString:self.controlDate.description]);
    XCTAssertTrue( [@"2016-08-10 18:00:12"          isEqualToString:self.controlDate.toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 20:00:12"          isEqualToString:self.controlDate.toDeviceTimezoneString]);
    XCTAssertTrue( [@"2016-08-10"                   isEqualToString:self.controlDate.toDateString]);
    XCTAssertTrue( [@"10*08*2016"                   isEqualToString:[self.controlDate format:@"dd*MM*yyyy"]]);
    
    XCTAssertTrue( [@"2016-08-09 22:30:00 +0000"    isEqualToString:self.edgeDate.description]);
    XCTAssertTrue( [@"2016-08-09 22:30:00"          isEqualToString:self.edgeDate.toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 00:30:00"          isEqualToString:self.edgeDate.toDeviceTimezoneString]);
    XCTAssertTrue( [@"2016-08-09"                   isEqualToString:self.edgeDate.toDateString]);
    XCTAssertTrue( [@"09/08/2016"                   isEqualToString:[self.edgeDate format:@"dd/MM/yyyy"]]);
    XCTAssertTrue( [@"10/08/2016"                   isEqualToString:[self.edgeDate format:@"dd/MM/yyyy" timezone:@"device"]]);
    
    XCTAssertTrue( [@"2016-08-08"                   isEqualToString:[NSDate parse:@"2016-08-08"].toDateString]);
}

-(void)testDateFor{    
    
    XCTAssertTrue( [@"2016-08-10" isEqualToString:self.controlDate.today.toDateString]);
    XCTAssertTrue( [@"2016-08-11" isEqualToString:self.controlDate.tomorrow.toDateString]);
    XCTAssertTrue( [@"2016-08-09" isEqualToString:self.controlDate.yesterday.toDateString]);

    XCTAssertTrue( [@"2016-08-08" isEqualToString:self.controlDate.weekStart.toDateString]);
    XCTAssertTrue( [@"2016-08-01" isEqualToString:self.controlDate.lastWeek.toDateString]);
    XCTAssertTrue( [@"2016-08-15" isEqualToString:self.controlDate.nextWeek.toDateString]);
    
    XCTAssertTrue( [@"2016-08-01" isEqualToString:self.controlDate.monthStart.toDateString]);
    XCTAssertTrue( [@"2016-07-01" isEqualToString:self.controlDate.lastMonth.toDateString]);
    XCTAssertTrue( [@"2016-09-01" isEqualToString:self.controlDate.nextMonth.toDateString]);
}

-(void)testDateForMinutes{
    XCTAssertTrue( [@"2016-08-10 18:00:00" isEqualToString:self.controlDate.thisMinute.toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 18:01:00" isEqualToString:self.controlDate.nextMinute.toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 17:59:00" isEqualToString:self.controlDate.lastMinute.toDateTimeString]);
}

-(void)testSetTime{
    XCTAssertTrue( [@"2016-08-10 10:34:12" isEqualToString:[self.controlDate setTime:@"10:34:12" ].toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 08:34:12" isEqualToString:[self.controlDate setTime:@"10:34:12" timezone:@"device"].toDateTimeString]);
}

-(void)testDifference{
    XCTAssertTrue( 22   == [self.controlDate            diffInDays:self.controlDate.nextMonth]);
    XCTAssertTrue( -22  == [self.controlDate.nextMonth  diffInDays:self.controlDate]);
}

-(void)testSetComponents{
    
    XCTAssertTrue( [@"2016-08-10 10:00:12" isEqualToString:[self.controlDate withHour:10].toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 18:10:12" isEqualToString:[self.controlDate withMinute:10].toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 18:00:10" isEqualToString:[self.controlDate withSecond:10].toDateTimeString]);
    
    XCTAssertTrue( [@"2015-08-10 18:00:12" isEqualToString:[self.controlDate withYear:2015].toDateTimeString]);
    XCTAssertTrue( [@"2016-05-10 18:00:12" isEqualToString:[self.controlDate withMonth:5].toDateTimeString]);
    XCTAssertTrue( [@"2016-08-05 18:00:12" isEqualToString:[self.controlDate withDay:5].toDateTimeString]);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
