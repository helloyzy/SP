//
//  RootViewController.h
//  SP
//
//  Created by spark pan on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GetListCollectionService.h"
#import "GetListItemsService.h"

@class FirstDetailViewController;

@interface RootViewController : UIViewController <UITableViewDataSource> {	
	FirstDetailViewController *firstDetailViewController;   
    NSMutableData* responseData;
    NSMutableArray * listOfItems;
    IBOutlet UITableView * topListTableView;
}
@property (nonatomic, assign) IBOutlet FirstDetailViewController *firstDetailViewController;
@property(nonatomic, retain) NSMutableArray *listOfItems;
@property(nonatomic, retain) IBOutlet UITableView *topListTableView;
@property(nonatomic, retain) UIPopoverController * authenticatePopover;
@property(nonatomic, retain) IBOutlet UIBarButtonItem * siteItem;

- (IBAction) logonSites:(id)sender;
- (IBAction) refreshLists:(id)sender;
@end
