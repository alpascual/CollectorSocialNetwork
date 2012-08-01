//
//  ShareViewController.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/27/12.
//
//

#import "ShareViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

@synthesize postText = _postText;
@synthesize imageThumbnail = _imageThumbnail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self.postText layer] setBorderWidth:1.5];
    [[self.postText layer] setCornerRadius:15];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( [defaults objectForKey:@"lastupload"] != nil) {
        NSString *filename = [defaults objectForKey:@"lastupload"];
        
        NSString *
        NSURL * imageURL = [NSURL URLWithString:@"http://birds.alsandbox.us/LC.jpg"];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
