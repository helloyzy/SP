//
//  SoapUtil.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoapEnveloper;

@interface SoapUtil : NSObject

+ (NSURLRequest *) buildRequestWithUrl:(NSString *)url soapMsg:(SoapEnveloper *)message headProps:(NSDictionary *)headProps;
+ (NSURLRequest *) buildRequestWithUrl:(NSString *)url soapMsg:(SoapEnveloper *)message;

@end
