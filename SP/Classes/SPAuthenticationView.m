//
//  SPAuthenticationView.m
//  SP
//
//  Created by Whitman Yang on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SPAuthenticationView.h"
#import "SPSoapRequestBuilder.h"
#import "SoapRequest.h"
#import "GetUserInfoService.h"
#import "SPCachedData.h"

@implementation SPAuthenticationView

@synthesize txtUserName, txtPassword, indicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UI callback methods

- (IBAction)verify:(id)sender {
    NSString * userName = txtUserName.text;
    NSString * password = txtPassword.text;
    [SPCachedData sharedInstance].user = userName;
    [SPCachedData sharedInstance].pwd = password;
    SoapRequest * request = [SPSoapRequestBuilder buildGetUserInfoRequest:userName];
    GetUserInfoService * userInfoService = [[GetUserInfoService alloc] init];
    userInfoService.soapRequestParam = request;
    [userInfoService request];
    [userInfoService release];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Destroy methods

- (void) dealloc {
    self.txtUserName = nil;
    self.txtPassword = nil;
    self.indicator = nil;
    [super dealloc];
}

@end
