//
//  TaskEditViewController.m
//  SP
//
//  Created by spark pan on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskEditViewController.h"
#import "NSObject+SPExtensions.h"
#import "SPConst.h"


@interface TaskEditViewController ()
- (void)onVerificationSuccess:(NSNotification *)notification;
- (void)onVerificationFailure:(NSNotification *)notification;
//- (void) showInfo:(NSString *)infoMsg;
//- (void) showError:(NSString *)errorMsg;
//- (void) showMessage:(NSString *)message withTextColor:(UIColor *)textColor;

@end

@implementation TaskEditViewController

@synthesize titleLabel,titleTextField,priorityLabel,priorityTextField,statusLabel,statusTextField,assignedToLabel,assignedToTextField,completeLabel,completeTextField,dueDateLabel,dueDateTextField,attachmentLabel, descLabel,descTextField,attachmenTextField, taskInfo, cancelButton, saveButton;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleTextField.text =[taskInfo title];
    assignedToTextField.text =[taskInfo assignTo];
    statusTextField.text =[taskInfo status];
    statusTextField.delegate = self;
    priorityTextField.text =[taskInfo priority];
    completeTextField.text =[taskInfo percentComplete];
    dueDateTextField.text =[taskInfo dueDate];
    descTextField.text =@"just test it...";
    attachmenTextField.text =@"AAA.PDF";
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self registerNotification:SP_NOTIFICATION_UPDATEITEM_SUCCESS withSelector:@selector(onVerificationSuccess:)];
    [self registerNotification:SP_NOTIFICATION_UPDATEITEM_FAILURE withSelector:@selector(onVerificationFailure:)];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterNotification];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                    message:@"status list here"
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    return NO;
}

- (IBAction)cancelChanges:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                    message:@"cancel the changes"
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)saveChanges:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                    message:@"update the changes"
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark -
#pragma sharepoint soap web service call method

- (void)onVerificationSuccess:(NSNotification *)notification {
    NSMutableArray * lists = (NSMutableArray *) [self valueFromSPNotification:notification];
    NSLog(@"%@", lists);    
}

- (void)onVerificationFailure:(NSNotification *)notification {
    NSString * errorMsg = (NSString *) [self valueFromSPNotification:notification];
    NSLog(@"%@", errorMsg);
    //[self showError:errorMsg];
}


#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void) dealloc {
    [super dealloc];
    [titleLabel release];
    [titleTextField release];
    [priorityLabel release];
    [priorityTextField release];    
    [statusLabel release];
    [statusTextField release];    
    [assignedToLabel release];
    [assignedToTextField release];    
    [completeLabel release];
    [completeTextField release];
    [dueDateLabel release];
    [dueDateTextField release];    
    [attachmentLabel release];
    [attachmenTextField release];    
    [descLabel release];
    [descTextField release];    
    [taskInfo release];
    [cancelButton release];
    [saveButton release];    
}

@end