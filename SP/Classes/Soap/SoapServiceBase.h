//
//  SoapServiceBase.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapEntity.h"
#import "SoapEnveloper.h"

@class SoapEnveloper;

@interface SoapServiceBase : NSObject

@property (nonatomic, retain) SoapEntity * soapRequestParam;

- (void) request;

@end

@interface SoapServiceBase (Protected) 

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper;

- (id) parseResponse:(NSString *)responseString;
- (void) sendNotificationOnSuccess:(id)value;

@end
