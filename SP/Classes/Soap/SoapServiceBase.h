//
//  SoapServiceBase.h
//  TestSharePoint
//
//  Created by Whitman Yang on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapServiceBase : NSObject

- (void) sendSoapRequest:(NSURLRequest *)request;

@end
