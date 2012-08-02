//
//  ShareViewController.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/27/12.
//
//

#import "ShareViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JFUrlUtil.h"

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
    
    if ( self.postText.text.length == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Message" message:@"The message cannot be posted without a message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //post the message with the image
    
    //CreatePost(string userid, string title, string comment, string pictureUrl)
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sUserID = [defaults objectForKey:@"userid"];
    
    NSMutableString *postUrl = [[NSMutableString alloc] init];
    [postUrl appendString:@"http://birds.alsandbox.us/api/CreatePost?userid="];
    
    NSString *encodedUserID = [JFUrlUtil encodeUrl:sUserID];
    [postUrl appendString:encodedUserID];
    [postUrl appendString:@"&title="];
    [postUrl appendString:@"&comment="];
    
    NSString *encodedPostText = [JFUrlUtil encodeUrl:self.postText.text];
    [postUrl appendString:encodedPostText];
    [postUrl appendString:@"&pictureUrl="];
    
    NSString *encodedFullImageUrl = [JFUrlUtil encodeUrl:self.fullImageUrl];
    [postUrl appendString:encodedFullImageUrl];
   
    // Post the big url to the server
    NSURL *urlToOpen = [[NSURL alloc] initWithString:postUrl];
    
    NSURLRequest *aReq = [NSURLRequest requestWithURL:urlToOpen];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:aReq delegate:self];
    
    if (theConnection) {
    } else {
        // Inform the user that the connection failed.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Post Failed" message:@"The message cannot be posted, server returned error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];        
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    NSLog(@"data returned: %@", data);
    NSString* newStr = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"data returned String: %@", newStr);
    
    //@todo redirect to main screen?
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"shareCancelSegue"])
    {
        // Delete the picture
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ( [defaults objectForKey:@"lastupload"] != nil) {
            NSString *filename = [defaults objectForKey:@"lastupload"];
            NSString *deleteUrl = [[NSString alloc] initWithFormat:@"http://birds.alsandbox.us/upload/delete?filename=%@", filename];
            NSURL * delURL = [NSURL URLWithString:deleteUrl];
            NSURLRequest *aReq = [NSURLRequest requestWithURL:delURL];
            //@todo check request
            //[[NSURLConnection alloc] initWithRequest:aReq delegate:nil];
        }
    }
}


@end
