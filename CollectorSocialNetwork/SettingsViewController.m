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
@synthesize bEditing = _bEditing;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ( [defaults objectForKey:@"email"] == nil )
    {
        if ( self.bEditing == NO) {
            // Redirect to another place @todo check you can do that
            [self performSegueWithIdentifier:@"segueSettingsView" sender:self];
        }
    }
    
    self.email.text = [defaults objectForKey:@"email"];
    
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

- (IBAction)createAccountPressed:(id)sender {
    
    if ( self.password1.text.length < 4)
    {
        [self alertme:@"Passwords is too small"];
        return;
    }
    
    // Check passwords
    if ( [self.password1.text isEqualToString:self.password2.text] == NO) {
        [self alertme:@"Passwords do not match"];
        return;
    }
    
    if ( self.email.text.length < 3) {
        [self alertme:@"Email required"];
        return;
    }
    
    /*if ( self.twitter.text.length < 1) {
        [self alertme:@"Twitter username required for sharing"];
        return;
    }*/
    
    
    // Check email address that does not exist
    // @todo in the server needs to check if email address exists
  
    // Download picture from Twitter if account was provided.
    //https://api.twitter.com/1/users/profile_image?screen_name=twitterapi&size=normal
    // Update User Picture
    
    //string password, string email, string twitterUsername)
    // Submit
    NSString *myRequestString = [[NSString alloc] initWithFormat:@"http://birds.alsandbox.us/api/CreateUser?password=%u&email=%@&twitterUsername=%@", [self.password1.text hash], self.email.text, self.twitter.text ];
    
    NSURL *urlToOpen = [[NSURL alloc] initWithString:myRequestString];
    
    NSURLRequest *aReq = [NSURLRequest requestWithURL:urlToOpen];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:aReq delegate:self];
    
    if (theConnection) {       
    } else {
        // Inform the user that the connection failed.
        [self alertme:@"The account failed on creation"];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    NSLog(@"data returned: %@", data);
    NSString* newStr = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"data returned String: %@", newStr);
    
    // If successful store it
    NSString *passwordHash = [[NSString alloc] initWithFormat:@"%d", [self.password1.text hash]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.email.text forKey:@"email"];
    [defaults setObject:self.password1.text forKey:@"password"];
    [defaults setObject:passwordHash forKey:@"passwordhash"];
    [defaults setObject:self.twitter forKey:@"twitter"];
    
    [defaults synchronize];
    
    // Direct to another View segueSettingsView
//    [self dismissViewControllerAnimated:YES completion:^() {
//        [self performSegueWithIdentifier:@"segueSettingsView" sender:self];
//    }];
    [self performSegueWithIdentifier:@"segueSettingsView" sender:self];
}

- (void) alertme:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

@end
