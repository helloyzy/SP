//
//  GetUserInfo.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetUserInfo.h"

@implementation GetUserInfo 

@synthesize userLoginName;

- (void) write:(XMLWriter *)writer {
    [super write:writer];
    [writer writeStartElement:@"GetUserInfo"];
    [writer writeElement:@"userLoginName" withStringValue:userLoginName];
    [writer writeEndElement];
}

- (void) dealloc {
    self.userLoginName = nil;
    [super dealloc];
}

@end
