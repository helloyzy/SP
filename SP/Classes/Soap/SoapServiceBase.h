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

@interface SoapServiceBase : NSObject {
    BOOL _isShowProgressIndicator;
    NSString * _progressIndicatorMsg;
}

@property (nonatomic, retain) NSObject * errorObj; // for child class to set error information
@property (nonatomic, retain) SoapRequest * soapRequestParam;

- (void) enableProgressIndicatorWithMsg:(NSString *)msg;
- (void) request;

@end

@interface SoapServiceBase (Protected) 

- (void) fail:(NSString *)description;
- (void) failWithErrorInfo:(id)errorInfo;

- (NSURLRequest *) buildRequest:(SoapEnveloper *)enveloper;
- (id) parseResponse:(NSString *)responseString;
- (NSString *) parseError;
- (void) sendNotificationOnSuccess:(id)value;
- (void) sendNotificationOnFailure:(id)errorInfo;

@end
