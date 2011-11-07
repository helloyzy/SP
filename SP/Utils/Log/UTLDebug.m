//
//  UTLDebug.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UTLDebug.h"

void UTLDebug(const char *fileName, int lineNumber, NSString * format, ...) {
    va_list args;
    va_start(args, format);
    static NSDateFormatter * debugFormatter = nil;
    if (!debugFormatter) {
        debugFormatter = [[NSDateFormatter alloc] init];
        [debugFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    }
    
    NSString * logmsg = [[NSString alloc] initWithFormat:format arguments:args];
    NSString * filePath = [[NSString alloc] initWithUTF8String:fileName];
    NSString * timeStamp = [debugFormatter stringFromDate:[NSDate date]];
    
    NSDictionary * infoDict = [[NSBundle mainBundle] infoDictionary];
    fprintf(stdout, "%s %s[%s:%d] %s\n",
            [timeStamp UTF8String],
            [[infoDict objectForKey:(NSString *)kCFBundleNameKey] UTF8String],
            [[filePath lastPathComponent] UTF8String],
            lineNumber,
            [logmsg UTF8String]);
    
    [logmsg release];
    [filePath release];
    va_end(args);
}

