//
//  TaskViewController.m
//  SP
//
//  Created by spark pan on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskViewController.h"
#import "ItemMenuListController.h"

@implementation TaskViewController

@synthesize taskInfo;

@synthesize myTableView, buttonItem, popoverController, taskInfoName, taskInfoValue;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger completeInt = [[taskInfo percentComplete] floatValue]*100;
    NSString *completeStr = [[NSString stringWithFormat:@"%d",completeInt] stringByAppendingString:@"%"];
    NSString *assigntoStr = [[taskInfo assignTo] substringFromIndex:3];
    
    self.taskInfoName = [NSArray arrayWithObjects:@"Title:",@"Priority", 
                         @"Status:",  @"% Complete:",@"Assigned To:", @"Description",@"Due Date:", @"Attachment", nil];    
    self.taskInfoValue = [NSArray arrayWithObjects:[taskInfo title], [taskInfo priority],
                          [taskInfo status], completeStr, assigntoStr,@"jsut test it",[taskInfo dueDate],@"AAA.pdf" ,nil];   
    self.title = @"Task Detail";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [taskInfoName count];
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    // Configure the cell...
    
    UILabel *lblKey = [[UILabel alloc] initWithFrame:CGRectMake(10,10,300,25)];		
    //set the background color
    lblKey.backgroundColor = [UIColor clearColor];
    
    lblKey.text = [taskInfoName objectAtIndex:[indexPath row]];
    lblKey.textAlignment = UITextAlignmentLeft;
    lblKey.font = [UIFont fontWithName:@"Arial" size:20];
    [cell.contentView addSubview:lblKey];
    
    UILabel *lblValue = [[UILabel alloc] initWithFrame:CGRectMake(300,10,300,25)];		
    //set the background color
    lblValue.backgroundColor = [UIColor clearColor];
    
    lblValue.text = [taskInfoValue objectAtIndex:[indexPath row]];
    lblValue.textAlignment = UITextAlignmentCenter;
    lblValue.font = [UIFont fontWithName:@"Arial" size:18];
    [cell.contentView addSubview:lblValue];
    [lblKey release];
    
    return cell;
}


#pragma mark -
#pragma mark Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -
#pragma mark button toolbar call method

- (IBAction)toggleMasterView:(id)sender {
    ItemMenuListController *menuListController = [[ItemMenuListController alloc]
                                                  init];
    menuListController.taskInfo = taskInfo;
    UIPopoverController *poc = [[UIPopoverController alloc]
								initWithContentViewController:menuListController];
    [poc presentPopoverFromBarButtonItem:buttonItem 
                permittedArrowDirections:UIPopoverArrowDirectionAny 
                                animated:YES];
    self.popoverController = poc;
    [poc release];
    [menuListController release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark -
#pragma mark Memory management

- (void) dealloc {
    [buttonItem release];
    [myTableView release];
    [popoverController release];
    [taskInfoName release];
    [taskInfoValue release];
    [taskInfo release];
}
@end
