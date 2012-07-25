//
//  SecondViewController.m
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize email = _email;
@synthesize password1 = _password1;
@synthesize password2 = _password2;
@synthesize twitter = _twitter;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ( [defaults objectForKey:@"email"] == nil )
    {
        // Redirect to another place
    }
    else {
        self.email.text = [defaults objectForKey:@"email"];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
