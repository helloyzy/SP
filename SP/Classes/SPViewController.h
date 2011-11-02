//
//  SPViewController.h
//  SP
//
//  Created by Whitman Yang on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetListCollectionService.h"

@interface SPViewController : UIViewController <DataSourceDelegate> {
    NSMutableData* responseData;
    IBOutlet UITableView *tableview;
    NSMutableArray * listOfItems;
}

@property(nonatomic, retain) IBOutlet UITableView *tableview;
@property(nonatomic, retain) NSMutableArray *listOfItems;



@end
