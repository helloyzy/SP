#import <UIKit/UIKit.h>
#import "RootViewController.h"

#import "ListInfo.h"

@interface FirstDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    NSMutableData* responseData;
    NSMutableArray * listOfItems;
    IBOutlet UITableView *detailTableView;
    ListInfo * listInfo;
    UIPopoverController *popoverController;
    UIWebView * webView;
    UIImageView * imageView;
}

@property (nonatomic, retain) NSMutableArray * listOfItems;
@property (nonatomic, retain) IBOutlet UITableView *detailTableView;
@property (nonatomic, retain) ListInfo * listInfo;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIWebView * webView;

@end
