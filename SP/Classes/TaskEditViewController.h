//
//  TaskEditViewController.h
//  SP
//
//  Created by spark pan on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListInfo.h"


@interface TaskEditViewController : UIViewController<UITextFieldDelegate> {
    IBOutlet UILabel * titleLabel;
    IBOutlet UILabel * priorityLabel;
    IBOutlet UILabel * statusLabel;
    IBOutlet UILabel * completeLabel;
    IBOutlet UILabel * assignedToLabel;
    IBOutlet UILabel * descLabel;
    IBOutlet UILabel * dueDateLabel;
    IBOutlet UILabel * attachmentLabel;
        
    IBOutlet UITextField * titleTextField;
    IBOutlet UITextField * priorityTextField;
    IBOutlet UITextField * statusTextField;
    IBOutlet UITextField * completeTextField;
    IBOutlet UITextField * assignedToTextField;
    IBOutlet UITextField * descTextField;
    IBOutlet UITextField * dueDateTextField;
    IBOutlet UITextField * attachmenTextField;    
    
    ListInfo * taskInfo;
    
    IBOutlet UIButton * cancelButton;
    IBOutlet UIButton * saveButton;
}


@property (nonatomic, retain) IBOutlet UILabel * titleLabel;
@property (nonatomic, retain) IBOutlet UILabel * priorityLabel;
@property (nonatomic, retain) IBOutlet UILabel * statusLabel;
@property (nonatomic, retain) IBOutlet UILabel * completeLabel;
@property (nonatomic, retain) IBOutlet UILabel * assignedToLabel;
@property (nonatomic, retain) IBOutlet UILabel * dueDateLabel;
@property (nonatomic, retain) IBOutlet UILabel * attachmentLabel;
@property (nonatomic, retain) IBOutlet UILabel * descLabel;

@property (nonatomic, retain) IBOutlet UITextField * titleTextField;
@property (nonatomic, retain) IBOutlet UITextField * priorityTextField;
@property (nonatomic, retain) IBOutlet UITextField * statusTextField;
@property (nonatomic, retain) IBOutlet UITextField * completeTextField;
@property (nonatomic, retain) IBOutlet UITextField * assignedToTextField;
@property (nonatomic, retain) IBOutlet UITextField * descTextField;
@property (nonatomic, retain) IBOutlet UITextField * dueDateTextField;
@property (nonatomic, retain) IBOutlet UITextField * attachmenTextField;

@property (nonatomic, retain) ListInfo * taskInfo;

@property (nonatomic, retain) IBOutlet UIButton * cancelButton;
@property (nonatomic, retain) IBOutlet UIButton * saveButton;

-(IBAction) cancelChanges:(id)sender;
-(IBAction) saveChanges:(id)sender;
@end
