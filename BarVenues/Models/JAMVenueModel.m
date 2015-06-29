//
//  JAMVenueModel.m
//  BarVenues
//
//  Created by jose on 6/28/15.
//  Copyright (c) 2015 jose. All rights reserved.
//

#import "JAMVenueModel.h"

@implementation JAMVenueModel

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
