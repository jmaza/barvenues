//
//  JAMVenuesNetworkClient.m
//  BarVenues
//
//  Created by jose on 6/28/15.
//  Copyright (c) 2015 jose. All rights reserved.
//
//
#import "JAMVenuesNetworkClient.h"
#import <AFNetworkActivityIndicatorManager.h>

static NSString *const baseURL = @"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json";

@implementation JAMVenuesNetworkClient

+ (instancetype)sharedInstance{
    static JAMVenuesNetworkClient *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    
    return _sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    [self.reachabilityManager startMonitoring];
    
    return self;
}

#pragma mark - Blocks
- (void)fetchVenuesSucessBlock:(FetchVenuesSuccessBlock)successBlock failureBlock:(FetchVenuesFailureBlock)failureBlock{
    NSURL *url = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [operation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
    [operation start];
}

@end
