//
//  AttachmentGalleryViewController.h
//  SP
//
//  Created by sarshern.lin on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachmentGalleryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UITableView *myTableView;
    NSMutableArray *sections;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *sections;

-(void)buttonPressed:(id)sender;
-(void)loadData;
@end

