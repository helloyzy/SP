#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface FirstDetailViewController : UIViewController <SubstitutableDetailViewController,DataSourceDelegate, ListItemsDelegate> {

    UIToolbar *toolbar;
    NSMutableData* responseData;
    NSMutableArray * listOfItems;
    IBOutlet UITableView *tableview;
    NSString * listName;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) NSMutableArray * listOfItems;
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSString * listName;

@end
