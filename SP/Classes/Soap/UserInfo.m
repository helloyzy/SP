//
//  UserInfo.m
//  SP
//
//  Created by spark pan on 12/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize userID, userName, loginName, email;

- (void) dealloc {
    [userID release];
    [userName release];
    [loginName release];
    [email release];
    [super dealloc];
}

@end
