//
//  JAMVenueDateFormatter.m
//  BarVenues
//
//  Created by jose on 6/29/15.
//  Copyright (c) 2015 jose. All rights reserved.
//

#import "JAMVenueDateFormatter.h"

@implementation JAMVenueDateFormatter

-(NSArray *)FormattedDatesFromSchedules:(NSArray*)schedule{
    NSMutableArray *formattedDates = [[NSMutableArray alloc] init];
    NSDateFormatter *serverFormatter = [[NSDateFormatter alloc] init];
    [serverFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [serverFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    for (NSDictionary *dates in schedule){
        
        NSDate *theDate = [serverFormatter dateFromString:dates[@"start_date"]];
        NSDate *endDate = [serverFormatter dateFromString:dates[@"end_date"]];
        
        NSDateFormatter *userFormatter = [[NSDateFormatter alloc] init];
        NSDateFormatter *endFormatter = [[NSDateFormatter alloc] init];
        [userFormatter setDateFormat:@"EEEE M/dd h:mm a 'to '"];
        [endFormatter setDateFormat:@"h:mm a"];
        [userFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [endFormatter setTimeZone:[NSTimeZone localTimeZone]];
        
        [formattedDates addObject:[[userFormatter stringFromDate:theDate] stringByAppendingString:[endFormatter stringFromDate:endDate]]  ];
        
    }
    return formattedDates;
}


@end
