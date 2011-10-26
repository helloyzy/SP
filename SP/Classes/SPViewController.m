//
//  SPViewController.m
//  SP
//
//  Created by Whitman Yang on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPViewController.h"
#import "GetUserInfo.h"
#import "GetUserInfoService.h"

@implementation SPViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    GetUserInfo * userInfo = [[GetUserInfo alloc] init];
    userInfo.userLoginName = @"Perficient\\spark.pan";
    GetUserInfoService * userInfoService = [[GetUserInfoService alloc] init];
    userInfoService.userInfo = userInfo;
    [userInfoService request];
    [userInfo release];
    [userInfoService release];
    
}

-(void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge
                                   *)challenge
{
    
    NSLog(@"Auth Request");
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:(NSString
                                                           *)@"Perficient\\spark.pan"
                                                 password:(NSString
                                                           *)@"zhe@812Bl"
                       
                                              persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // inform the user that the user name and password
        // in the preferences are incorrect
        //[self showPreferencesCredentialsAreIncorrectPanel:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [responseData release];
    [connection release];
    NSLog(@"%@", [error description]);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"%@", string);
    [responseData release];
    [connection release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
