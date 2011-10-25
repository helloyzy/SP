//
//  main.m
//  SP
//
//  Created by Whitman Yang on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPAppDelegate.h"

int main(int argc, char *argv[])
{    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([SPAppDelegate class]));
    [pool release];
    return retVal;
}
