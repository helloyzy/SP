//
//  TaskViewController.h
//  SP
//
//  Created by spark pan on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UIViewController<UITableViewDataSource> {
    
    IBOutlet UITableView * myTableView;
    IBOutlet UIBarButtonItem *buttonItem;
    UIPopoverController *popoverController;
    NSArray * taskInfoName;
    NSArray * taskInfoValue;
}
@property (nonatomic, retain) IBOutlet UITableView * myTableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *buttonItem;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) NSArray * taskInfoName;
@property (nonatomic, retain) NSArray * taskInfoValue;

- (IBAction)toggleMasterView:(id)sender;
@end
