#import <UIKit/UIKit.h>
#import "RootViewController.h"

#import "ListInfo.h"

@interface FirstDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate,DataSourceDelegate, ListItemsDelegate> {

    UIToolbar *toolbar;
    NSMutableData* responseData;
    NSMutableArray * listOfItems;
    IBOutlet UITableView *tableview;
    ListInfo * listInfo;
    UIPopoverController *popoverController;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) NSMutableArray * listOfItems;
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) ListInfo * listInfo;
@property (nonatomic, retain) UIPopoverController *popoverController;

@end
