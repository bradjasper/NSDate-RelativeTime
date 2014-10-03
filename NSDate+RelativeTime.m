//
//  NSDate+RelativeTime.m
//  NSDate-RelativeTime
//
//  Created by Bart van Zon on 10/20/13.
//  Copyright (c) 2013 Bart van Zon. All rights reserved.
//

#import "NSDate+RelativeTime.h"

@implementation NSDate (RelativeTime)

const int SECOND = 1;
const int MINUTE = 60*SECOND;
const int HOUR = 60*MINUTE;
const int DAY = HOUR*24;
const int WEEK = DAY*7;
const int MONTH = WEEK*4;
const int YEAR = DAY*365;

-(NSString *)relativeTime
{
    NSDate *currentDate = [NSDate date];
    int deltaSeconds = fabs(lroundf([self timeIntervalSinceDate:currentDate]));
    BOOL dateInFuture = ([self timeIntervalSinceDate:currentDate] > 0);
    
    if(deltaSeconds < MINUTE) {
        return [self formattedStringForCurrentDate:currentDate count:deltaSeconds past:@"%d seconds ago" future:@"%d seconds"];
    } else if(deltaSeconds < 1.5*MINUTE) {
        return !dateInFuture ? [self NSDateRelativeTimeLocalizedStrings: @"a minute ago"] : [self NSDateRelativeTimeLocalizedStrings: @"minute"];
    } else if(deltaSeconds < HOUR) {
        int minutes = (int)lroundf((float)deltaSeconds/(float)MINUTE);
        return [self formattedStringForCurrentDate:currentDate count:minutes past:@"%d minutes ago" future:@"%d minutes"];
    } else if(deltaSeconds < 1.5*HOUR) {
        return !dateInFuture ? [self NSDateRelativeTimeLocalizedStrings: @"An hour ago"] : [self NSDateRelativeTimeLocalizedStrings: @"hour"];
    } else if(deltaSeconds < DAY) {
        int hours = (int)lroundf((float)deltaSeconds/(float)HOUR);
        return [self formattedStringForCurrentDate:currentDate count:hours past:@"%d hours ago" future:@"%d hours"];
    } else if(deltaSeconds < 1.5*DAY) {
        return !dateInFuture ? [self NSDateRelativeTimeLocalizedStrings: @"a day ago"] : [self NSDateRelativeTimeLocalizedStrings: @"day"];
    } else if(deltaSeconds < WEEK) {
        int days = (int)lroundf((float)deltaSeconds/(float)DAY);
        return [self formattedStringForCurrentDate:currentDate count:days past:@"%d days ago" future:@"%d days"];
    } else if(deltaSeconds < 1.5*WEEK) {
        return !dateInFuture ? [self NSDateRelativeTimeLocalizedStrings: @"a week ago"] : [self NSDateRelativeTimeLocalizedStrings: @"week"];
    } else if(deltaSeconds < MONTH) {
        int weeks = (int)lroundf((float)deltaSeconds/(float)WEEK);
        return [self formattedStringForCurrentDate:currentDate count:weeks past:@"%d weeks ago" future:@"%d weeks"];
    } else if(deltaSeconds < 1.5*MONTH) {
        return !dateInFuture ? [self NSDateRelativeTimeLocalizedStrings: @"a month ago"] : [self NSDateRelativeTimeLocalizedStrings: @"month"];
    } else if(deltaSeconds < YEAR) {
        int months = (int)lroundf((float)deltaSeconds/(float)MONTH);
        return [self formattedStringForCurrentDate:currentDate count:months past:@"%d months ago" future:@"%d months"];
    } else if(deltaSeconds < 1.5*YEAR) {
        return !dateInFuture ? [self NSDateRelativeTimeLocalizedStrings: @"a year ago"] : [self NSDateRelativeTimeLocalizedStrings: @"year"];
    } else {
        int years = (int)lroundf((float)deltaSeconds/(float)YEAR);
        return [self formattedStringForCurrentDate:currentDate count:years past:@"%d years ago" future:@"%d years"];
    }
}

-(NSString *)formattedStringForCurrentDate:(NSDate *)currentDate count:(int)count past:(NSString *)past future:(NSString *)future
{
    if ([self timeIntervalSinceDate:currentDate] > 0) {
        return [NSString stringWithFormat: [self NSDateRelativeTimeLocalizedStrings: future], count];
    } else {
        return [NSString stringWithFormat: [self NSDateRelativeTimeLocalizedStrings: past], count];
    }
}

-(NSString *)NSDateRelativeTimeLocalizedStrings:(NSString *)key
{
    return NSLocalizedStringFromTableInBundle(key, @"NSDate+RelativeTime", [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NSDate+RelativeTime.bundle"]], nil);
}

@end
