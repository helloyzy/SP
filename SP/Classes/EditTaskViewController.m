//
//  EditTaskViewController.m
//  SP
//
//  Created by spark pan on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EditTaskViewController.h"

@implementation EditTaskViewController

@synthesize taskTableView, taskInfoName, taskInfoValue, backButton, updateButton, container;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.taskInfoName = [NSMutableArray arrayWithObjects:@"Title:", @"Assigned To:",
                         @"Status:", @"Priority:", @"% Complete:",@"Due Date:", nil];    
    
    self.taskInfoValue = [NSMutableArray arrayWithObjects:@"Task222", @"Whitman.Yang",
                          @"In Progress", @"(1) High", @"30%",@"2012-12-31", nil];    
    
    self.contentSizeForViewInPopover = CGSizeMake(600.0, 
												  [self.taskInfoName count] * 44.0);
}

#pragma mark - UI callback methods

- (IBAction)update:(id)sender {
    
}

- (IBAction)backToParent:(id)sender {
     [self.container dismissPopoverAnimated:YES];
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
    
    UILabel *lblKey = [[UILabel alloc] initWithFrame:CGRectMake(10,10,100,25)];		
    //set the background color
    lblKey.backgroundColor = [UIColor clearColor];
    
    lblKey.text = [taskInfoName objectAtIndex:[indexPath row]];
    lblKey.textAlignment = UITextAlignmentLeft;
    lblKey.font = [UIFont fontWithName:@"Arial" size:20];
    [cell.contentView addSubview:lblKey];
    
    //UILabel *lblValue = [[UILabel alloc] initWithFrame:CGRectMake(100,10,250,25)];		
    UITextField *lblValue = [[UITextField alloc] initWithFrame:CGRectMake(100,10,250,25)];	
    //set the background color
    lblValue.backgroundColor = [UIColor clearColor];
    
    lblValue.tag = [indexPath row];
    lblValue.text = [taskInfoValue objectAtIndex:[indexPath row]];
    lblValue.textAlignment = UITextAlignmentCenter;
    lblValue.font = [UIFont fontWithName:@"Arial" size:18];
    
    [lblValue addTarget:self action:@selector(textFieldTouched:)
     
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    [cell.contentView addSubview:lblValue];
    [lblKey release];
    
    return cell;
}


- (void) textFieldTouched:(id)sender {
    
    NSLog(@"%d", [sender tag]);
    NSLog(@"%@", [sender text]);
    
    [self.taskInfoValue replaceObjectAtIndex:[sender tag] withObject:[sender text]];
    
    //[taskTableView reloadData];
}


#pragma mark -
#pragma mark Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     

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
    [taskTableView release];
    [taskInfoName release];
    [taskInfoValue release];
    [updateButton release];
    [backButton release];
}

@end
