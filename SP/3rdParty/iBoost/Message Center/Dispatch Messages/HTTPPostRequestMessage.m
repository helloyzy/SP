//
//  HTTPPostRequestMessage.m
//  Broadway
//
//  Created by John Blanco on 10/7/11.
//  Copyright (c) 2011 Rapture In Venice. All rights reserved.
//

#import "HTTPPostRequestMessage.h"
#import <UIKit/UIKit.h>
#import "Macros.h"
#import "MessageCenter.h"
#import "Functions.h"

@implementation HTTPPostRequestMessage

+ (id)messageWithName:(NSString *)name userInfo:(NSDictionary *)userInfo url:(NSString *)url body:(NSString *)body {
	HTTPPostRequestMessage *message = [[HTTPPostRequestMessage alloc] initWithName:name userInfo:userInfo];
	
	// must be async
	message.asynchronous = YES;
	
	message->_url = [url copy];
	message->_body = [body copy];
	
	// autorelease
	return [message autorelease];
}

- (void)dealloc {
	[_url release];
    [_body release];
	[_responseData release];
	[super dealloc];
}

#pragma mark -

- (void)inputData:(NSData *)input {
	NSString *subbedURL = _url;
	NSError *error = nil;
	NSHTTPURLResponse *response = nil;
	
	// perform substitutions on URL
	for (NSString *key in self.userInfo) {
		NSString *subToken = [NSString stringWithFormat:@"[%@]", key];
        
		if ([[self.userInfo objectForKey:key] isKindOfClass:NSString.class]) {
            subbedURL = [subbedURL stringByReplacingOccurrencesOfString:subToken withString:[(NSString *)[self.userInfo objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
	}
    
	// debug
    if ([MessageCenter isDebuggingEnabled]) {
        NSLog(@"OPEN URL: %@", subbedURL);
    }
	
	// generate request
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:subbedURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[_body dataUsingEncoding:NSUTF8StringEncoding]];
	NSData *content = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
	if (!error) {
		_responseData = [content mutableCopy];
        
		if (response) {
            NSMutableDictionary *updatedUserInfo = [[self.userInfo mutableCopy] autorelease];
            [updatedUserInfo setObject:BOX_INT(response.statusCode) forKey:HTTP_STATUS_CODE];
            self.userInfo = updatedUserInfo;
		}
	} else {
		_responseData = nil;
	}
}

- (NSData *)outputData {
	return _responseData;
}

@end
