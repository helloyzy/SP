//
//  EditTaskViewController.h
//  SP
//
//  Created by spark pan on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTaskViewController : UIViewController<UITableViewDataSource> {
    IBOutlet UITableView * taskTableView;
    NSMutableArray * taskInfoName;
    NSMutableArray * taskInfoValue;
    IBOutlet UIBarButtonItem* backButton;
    IBOutlet UIBarButtonItem* updateButton;
}

@property (nonatomic, retain) IBOutlet UITableView * taskTableView;
@property (nonatomic, retain) NSMutableArray * taskInfoName;
@property (nonatomic, retain) NSMutableArray * taskInfoValue;
@property (nonatomic, retain) UIBarButtonItem * backButton;
@property (nonatomic, retain) UIBarButtonItem * updateButton;
@property (nonatomic, assign) UIPopoverController * container;

- (IBAction)update:(id)sender;

- (IBAction)backToParent:(id)sender;
@end
