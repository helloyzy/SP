//
//  SoapUtil.m
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapUtil.h"
#import "SoapEnveloper.h"
#import "Macros.h"

@implementation SoapUtil

+ (NSURLRequest *) buildRequestWithUrl:(NSString *)urlString soapMsg:(SoapEnveloper *)message headProps:(NSDictionary *)headProps {
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * messageString = [message toString];    
    NSString * msgLength = STRINGIFY_INT(messageString.length);
    
    // add default head properties
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"sharepoint.perficient.com" forHTTPHeaderField:@"Host"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
    // add customized properties
    if (headProps) {
        for (NSString * headField in headProps.keyEnumerator) {
            [theRequest addValue:[headProps objectForKey:headField] forHTTPHeaderField:headField];
        }
    }
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [messageString dataUsingEncoding:NSUTF8StringEncoding]]; 
    return theRequest;
}

+ (NSURLRequest *) buildRequestWithUrl:(NSString *)url soapMsg:(SoapEnveloper *)message {
    return [self buildRequestWithUrl:url soapMsg:message headProps:nil];    
}

@end
