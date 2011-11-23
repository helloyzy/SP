//
//  ListInfo.m
//  SP
//
//  Created by spark pan on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListInfo.h"

@implementation ListInfo

@synthesize title;
@synthesize description;
@synthesize type;
@synthesize fileRef;
<<<<<<< HEAD
@synthesize listName;
=======
@synthesize assignTo, status, priority, dueDate, percentComplete;
>>>>>>> add mockup UI for edit the item which type is task

- (void) dealloc {
    self.title = nil;
    self.description = nil;
    self.type = nil;
    self.fileRef = nil;
<<<<<<< HEAD
    self.listName = nil;
=======
    self.assignTo = nil;
    self.status = nil;
    self.priority = nil;
    self.dueDate = nil;
    self.percentComplete = nil;
>>>>>>> add mockup UI for edit the item which type is task
    [super dealloc];
}
@end
