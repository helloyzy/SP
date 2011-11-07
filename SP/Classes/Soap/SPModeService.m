//
//  SPModeService.m
//  SP
//
//  Created by Whitman Yang on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPModeService.h"

@implementation SPModeService

#pragma mark - protected methods implementations

- (void) prepareUrlAndHeadProps {
    self.serviceUrl = SP_SOAP_URL_MODE;
    [self addSoapActionHeadProp:@"Mode"];
}

- (id) parseResponseWithXml:(RXMLElement *)xml {
    return xml;
}

@end
