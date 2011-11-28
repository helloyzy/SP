//
//  TaskEditViewController.m
//  SP
//
//  Created by spark pan on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskEditViewController.h"

@implementation TaskEditViewController

@synthesize titleLabel,titleTextField,priorityLabel,priorityTextField,statusLabel,statusTextField,assignedToLabel,assignedToTextField,completeLabel,completeTextField,dueDateLabel,dueDateTextField,attachmentLabel, descLabel,descTextField,attachmenTextField, taskInfo, cancelButton, saveButton;


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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.taskInfoValue = [NSMutableArray arrayWithObjects:@"Task222", @"Whitman.Yang",
      //                    @"In Progress", @"(1) High", @"30%",@"2012-12-31", nil];   
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
