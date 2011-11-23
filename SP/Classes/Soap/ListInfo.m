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
@synthesize listName;

- (void) dealloc {
    self.title = nil;
    self.description = nil;
    self.type = nil;
    self.fileRef = nil;
    self.listName = nil;
    [super dealloc];
}
@end
