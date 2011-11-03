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

- (void) write:(XMLWriter *)writer {
    [writer setDefaultNamespace:@"http://schemas.microsoft.com/sharepoint/soap/directory/"];
    [writer writeStartElement:@"GetListCollection"];
    [writer writeEndElement];
}

- (void) dealloc {
    self.title = nil;
    self.description = nil;
    [super dealloc];
}
@end
