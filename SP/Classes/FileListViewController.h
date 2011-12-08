//
//  FileListViewController.h
//  SP
//
//  Created by sarshern.lin on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListInfo.h"

@interface FileListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *myTable;
    NSArray *fileList;
    NSMutableData *responseData;
    NSIndexPath *indexPathForSelectRow;
    UIActivityIndicatorView *indicator;
    UIAlertView *myAlertView;
    ListInfo * taskInfo;
}
@property(nonatomic,retain)IBOutlet UITableView *myTable;
@property(nonatomic,retain)NSArray *fileList;
@property(nonatomic,retain)NSIndexPath *indexPathForSelectRow;
@property(nonatomic,retain)UIActivityIndicatorView *indicator;
@property(nonatomic,retain)UIAlertView *myAlertView;
@property(nonatomic,retain)ListInfo * taskInfo;

-(void)attachSelectFile;

@end
