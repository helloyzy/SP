//
//  UTLDebug.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifdef UTLDEBUG
#define UTLLog(format...) UTLDebug(__FILE__, __LINE__, format)
#else
#define UTLLog(format...)
#endif

#import <Foundation/Foundation.h>

void UTLDebug(const char *fileName, int lineNumber, NSString * format, ...);


void SLog(NSString * format, ...);