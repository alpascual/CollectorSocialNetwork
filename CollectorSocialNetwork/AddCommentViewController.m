//
//  AddCommentViewController.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/7/12.
//
//

#import "AddCommentViewController.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController

@synthesize postText = _postText;
@synthesize commentButton = _commentButton;
@synthesize charactersLeft = _charactersLeft;
@synthesize selectedItem = _selectedItem;

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
	
    self.postText.delegate = self;
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

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"number of characters %d", textView.text.length);
    
    NSInteger left = 150 - textView.text.length;
    if ( left < 0 )
    {
        //disable something
        self.commentButton.enabled = NO;
    }
    else
    {
        self.commentButton.enabled = YES;
        self.charactersLeft.text = [[NSString alloc] initWithFormat:@"%d characters left", left];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"commentCancelSegue"])
    {
        //Do something before cancelling?
    }
    else if ([[segue identifier] isEqualToString:@"commentPressed"]) {
        [self postPressed:nil];
    }
}

- (IBAction)postPressed:(id)sender {
    
    if ( self.postText.text.length == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Message" message:@"The message cannot be posted without a message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //post the message with the image
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sUserID = [defaults objectForKey:@"userid"];
    
    //CreateComment(string userid, string postid, string text, string username)
    NSMutableString *postUrl = [[NSMutableString alloc] init];
    [postUrl appendString:@"http://birds.alsandbox.us/api/CreateComment?userid="];
    
    NSString *encodedUserID = [JFUrlUtil encodeUrl:sUserID];
    [postUrl appendString:encodedUserID];
    [postUrl appendString:@"&postid="];
    [postUrl appendString:self.selectedItem.ID];
    
    [postUrl appendString:@"&text="];    
    NSString *encodedPostText = [JFUrlUtil encodeUrl:self.postText.text];
    [postUrl appendString:encodedPostText];
       
    [postUrl appendString:@"&username="];
    [postUrl appendString:[defaults objectForKey:@"email"]];
    
    // Post the big url to the server
    NSURL *urlToOpen = [[NSURL alloc] initWithString:postUrl];
    
    NSURLRequest *aReq = [NSURLRequest requestWithURL:urlToOpen];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:aReq delegate:self];
    
    if (theConnection) {
    } else {
        // Inform the user that the connection failed.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Comment Failed" message:@"The comment cannot be posted, server returned error or no connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}


@end