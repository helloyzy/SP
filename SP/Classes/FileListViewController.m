//
//  FileListViewController.m
//  SP
//
//  Created by sarshern.lin on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FileListViewController.h"
#import "Base64.h"
#import "NSObject+SPExtensions.h"
#import "SPConst.h"
#import "AddAttachmentService.h"
#import "SoapRequest.h"
#import "SPSoapRequestBuilder.h"

@implementation FileListViewController
@synthesize fileList;
@synthesize myTable;
@synthesize indexPathForSelectRow;
@synthesize indicator;
@synthesize myAlertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerNotification:SP_NOTIFICATION_ADDATTACHMENT_SUCCESS withSelector:@selector(onVerificationSuccess:)];
    [self registerNotification:SP_NOTIFICATION_ADDATTACHMENT_FAILURE withSelector:@selector(onVerificationFailure:)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterNotification];
}

- (void)onVerificationSuccess:(NSNotification *)notification {
    [self.indicator stopAnimating];
    [self.myAlertView dismissWithClickedButtonIndex:1 animated:YES];
    
    NSString * successMsg = (NSString *) [self valueFromSPNotification:notification];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:successMsg 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"OK",nil];
    [alertview show];
    [alertview release];
}

- (void)onVerificationFailure:(NSNotification *)notification {
    [self.indicator stopAnimating];
    [self.myAlertView dismissWithClickedButtonIndex:1 animated:YES];
    
    NSString * errorMsg = (NSString *) [self valueFromSPNotification:notification];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:errorMsg 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"OK",nil];
    [alertview show];
    [alertview release];
}

//-------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.fileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"FILE_LIST_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.fileList objectAtIndex:[indexPath row]];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.indexPathForSelectRow = indexPath;
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure to attach the file" 
                         delegate:self 
                         cancelButtonTitle:@"cancel" 
                         otherButtonTitles:@"OK",nil];
    [alertview show];
    [alertview release];
        
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPathForSelectRow = nil;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"] && 
          self.indexPathForSelectRow != nil){
        
        self.myAlertView = [[[UIAlertView alloc] initWithTitle:@"The file is being attaching" message:@"Please wait...." delegate:nil cancelButtonTitle:nil  otherButtonTitles:nil] autorelease];
		[myAlertView show];
		
		self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        
		[myAlertView addSubview:indicator];
        indicator.center = CGPointMake(myAlertView.bounds.size.width + 150, myAlertView.bounds.size.height + 90);
		[indicator startAnimating];
  
        
        [self attachSelectFile];

     }
}

-(void)attachSelectFile{
    UITableViewCell *cell=[myTable  cellForRowAtIndexPath:self.indexPathForSelectRow];
    NSString *fileName = [[cell textLabel] text];           
    
    SoapRequest * request = [SPSoapRequestBuilder buildAddAttachmentRequest:fileName];
    
    //NSLog(@"attachment request is : %@",request);
    
    AddAttachmentService * addAttachmentService = [[AddAttachmentService alloc] init];
    addAttachmentService.soapRequestParam = request;    
    [addAttachmentService request];    
    [addAttachmentService release];
    
    
    
    
    
//    UITableViewCell *cell=[myTable  cellForRowAtIndexPath:self.indexPathForSelectRow];
//    NSString *fileName = [[cell textLabel] text];            
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentDir = [documentPaths objectAtIndex:0];
//    NSString *filePath = [documentDir stringByAppendingFormat:@"/%@",fileName];
//    NSLog(@"filePath= %@--",filePath);
//    
//    NSData *databuffer;
//    databuffer = [fileManager contentsAtPath:filePath]; 
//    NSString *attachment = [Base64 encode:databuffer];
//
//    
//    NSString *soapMessage = [NSString stringWithFormat:@
//                             "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//                             "<soap:Body>\n"
//                             "<AddAttachment xmlns=\"http://schemas.microsoft.com/sharepoint/soap/\">\n"
//                             "<listName>%@</listName>\n"
//                             "<listItemID>1</listItemID>\n"
//                             "<fileName>%@</fileName>\n"
//                             "<attachment>%@</attachment>\n"
//                             "</AddAttachment>\n"
//                             "</soap:Body>\n"
//                             "</soap:Envelope>\n", @"74C84711-4EDB-4DF2-952F-413A176EA0CC", fileName,attachment];
//    
//    
//    NSURL *url = [NSURL URLWithString:@"https://sharepoint.perficient.com/sites/sp/_vti_bin/Lists.asmx"];
//    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
//    
//    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];    
//    [theRequest addValue:@"sharepoint.perficient.com" forHTTPHeaderField:@"Host"];
//    [theRequest addValue:@"http://schemas.microsoft.com/sharepoint/soap/AddAttachment" forHTTPHeaderField:@"SOAPAction"];
//    [theRequest setHTTPMethod:@"POST"];
//    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    @try
//    {
//        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//        if(connection)
//        {
//            responseData = [NSMutableData data];
//        }
//        
//    }
//    @catch (NSException *exception) {
//        NSLog(@"Caught exception: %@%@", [exception name], [exception reason]);
//    }

}

//-------------------------------------------

//
//-(void)connection:(NSURLConnection *)connection
//didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge
//                                   *)challenge
//{
//    
//    NSLog(@"Auth Request");
//    if ([challenge previousFailureCount] == 0) {
//        NSURLCredential *newCredential;
//        newCredential=[NSURLCredential credentialWithUser:(NSString
//                                                           *)@"Perficient\\spark.pan"
//                                                 password:(NSString
//                                                           *)@"zhe@812Bl"
//                       
//                                              persistence:NSURLCredentialPersistenceForSession];
//        [[challenge sender] useCredential:newCredential
//               forAuthenticationChallenge:challenge];
//    } else {
//        [[challenge sender] cancelAuthenticationChallenge:challenge];
//        // inform the user that the user name and password
//        // in the preferences are incorrect
//        //[self showPreferencesCredentialsAreIncorrectPanel:self];
//    }
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    responseData = [[NSMutableData alloc] init];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [responseData appendData:data];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    [responseData release];
//    [connection release];
//    NSLog(@"[error description]=%@", [error description]);
//}
//
//- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
//    
//    NSString * returnXML = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
//    NSLog(@"returnXML=%@-----returnXML end----", returnXML);
//    [responseData release];
//    [connection release];
//        
//    
//    [self.indicator stopAnimating];
//    [self.myAlertView dismissWithClickedButtonIndex:1 animated:YES];
//    
//    
//    NSString *alertMessage = @"The specified name is already in use.";
//    if ([returnXML rangeOfString : @"The specified name is already in use."].length > 0 ) {
//        alertMessage = @"The specified name is already in use.";
//    }else if ([returnXML rangeOfString : @"The file or folder name contains characters that are not permitted.  Please use a different name."].length > 0){
//        alertMessage = @"The file or folder name contains characters that are not permitted.  Please use a different name.";
//    }else if ([returnXML isEqualToString:@""]){
//        alertMessage = @"Nothing return from server.";
//    }
//    else {
//        alertMessage = @"Attach Successfully!";
//    }    
//    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:alertMessage 
//                                                       delegate:nil 
//                                              cancelButtonTitle:nil 
//                                              otherButtonTitles:@"OK",nil];
//    [alertview show];
//    [alertview release];
//
//}



//-------------------------------------------
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
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSError *error = nil;
    self.fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];    
    
    NSLog(@"fileList:%@-----",fileList);
    NSLog(@"error:%@-----",error);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.myTable = nil;
    self.fileList = nil;
    self.indexPathForSelectRow = nil;
    self.indicator = nil;
    self.myAlertView = nil;
}

- (void)dealloc {
    [myTable release];
    [fileList release];
    [indexPathForSelectRow release];
    [indicator release];
    [myAlertView release];
    [super dealloc];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
