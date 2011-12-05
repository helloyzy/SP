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
@synthesize listDescription;
@synthesize type;
@synthesize fileRef;

@synthesize listName;

@synthesize assignTo, status, priority, dueDate, percentComplete;

- (void) dealloc {
    self.title = nil;
    self.listDescription = nil;
    self.type = nil;
    self.fileRef = nil;

    self.listName = nil;

    self.assignTo = nil;
    self.status = nil;
    self.priority = nil;
    self.dueDate = nil;
    self.percentComplete = nil;
    [super dealloc];
}
@end
