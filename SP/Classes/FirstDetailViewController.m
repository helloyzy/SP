#import "FirstDetailViewController.h"
#import "FirstDetailViewController.h"
#import "GetUserInfoService.h"
#import "ListInfo.h"
#import "GetListCollectionService.h"
#import "SPConst.h"
#import "RXMLElement.h"
#import "UTLDebug.h"
#import "SPSimpleSoapRequest.h"
#import "SPSoapRequestBuilder.h"
#import "SPLoginAuthenticationService.h"


@interface FirstDetailViewController ()

- (void) testGetUserInfo;
- (void) testLists;
- (void) testAuthentication;
- (void) requestSubFolder: (NSString *) topListName withFolder: (NSString *) folder;
@end

@implementation FirstDetailViewController

@synthesize toolbar, listOfItems, tableview, listName;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self requestSubFolder: [self listName] withFolder:[NSString stringWithFormat:@"sites/SP/%@", [self listName]]];
    
}

- (void)viewDidUnload {
	[super viewDidUnload];
    
	self.toolbar = nil;
}

#pragma mark -
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}



- (void) testAuthentication {
    SoapRequest * request = [SPSoapRequestBuilder buildAuthenticationRequest];
    SPLoginAuthenticationService * authService = [[SPLoginAuthenticationService alloc] init];
    authService.soapRequestParam = request;
    [authService request];
    [authService release];
    
}

- (void) testGetUserInfo {
    SoapRequest * request = [SPSoapRequestBuilder buildGetUserInfoRequest:@"Perficient\\spark.pan"];
    GetUserInfoService * userInfoService = [[GetUserInfoService alloc] init];
    userInfoService.soapRequestParam = request;
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onNotification:) name:SP_NOTIFICATION_GETUSERINFO_SUCCESS object:userInfoService];
    [userInfoService request];
    [userInfoService release];
}

- (void) testLists {
    SoapRequest * request = [SPSoapRequestBuilder buildListInfoRequest];
    GetListCollectionService * listInfoService = [[GetListCollectionService alloc] init];
    listInfoService.soapRequestParam = request;    
    listInfoService.delegate = self;
    [listInfoService request];    
    [listInfoService release];
}

- (void) requestSubFolder: (NSString *) topListName withFolder: (NSString *) folder{
    SoapRequest * request = [SPSoapRequestBuilder buildGetListItemsRequest:topListName withFolder:folder];
    GetListItemsService* listItemsService = [[GetListItemsService alloc]init];
    listItemsService.soapRequestParam = request;    
    listItemsService.delegate = self;
    [listItemsService request];    
    [listItemsService release];
}

- (void) dataSourceReturn:(NSMutableArray *)datasource {
    self.listOfItems = datasource;
    [self.tableview reloadData];
}

- (void) ListsReturn:(NSMutableArray *)datasource {
    self.listOfItems = datasource;
    [self.tableview reloadData];
}

- (void)onNotification:(NSNotification *)notification {
    NSDictionary * dict = [notification userInfo];
    RXMLElement * ele = (RXMLElement *) [dict objectForKey:SP_NOTIFICATION_KEY_USERINFO];
    NSLog(@"%@", [ele attribute:@"LoginName"]);
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    
    // Set up the cell...
	NSString *title = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] title];
    //NSString *type = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] type];
    //NSString *fileRef = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] fileRef];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 25)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [cell.contentView addSubview:titleLabel];
    [titleLabel release];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



#pragma mark -
#pragma mark Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *type = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] type];
    //NSString * subListName = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] title];
    NSString *fileRef = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] fileRef];
    if ([type isEqualToString:@"1"]) {
        [self requestSubFolder:listName withFolder: (NSString *) fileRef];
    } else {
    //TODO open the item as the URL -- https://sharepoint.perficient.com/sites/SP/TestDocument/sub_1/sub_2/mazda3.JPG
          
      
    }
    
}
#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [toolbar release];
    [tableview release];
    [listName release];
    [listOfItems release];
    
    [super dealloc];
}	


@end
