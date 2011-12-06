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
#import "SPSoapRequestBuilder.h"
#import "UpdateListItemsService.h"


@interface TaskEditViewController ()
- (void)onVerificationSuccess:(NSNotification *)notification;
- (void)onVerificationFailure:(NSNotification *)notification;
//- (void) showInfo:(NSString *)infoMsg;
//- (void) showError:(NSString *)errorMsg;
//- (void) showMessage:(NSString *)message withTextColor:(UIColor *)textColor;
- (void) updateTaskDetail;

@end

@implementation TaskEditViewController

@synthesize titleLabel,titleTextField,priorityLabel,priorityTextField,statusLabel,statusTextField,assignedToLabel,assignedToTextField,completeLabel,completeTextField,dueDateLabel,dueDateTextField,attachmentLabel, descLabel,descTextField,attachmenTextField, taskInfo, cancelButton, saveButton, statusPicker, menu,statusNameList,statusSelectButton,prioritySelectButton,priorityNameList,priorityPicker,dueDateSelectButton,dueDatePicker;


#pragma mark - View lifecycle

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

-(IBAction) showDueDatePicker:(id)sender{
    menu = [[UIActionSheet alloc] initWithTitle:@"Select Date" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Done",nil];
    float height = 256.0f;
    dueDatePicker  = [[UIDatePicker alloc]initWithFrame:CGRectMake(0.0f, 416.0f-height, 600.0f, height)];
    dueDatePicker.datePickerMode = UIDatePickerModeDate;
    [dueDatePicker setDate:[NSDate date]];
    [menu addSubview:dueDatePicker];

    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 600, 600)];
    [menu release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != [actionSheet cancelButtonIndex]){
    
        NSDate *selectedStartDate = [dueDatePicker date];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateFormat:@"MMM dd yyyy"];
        NSString *formattedDate = [formatter stringFromDate:selectedStartDate];
        
        dueDateTextField.text = formattedDate;

    }
}


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView	{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	if (pickerFlag) {
     return [self.priorityNameList count];
    }else{
        return [self.statusNameList count];
    }
	
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component	{
	
    if (pickerFlag) {
        return [self.priorityNameList objectAtIndex:row];
    }else{
        return [self.statusNameList objectAtIndex:row];
    }
    
}


-(IBAction)showStatusPicker:(id)sender
{   
    pickerFlag = NO;
	menu = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil 
                         destructiveButtonTitle:nil otherButtonTitles:nil];
    CGRect pickerFrame = CGRectMake(0, 40, 600, 0);
    statusPicker = [[UIPickerView alloc]initWithFrame:pickerFrame];
    statusPicker.dataSource = self;
    statusPicker.delegate = self;
	statusPicker.showsSelectionIndicator= YES;
	[menu  addSubview:statusPicker];	
	[statusPicker release];
    
	UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
	closeButton.momentary = YES;
	closeButton.frame = CGRectMake(500, 7.0f, 50.0f, 30.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor blackColor];
	[closeButton addTarget:self action:@selector(dismissStatusActionSheet:) forControlEvents:UIControlEventValueChanged];
	[menu addSubview:closeButton];
	[closeButton release];
    
   menu.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[menu showInView:[self.view superview]];
	[menu setBounds:CGRectMake(0, 0, 600, 485)];
    
    NSUInteger hightlightIndex = [statusNameList indexOfObject:statusTextField.text];
    if (hightlightIndex == NSNotFound) {
        hightlightIndex = 0;
    }
    BOOL animated = YES;
    if (hightlightIndex == 0) {
        animated = NO;
    }
    [statusPicker selectRow:hightlightIndex inComponent:0 animated:animated];
    
}

- (void) dismissStatusActionSheet:(id) sender	{
	
	statusTextField.text = [statusNameList objectAtIndex:[statusPicker selectedRowInComponent:0]];
    [menu dismissWithClickedButtonIndex:0 animated:YES];
}


-(IBAction)showPriorityPicker:(id)sender
{   
    pickerFlag = YES;
	menu = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil 
                         destructiveButtonTitle:nil otherButtonTitles:nil];
    CGRect pickerFrame = CGRectMake(0, 40, 600, 0);
    priorityPicker = [[UIPickerView alloc]initWithFrame:pickerFrame];
    priorityPicker.dataSource = self;
    priorityPicker.delegate = self;
	priorityPicker.showsSelectionIndicator= YES;
	[menu  addSubview:priorityPicker];	
	[priorityPicker release];
    
    
	UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
	closeButton.momentary = YES;
	closeButton.frame = CGRectMake(500, 7.0f, 50.0f, 30.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor blackColor];
	[closeButton addTarget:self action:@selector(dismissPriorityActionSheet:) forControlEvents:UIControlEventValueChanged];
	[menu addSubview:closeButton];
	[closeButton release];
    
    menu.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[menu showInView:self.view];
	[menu setBounds:CGRectMake(0, 0, 600, 485)];
    
    NSUInteger hightlightIndex = [priorityNameList indexOfObject:priorityTextField.text];
    if (hightlightIndex == NSNotFound) {
        hightlightIndex = 0;
    }
    BOOL animated = YES;
    if (hightlightIndex == 0) {
        animated = NO;
    }
    [priorityPicker selectRow:hightlightIndex inComponent:0 animated:animated];
    
}

- (void) dismissPriorityActionSheet:(id) sender	{
	
	priorityTextField.text = [priorityNameList objectAtIndex:[priorityPicker selectedRowInComponent:0]];
    [menu dismissWithClickedButtonIndex:0 animated:YES];
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
    statusTextField.enabled = NO;
    priorityTextField.enabled = NO;
    dueDateTextField.enabled = NO;
    priorityTextField.text =[taskInfo priority];
    completeTextField.text =[taskInfo percentComplete];
    dueDateTextField.text =[taskInfo dueDate];
    descTextField.text =@"just test it...";
    attachmenTextField.text =@"AAA.PDF";
    self.statusNameList=[NSArray arrayWithObjects:@"In Progress",@"Complete",@"Pending", nil];
    self.priorityNameList=[NSArray arrayWithObjects:@"(1) High",@"(2) Normal",@"(3) Low", nil];
    pickerFlag = NO;
    
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
    [self updateTaskDetail];
}

- (void) updateTaskDetail {
    ListInfo * newTaskInfo = [[ListInfo alloc] init];
    
    newTaskInfo.title = titleTextField.text;
    newTaskInfo.assignTo =assignedToTextField.text;
    newTaskInfo.status =statusTextField.text;
    newTaskInfo.priority =priorityTextField.text;
    newTaskInfo.percentComplete =completeTextField.text;
    newTaskInfo.dueDate =dueDateTextField.text;
    newTaskInfo.listDescription =descTextField.text;
    
    NSLog(@"%@", taskInfo);
    
    SoapRequest * request = [SPSoapRequestBuilder buildUpdateItemsRequest:[taskInfo listName] withFolder:newTaskInfo];
    UpdateListItemsService * updateItemService = [[UpdateListItemsService alloc] init];
    updateItemService.soapRequestParam = request;    
    updateItemService.delegate = self;
    [updateItemService request];    
    [updateItemService release];
    [newTaskInfo release];
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
