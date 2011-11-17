//
//  LanguageListController.h
//  Presidents
//
//  Created by Dave Mark on 12/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LanguageListController : UITableViewController {
	NSArray *languageNames;
	NSArray *languageCodes;
}

@property (nonatomic, retain) NSArray *languageNames;
@property (nonatomic, retain) NSArray *languageCodes;

@end
