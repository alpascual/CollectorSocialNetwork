//
//  SecondViewController.h
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerRestUrl.h"
#import "SVStatusHUD.h"

@interface SettingsViewController : UIViewController <NSURLConnectionDataDelegate>

@property (nonatomic,strong) IBOutlet UITextField *email;
@property (nonatomic,strong) IBOutlet UITextField *password1;
@property (nonatomic,strong) IBOutlet UITextField *password2;
@property (nonatomic,strong) IBOutlet UITextField *twitter;
@property (nonatomic) BOOL bEditing;

@property (nonatomic,strong) IBOutlet UIBarButtonItem *createAccount;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *creatingActivity;


- (void) createAccountBackgroundProcess:(NSString *)nothing;
-(void)doneParsing;

@end
