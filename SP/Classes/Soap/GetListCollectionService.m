//
//  GetListCollectionService.m
//  SP
//
//  Created by spark pan on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetListCollectionService.h"
#import "SoapUtil.h"
#import "SoapEnveloper.h"
#import "ListInfo.h"
#import "GDataXMLNode.h"
@implementation GetListCollectionService 

@synthesize listInfo;
@synthesize  listOfItems;
@synthesize  delegate;

- (void) request {
    if (listInfo) {
        SoapEnveloper * soapEnveloper = [[SoapEnveloper alloc] init];
        [soapEnveloper write:listInfo];
        NSURLRequest * request = [SoapUtil buildRequestWithUrl:@"https://sharepoint.perficient.com/sites/SP/_vti_bin/Lists.asmx" soapMsg:soapEnveloper headProps:nil];
               
        NSMutableURLRequest *mutableReqeust = (NSMutableURLRequest *)request;
        [mutableReqeust addValue:@"http://schemas.microsoft.com/sharepoint/soap/GetListCollection" forHTTPHeaderField:@"SOAPAction"];
        
        [soapEnveloper release];
        [self sendSoapRequest:request];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {	
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];        
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:nil];
    
    NSDictionary *ns = [NSDictionary dictionaryWithObjectsAndKeys:@"http://schemas.microsoft.com/sharepoint/soap/", @"sp", nil];
    
    
    NSLog(@"%@", string);
    
    static NSString *kXPath_Item = @"//sp:GetListCollectionResponse/sp:GetListCollectionResult/sp:Lists/sp:List";
    
    NSArray *listsData = [doc nodesForXPath:kXPath_Item namespaces:ns error:nil];
    
    NSLog(@"%d", [listsData count]);
    
    listOfItems = [[NSMutableArray alloc] init];
      
    for (GDataXMLElement *item in listsData) {
        //ListInfo *listItem = [[ListInfo alloc] init];
        //listItem.title = [[[item attributes] objectAtIndex:4] stringValue];
        //listItem.description = [[[item attributes] objectAtIndex:5] stringValue];
        
        [listOfItems addObject:[[[item attributes] objectAtIndex:4] stringValue]];
    }
       NSLog(@"%@", listOfItems);
    
    //Is anyone listening
    if([delegate respondsToSelector:@selector(dataSourceReturn:)])
    {
        //send the delegate function with the amount entered by the user
        [delegate dataSourceReturn:listOfItems];
    }
    
    
    [string release];
    responseData = nil;
    connection = nil;
    
}

- (void) dealloc {
    self.listInfo = nil;
    [super dealloc];
}
@end
