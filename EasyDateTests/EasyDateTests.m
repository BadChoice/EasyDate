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

-(void)testSetTime{
    XCTAssertTrue( [@"2016-08-10 10:34:12" isEqualToString:[self.controlDate setTime:@"10:34:12" ].toDateTimeString]);
    XCTAssertTrue( [@"2016-08-10 08:34:12" isEqualToString:[self.controlDate setTime:@"10:34:12" timezone:@"device"].toDateTimeString]);
}

-(void)testDifference{
    XCTAssertTrue( 22   == [self.controlDate            diffInDays:self.controlDate.nextMonth]);
    XCTAssertTrue( -22  == [self.controlDate.nextMonth  diffInDays:self.controlDate]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
