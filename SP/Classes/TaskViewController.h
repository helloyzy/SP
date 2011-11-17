//
//  TaskViewController.h
//  SP
//
//  Created by spark pan on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UITableViewController {
    
    IBOutlet UITableView * myTableView;
}

@property (nonatomic, retain) UITableView * myTableView;

@end
