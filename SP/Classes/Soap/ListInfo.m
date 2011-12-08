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
@synthesize listItemID;
@synthesize listName;
@synthesize assignTo, status, priority, dueDate, percentComplete;

- (void) dealloc {
    [title release];
    [listDescription release];
    [type release];
    [fileRef release];
    [listItemID release];
    [listName release];
    [assignTo release];
    [status release];
    [priority release];
    [dueDate release];
    [percentComplete release];
    [super dealloc];
}
@end
