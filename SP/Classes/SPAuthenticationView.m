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
#import "UTLDebug.h"

@interface SPAuthenticationView ()

- (void) showInfo:(NSString *)infoMsg;
- (void) showError:(NSString *)errorMsg;
- (void) showMessage:(NSString *)message withTextColor:(UIColor *)textColor;
- (void)onVerificationSuccess:(NSNotification *)notification;
- (void)onVerificationFailure:(NSNotification *)notification;
- (void)hideResultHints;
- (void)hideProcessingHints;
- (void)showProcessingHints;
- (void)hideKeyBoard;
- (BOOL)verifySite:(NSString *)site;

@end

@implementation SPAuthenticationView

@synthesize lblLoginName, lblPassword,txtUserName, txtPassword, txtSite,indicator, lblResultTip, lblProcessingTip, btnVerify;

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

- (void)hideKeyBoard {
    [self.txtUserName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}

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
    [self reset];
}

- (void)onVerificationFailure:(NSNotification *)notification {
    NSString * errorMsg = (NSString *) [self valueFromSPNotification:notification];
    [self showError:errorMsg];
    self.btnVerify.enabled = YES;
    self.txtPassword.text = @"";
    [self.txtPassword becomeFirstResponder];
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

- (BOOL)verifySite:(NSString *)site {
    if ([site hasPrefix:@"http"] || [site hasPrefix:@"https"]) {
        NSURL * url = [NSURL URLWithString:site];
        NSString * host = [url host];
        UTLLog(@"Host from site %@ is:%@", site, host);
        if (IS_POPULATED_STRING(host)) {
            [SPCachedData sharedInstance].serviceHost = host;
            return YES;
        }
    }
    return NO;
}

#pragma mark - UI callback methods

- (IBAction)verify:(id)sender {
    NSString * userName = txtUserName.text;
    NSString * password = txtPassword.text;
    NSString * site = txtSite.text;
    if (IS_EMPTY_STRING(userName) || IS_EMPTY_STRING(password)) {
        [self showError:@"User Name and Password are required fields!"];
        return;
    }
    if (IS_EMPTY_STRING(site)) {
        [self showError:@"Sharepoint Site is a required field!"];
        return;
    }
    // add the trailing "/" for the url if necessary
    if ([site hasSuffix:@"/"]) {
        site = [site stringByAppendingString:@"/"];
    }
    if (![self verifySite:site]) {
        [self showError:@"Sharepoint Site is not a valid URL, please check it!"];
        return;
    }
    
    [self hideKeyBoard];
    [self hideResultHints];
    [self showProcessingHints];
    self.btnVerify.enabled = NO;
    
    [SPCachedData sharedInstance].user = userName;
    [SPCachedData sharedInstance].pwd = password;
    // adding the service suffix
    site = [site stringByAppendingString:@"_vti_bin/"];
    [SPCachedData sharedInstance].serviceUrlPrefix = site;
    
    SoapRequest * request = [SPSoapRequestBuilder buildGetUserInfoRequest:userName];
    GetUserInfoService * userInfoService = [[GetUserInfoService alloc] init];
    userInfoService.soapRequestParam = request;
    [userInfoService request];
    [userInfoService release];    
}

- (IBAction)backToParent:(id)sender {
    [self hideKeyBoard];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)reset {
    self.txtUserName.text = @"";
    self.txtPassword.text = @"";
    self.txtSite.text = @"";
    [self hideKeyBoard];
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
    self.lblLoginName = nil;
    self.lblPassword = nil;
    self.txtUserName = nil;
    self.txtPassword = nil;
    self.txtSite = nil;
    self.indicator = nil;
    self.lblResultTip = nil;
    self.lblProcessingTip = nil;
    self.btnVerify = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerNotification:SP_NOTIFICATION_GETUSERINFO_SUCCESS withSelector:@selector(onVerificationSuccess:)];
    [self registerNotification:SP_NOTIFICATION_GETUSERINFO_FAILURE withSelector:@selector(onVerificationFailure:)];
    [self hideProcessingHints];
    [self hideResultHints];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
