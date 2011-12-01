#import "ItemMenuListController.h"
#import "TaskViewController.h"
#import "TaskEditViewController.h"
@implementation ItemMenuListController

@synthesize menuNames, taskInfo;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuNames = [NSArray arrayWithObjects:@"Edit The Item", @"Delete the Item",
                      @"Add Attachments", nil];    
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 
												  [self.menuNames count] * 44.0);
}

- (void)viewDidUnload {
    self.menuNames = nil;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.menuNames count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [menuNames objectAtIndex:[indexPath row]];
    return cell;
}


#pragma mark -
#pragma mark Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        TaskEditViewController *editTaskViewController = [[TaskEditViewController alloc]
                                                          init];
        
        editTaskViewController.taskInfo = taskInfo;
        UIPopoverController *secondPopoverController = [[UIPopoverController alloc] initWithContentViewController:editTaskViewController];
        secondPopoverController.popoverContentSize = CGSizeMake(600, 600);
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [secondPopoverController presentPopoverFromRect:cell.bounds inView:cell.contentView 
                               permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        [editTaskViewController release];
        // release popover in 'popoverControllerDidDismissPopover:' method
    }
    
}

#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)dealloc {
    [super dealloc];
    [menuNames release];
    [taskInfo release];
}

@end

