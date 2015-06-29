//
//  JAMMasterViewController.m
//  BarVenues
//
//  Created by jose on 6/27/15.
//  Copyright (c) 2015 jose. All rights reserved.
//

#import "JAMMasterViewController.h"
#import "JAMDetailViewController.h"
#import "AFNetworking.h"
#import "JAMVenuesNetworkClient.h"
#import "JAMVenueModel.h"
#import "MBProgressHUD.h"


@interface JAMMasterViewController () {
    NSMutableArray *_objects;
}
@property NSMutableArray *venueObjects;
@end

@implementation JAMMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = addButton;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self makeVenueRequests];
    self.detailViewController = (JAMDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)refresh:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self makeVenueRequests];
    
}

-(void)makeVenueRequests{
    
    [[JAMVenuesNetworkClient sharedInstance] fetchVenuesSucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error;
            self.venueObjects = [JAMVenueModel arrayOfModelsFromData:(NSData *)responseObject error:&error];
            if (error != nil) {
                NSLog(@"Error parsing JSON");
            }
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Request Failed: %@, %@", error, error.userInfo);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Venues"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];

        }];
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.venueObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    JAMVenueModel *venue = self.venueObjects[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", venue.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@ %@",venue.address, venue.city, venue.state, venue.zip ];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.detailViewController.detailItem = self.venueObjects[indexPath.row];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setDetailItem:self.venueObjects[indexPath.row]];
    }
}

@end
