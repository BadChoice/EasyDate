//
//  NSString+EasyDate.h
//  EasyDate
//
//  Created by Jordi Puigdellívol on 14/8/16.
//  Copyright © 2016 revo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EasyDate)

-(NSDate*)toDate;
-(NSDate*)toDate:(NSString*)timezone;
-(NSString*)timezoned;
@end
