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

@synthesize myTableView, buttonItem, popoverController, taskInfoName, taskInfoValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    //cell.textLabel.text = [taskInfoValue objectAtIndex:[indexPath row]];
    
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


- (IBAction)toggleMasterView:(id)sender {
    ItemMenuListController *menuListController = [[ItemMenuListController alloc]
													  init];
    UIPopoverController *poc = [[UIPopoverController alloc]
								initWithContentViewController:menuListController];
    [poc presentPopoverFromBarButtonItem:buttonItem 
                permittedArrowDirections:UIPopoverArrowDirectionAny 
                                animated:YES];
    self.popoverController = poc;
    [poc release];
    [menuListController release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.taskInfoName = [NSArray arrayWithObjects:@"Title:", @"Assigned To:",
                      @"Status:", @"Priority:", @"% Complete:",@"Due Date:", nil];    
    
    self.taskInfoValue = [NSArray arrayWithObjects:@"Task222", @"Whitman.Yang",
                         @"In Progress", @"(1) High", @"30%",@"2012-12-31", nil];    
    self.title = @"Task Detail";

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

#pragma mark -
#pragma mark Memory management

- (void) dealloc {
    [buttonItem release];
    [myTableView release];
    [popoverController release];
    [taskInfoName release];
    [taskInfoValue release];
}
@end
