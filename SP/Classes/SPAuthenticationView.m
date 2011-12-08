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
#import "UIView+Boost.h"
#import "SPCommon.h"
#import "ProgressIndicator.h"

@interface SPAuthenticationView ()

- (void) showInfo:(NSString *)infoMsg;
- (void) showError:(NSString *)errorMsg;
- (void) showMessage:(NSString *)message withTextColor:(UIColor *)textColor;
- (void)onVerificationSuccess:(NSNotification *)notification;
- (void)onVerificationFailure:(NSNotification *)notification;
- (void)hideResultHints;
- (void)hideKeyBoard;
- (void)notifyRefreshList;

@end

@implementation SPAuthenticationView

@synthesize txtUserName, txtPassword, txtSite, lblResultTip, btnVerify, container;

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
    [self.txtSite resignFirstResponder];
}

- (void) showMessage:(NSString *)message withTextColor:(UIColor *)textColor {
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
    // RXMLElement * ele = (RXMLElement *) [self valueFromSPNotification:notification];
    // [self showInfo:@"Verification succeed"];
    
    [ProgressIndicator switchToCustomViewModes:SP_INDICATORMSG_VERIFYACCOUNT_SUCCESS];
    [ProgressIndicator assignDelegate:self];
    [self performSelector:@selector(notifyRefreshList) withObject:nil afterDelay:2];
}

- (void)onVerificationFailure:(NSNotification *)notification {
    [ProgressIndicator hide];
    NSString * errorMsg = (NSString *) [self valueFromSPNotification:notification];
    [self showError:errorMsg];
    self.txtPassword.text = @"";
    [self.txtPassword becomeFirstResponder];
}

- (void)hideResultHints {
    self.lblResultTip.hidden = YES;
}

- (void)notifyRefreshList {
    // send out notifications to list view
    [self postNotification:SP_NOTIFICATION_SITESETTINGS_CHANGED withValue:nil];
}

#pragma mark - MBProgressHUD delegate 

- (void) hudWasHidden:(MBProgressHUD *)hud {
    [ProgressIndicator unassignDelegate];
    [self backToParent:nil];
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
    if (![SPCommon isValidSite:site]) {
        [self showError:@"Sharepoint Site is not a valid URL, please check it!"];
        return;
    }
    
    [self hideKeyBoard];
    [self hideResultHints];
    
    [ProgressIndicator show:SP_INDICATORMSG_VERIFYACCOUNT];
    
    [SPCachedData fillCredentialWithUser:userName password:password];
    [SPCachedData fillSiteInfo:site];
    
    SoapRequest * request = [SPSoapRequestBuilder buildGetUserInfoRequest:userName];
    GetUserInfoService * userInfoService = [[GetUserInfoService alloc] init];
    userInfoService.soapRequestParam = request;
    [userInfoService request];
    [userInfoService release];    
}

- (IBAction)backToParent:(id)sender {
    [self hideKeyBoard];
    // [self dismissModalViewControllerAnimated:YES];
    [self.container dismissPopoverAnimated:YES];
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
    // UIColor * bgColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    // self.view.backgroundColor = bgColor;
    self.contentSizeForViewInPopover = CGSizeMake(320,230);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.txtUserName = nil;
    self.txtPassword = nil;
    self.txtSite = nil;
    self.lblResultTip = nil;
    self.btnVerify = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerNotification:SP_NOTIFICATION_GETUSERINFO_SUCCESS withSelector:@selector(onVerificationSuccess:)];
    [self registerNotification:SP_NOTIFICATION_GETUSERINFO_FAILURE withSelector:@selector(onVerificationFailure:)];
    self.txtUserName.text = [SPCachedData credential].user;
    self.txtPassword.text = [SPCachedData credential].password;
    self.txtSite.text = [SPCachedData userInputSite];
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
    self.txtUserName = nil;
    self.txtPassword = nil;
    self.txtSite = nil;
    self.lblResultTip = nil;
    self.btnVerify = nil;
    [super dealloc];
}

@end
