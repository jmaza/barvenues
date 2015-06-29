//
//  JAMVenuesNetworkClient.h
//  BarVenues
//
//  Created by jose on 6/28/15.
//  Copyright (c) 2015 jose. All rights reserved.
//

//#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

typedef void (^FetchVenuesFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^FetchVenuesSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);

@interface JAMVenuesNetworkClient : AFHTTPSessionManager

+ (instancetype)sharedInstance;
- (instancetype)initWithBaseURL:(NSURL *)url;

#pragma mark - Blocks
- (void)fetchVenuesSucessBlock:(FetchVenuesSuccessBlock)successBlock failureBlock:(FetchVenuesFailureBlock)failureBlock;

@end
