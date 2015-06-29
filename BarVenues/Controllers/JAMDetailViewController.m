//
//  JAMDetailViewController.m
//  BarVenues
//
//  Created by jose on 6/27/15.
//  Copyright (c) 2015 jose. All rights reserved.
//

#import "JAMDetailViewController.h"
#import "JAMVenueDateFormatter.h"
#import "UIImageView+AFNetworking.h"
#import "JAMVenueModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Social/Social.h>

@interface JAMDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeTitle;
@property (weak, nonatomic) IBOutlet UILabel *placeAddressOne;
@property (weak, nonatomic) IBOutlet UILabel *placeAddressTwo;
- (void)configureView;
@end

@implementation JAMDetailViewController
@synthesize dateData;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    if (self.detailItem) {
        self.placeTitle.text = [self.detailItem name];
        self.placeAddressOne.text = [NSString stringWithFormat:@"%@",[self.detailItem address] ];
        self.placeAddressTwo.text = [NSString stringWithFormat:@"%@, %@, %@",[self.detailItem city], [(JAMVenueModel*)self.detailItem state] , [self.detailItem zip] ];
        [self.placeImageView sd_setImageWithURL:[NSURL URLWithString: [self.detailItem imageUrl] ]
                               placeholderImage:[UIImage imageNamed:@"venuePlaceHolder.jpg"]];
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    JAMVenueDateFormatter *trans = [[JAMVenueDateFormatter alloc] init];

    dateData = [trans FormattedDatesFromSchedules:[self.detailItem schedule]];
    [self.dateTableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)share:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Let's go to %@!",[self.detailItem name]]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.detailItem schedule] count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [dateData objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}




@end
