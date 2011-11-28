//
//  LanguageListController.h
//  Presidents
//
//  Created by Dave Mark on 12/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListInfo.h"

@interface ItemMenuListController : UITableViewController {
	NSArray *menuNames;
     ListInfo * taskInfo;
}

@property (nonatomic, retain) NSArray *menuNames;
@property (nonatomic, retain) ListInfo * taskInfo;
@end
