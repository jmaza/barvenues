//
//  JAMVenueModel.h
//  BarVenues
//
//  Created by jose on 6/28/15.
//  Copyright (c) 2015 jose. All rights reserved.
//

#import "JSONModel.h"

@interface JAMVenueModel : JSONModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSArray *schedule;

@end
