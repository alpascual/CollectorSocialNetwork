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
@synthesize fullImageUrl = _fullImageUrl;

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
        self.fullImageUrl = [[NSString alloc] initWithFormat:@"http://birds.alsandbox.us/upload/get?filename=%@", filename];
        NSURL * imageURL = [NSURL URLWithString:self.fullImageUrl];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        self.imageThumbnail.image = image;
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

- (IBAction)postPressed:(id)sender {
    //post the message with the image
    
    //CreatePost(string userid, string title, string comment, string pictureUrl)
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sUserID = [defaults objectForKey:@"userid"];
    
    NSMutableString *postUrl = [[NSMutableString alloc] init];
    [postUrl appendString:@"http://birds.alsandbox.us/api/CreatePost?userid="];
    [postUrl appendString:sUserID];
    [postUrl appendString:@"&title="];
    [postUrl appendString:@"&comment="];
    [postUrl appendString:self.postText.text];
    [postUrl appendString:@"&pictureUrl="];
    [postUrl appendString:self.fullImageUrl];
    
}

@end
