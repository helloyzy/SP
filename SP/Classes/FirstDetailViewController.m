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
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"
#import "ASIHTTPRequest.h"
#import "TaskViewController.h"
#import "SPCachedData.h"


@interface FirstDetailViewController ()

- (void) requestSubFolder: (NSString *) topListName withFolder: (NSString *) folder;
- (void) loadImage:(ListInfo *)listItem;

@end



@implementation FirstDetailViewController

@synthesize listOfItems, tableview, popoverController, listInfo, webView;


#pragma mark -
#pragma mark View lifecycle


/**
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setListInfo:(ListInfo *) newlistInfo {
    
    if (listInfo != newlistInfo) {
        [listInfo release];
        listInfo = [newlistInfo retain];
        
    }
    
    [self requestSubFolder:listInfo.listName withFolder:listInfo.fileRef];
    [self setTitle:listInfo.fileRef];
    
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }        
    
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];        
}

- (void)viewDidUnload {
	[super viewDidUnload];
    
	//self.toolbar = nil;
}
#pragma mark -
#pragma mark Split view support


- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc
{
    
    [barButtonItem setTitle:@"List"];
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
    [self setPopoverController:pc];
}


- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [[self navigationItem] setLeftBarButtonItem:nil];
    [self setPopoverController:nil];
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
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 500, 50)];
   
    titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [cell.contentView addSubview:titleLabel];
    [titleLabel release];
    
    NSString *type = [(ListInfo *)[listOfItems objectAtIndex:indexPath.row] type];
    
    if ([type isEqualToString:@"1"]) {
       titleLabel.text = title;
    } else {
        titleLabel.text = [NSString stringWithFormat:@"%@ \n Last updated by Spark.Pan 2011-11-11",title];  
    }
    
    titleLabel.numberOfLines = 2;
    //titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
	     
    return 60;
}

#pragma mark -
#pragma mark Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ListInfo * selectedItem = (ListInfo *)[listOfItems objectAtIndex:indexPath.row];
    
    NSString *fileRef = [selectedItem fileRef];
    NSString* fileName = [fileRef lastPathComponent];
    
    if ([selectedItem.type isEqualToString:@"1"]) {
    
     FirstDetailViewController *controller = [[FirstDetailViewController alloc] init];
        selectedItem.listName = listInfo.listName;
        controller.listInfo = selectedItem;
        [[self navigationController] pushViewController:controller animated:YES];

    } else if ([fileName isEqualToString:@"1_.000" ]) {
    TaskViewController *controller = [[TaskViewController alloc] initWithNibName:@"TaskViewController" bundle:nil];        
         [[self navigationController] pushViewController:controller animated:YES];
        [controller release];
    } else {
       
        [self loadImage:(ListInfo *)[listOfItems objectAtIndex:indexPath.row]];

    }
    
}
   - (void) loadImage:(ListInfo *)listItem {
    
    NSString * imageUrlPrefix = [SPCachedData serviceHostUrl];
    NSString * url = [imageUrlPrefix stringByAppendingString:listItem.fileRef];
    
    NSString* theFileName = [url lastPathComponent];
    NSString * escapedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    UTLLog(@"The resource to download is - %@", escapedUrl);
    NSURL *targetURL = [NSURL URLWithString:escapedUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:targetURL];
    NSString * destinationPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:theFileName];
    
    UTLLog(@"The resource will saved into local directory - %@", destinationPath);
    
    [request setDelegate:self];
    [request setDownloadDestinationPath:destinationPath];
    [request setDidFailSelector:@selector(webPageFetchFailed:)];
    [request setDidFinishSelector:@selector(webPageFetchSucceeded:)];
    
    [request setUsername:[SPCachedData credential].user];
    [request setPassword:[SPCachedData credential].password];
    [request setUseSessionPersistence:YES];
    
    [request startAsynchronous];  
    
}

- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest
{
    // Obviously you should handle the error properly...
    NSLog(@"%@",[theRequest error]);
}

- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest
{
    NSFileManager* myManager = [NSFileManager defaultManager];  
    
    if([myManager fileExistsAtPath:[theRequest downloadDestinationPath]]) {
        
        UTLLog(@"The local resource will be loaded - %@", [theRequest downloadDestinationPath]);
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 786, 960)];
        //Create a URL object.
        NSURL *url = [NSURL fileURLWithPath:[theRequest downloadDestinationPath] isDirectory:NO];
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        //Load the request in the UIWebView.
        [webView loadRequest:requestObj];
        [self.view addSubview:webView];
        UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(info_clicked:)];
        
        self.navigationItem.leftBarButtonItem = infoButton;
        
        
    }
    
}

- (void) info_clicked:(id)sender {
    
    self.navigationItem.leftBarButtonItem = nil;
    [webView removeFromSuperview];
}




#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    //[toolbar release];
    [tableview release];
    [listInfo release];
    [listOfItems release];
    [webView release];
    [super dealloc];
}	


@end
