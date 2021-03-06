//
//  SPSimpleSoapRequest.h
//  SP
//
//  Created by Whitman Yang on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSoapRequest.h"

@interface SPSimpleSoapRequest : SPSoapRequest

@property (nonatomic, retain) NSString * rootTagName;
@property (nonatomic, retain) NSString * rootDefaultNS;

+ (SPSimpleSoapRequest *) soapRequest;
+ (SPSimpleSoapRequest *) soapRequestWithDirectoryNS;
- (void) addElement:(NSString *)tagName withStringValue:(NSString *)value;

@end
 