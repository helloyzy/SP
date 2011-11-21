//
//  SPAuthenticationView.h
//  SP
//
//  Created by Whitman Yang on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPAuthenticationView : UIViewController

@property (nonatomic, retain) IBOutlet UILabel * lblLoginName;

@property (nonatomic, retain) IBOutlet UILabel * lblPassword;

@property (nonatomic, retain) IBOutlet UITextField * txtUserName;

@property (nonatomic, retain) IBOutlet UITextField * txtPassword;

@property (nonatomic, retain) IBOutlet UITextField * txtSite;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * indicator;

@property (nonatomic, retain) IBOutlet UILabel * lblResultTip;

@property (nonatomic, retain) IBOutlet UILabel * lblProcessingTip;

@property (nonatomic, retain) IBOutlet UIButton * btnVerify;

@property (nonatomic, assign) UIPopoverController * container;

- (IBAction)verify:(id)sender;

- (IBAction)backToParent:(id)sender;

- (IBAction)reset;

@end
