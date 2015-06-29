//
//  JAMDetailViewController.h
//  BarVenues
//
//  Created by jose on 6/27/15.
//  Copyright (c) 2015 jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAMDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITableView *dateTableView;
@property (strong, nonatomic) NSArray *dateData;
@end
