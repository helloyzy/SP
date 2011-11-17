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
#import "NSObject+SPExtensions.h"

@interface SPAuthenticationView ()

- (void) showInfo:(NSString *)infoMsg;
- (void) showError:(NSString *)errorMsg;
- (void) showMessage:(NSString *)message withTextColor:(UIColor *)textColor;
- (void)onVerificationSuccess:(NSNotification *)notification;
- (void)onVerificationFailure:(NSNotification *)notification;
- (void)hideResultHints;
- (void)hideProcessingHints;
- (void)showProcessingHints;

@end

@implementation SPAuthenticationView

@synthesize lblLoginName, lblPassword,txtUserName, txtPassword, indicator, lblResultTip, lblProcessingTip, btnVerify;

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

#pragma mark - private methods

- (void) showMessage:(NSString *)message withTextColor:(UIColor *)textColor {
    [self hideProcessingHints];
    self.lblResultTip.hidden = NO;
    self.lblResultTip.textColor = textColor;
    self.lblResultTip.text = message;
}

- (void) showInfo:(NSString *)infoMsg {
    [self showMessage:infoMsg withTextColor:[UIColor blueColor]];
}

- (void) showError:(NSString *)errorMsg {
    [self showMessage:errorMsg withTextColor:[UIColor redColor]];
}

- (void)onVerificationSuccess:(NSNotification *)notification {
    RXMLElement * ele = (RXMLElement *) [self valueFromSPNotification:notification];
    NSLog(@"%@", [ele attribute:@"LoginName"]);
    [self showInfo:@"Verification succeed"];
    self.btnVerify.enabled = YES;
}

- (void)onVerificationFailure:(NSNotification *)notification {
    NSString * errorMsg = (NSString *) [self valueFromSPNotification:notification];
    [self showError:errorMsg];
    self.btnVerify.enabled = YES;
}

- (void)hideResultHints {
    self.lblResultTip.hidden = YES;
}

- (void)hideProcessingHints {
    self.lblProcessingTip.hidden = YES;
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
}

- (void)showProcessingHints {
    self.lblProcessingTip.hidden = NO;
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
}

#pragma mark - UI callback methods

- (IBAction)verify:(id)sender {
    NSString * userName = txtUserName.text;
    NSString * password = txtPassword.text;
    if (IS_EMPTY_STRING(userName) || IS_EMPTY_STRING(password)) {
        [self showError:@"User Name and Password are required fields!"];
        return;
    }
    [self hideResultHints];
    [self showProcessingHints];
    self.btnVerify.enabled = NO;
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
    [self registerNotification:SP_NOTIFICATION_GETUSERINFO_SUCCESS withSelector:@selector(onVerificationSuccess:)];
    [self registerNotification:SP_NOTIFICATION_GETUSERINFO_FAILURE withSelector:@selector(onVerificationFailure:)];
    [self hideProcessingHints];
    [self hideResultHints];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.lblLoginName = nil;
    self.lblPassword = nil;
    self.txtUserName = nil;
    self.txtPassword = nil;
    self.indicator = nil;
    self.lblResultTip = nil;
    self.lblProcessingTip = nil;
    self.btnVerify = nil;
    [self unregisterNotification];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Destroy methods

- (void) dealloc {
    [super dealloc];
}

@end
