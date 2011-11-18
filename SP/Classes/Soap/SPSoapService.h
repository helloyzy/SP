//
//  SPSoapService.h
//  SP
//
//  Created by Whitman Yang on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapServiceBase.h"
#import "RXMLElement.h"
#import "SPConst.h"

@interface SPSoapService : SoapServiceBase

@property (nonatomic, retain) NSMutableDictionary * headProps;
@property (nonatomic, retain) NSString * serviceUrl;

@end

@interface SPSoapService (Protected) 

- (void) addHeadProp:(NSString *)key withValue:(id)value;
- (void) addSoapActionHeadProp:(NSString *)soapAction;
- (void) buildServiceUrlWithName:(NSString *)serviceName;

- (id) parseResponseWithXml:(RXMLElement *)xml;
- (void) prepareUrlAndHeadProps;


@end
