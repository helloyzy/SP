//
//  GetUserInfo.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetUserInfo.h"
#import "XMLSerializable.h"
#import "Macros.h"
#import "XMLWriter.h"

@implementation GetUserInfo 

@synthesize userLoginName;

- (void) write:(XMLWriter *)writer {
    [writer setDefaultNamespace:@"http://schemas.microsoft.com/sharepoint/soap/directory/"];
    [writer writeStartElement:@"GetUserInfo"];
    [writer writeStartElement:@"userLoginName"];
    [writer writeCharacters:userLoginName];
    [writer writeEndElement];
    [writer writeEndElement];
}

- (void) dealloc {
    SAFE_RELEASE(userLoginName);
    [super dealloc];
}

@end
