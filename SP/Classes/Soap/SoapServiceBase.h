//
//  SoapServiceBase.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapEnveloper.h"

@class SoapEnveloper;
@class SoapRequest;

@interface SoapServiceBase : NSObject

@property (nonatomic, retain) SoapRequest * soapRequestParam;

- (void) request;

@end

@interface SoapServiceBase (Protected) 

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper;
- (void) fail:(NSString *)description;

- (id) parseResponse:(NSString *)responseString;
- (void) sendNotificationOnSuccess:(id)value;
- (void) sendNotificationOnFailure:(NSString *)reason;

@end
