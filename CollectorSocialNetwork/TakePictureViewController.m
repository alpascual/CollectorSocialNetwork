//
//  TakePictureViewController.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/26/12.
//
//

#import "TakePictureViewController.h"

@interface TakePictureViewController ()

@end

@implementation TakePictureViewController

@synthesize viewTimer = _viewTimer;
@synthesize resultImage = _resultImage;

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
	// Do any additional setup after loading the view.
    
    self.viewTimer = [NSTimer scheduledTimerWithTimeInterval:(0.5) target:self selector:
                     @selector(refreshTimer:) userInfo:nil repeats:NO];
    
    
}

- (void)refreshTimer:(NSTimer *)timer
{
    @try
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
    
        [self presentModalViewController:picker animated:YES];
    }
    @catch (NSException *exception)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Camera" message:@"Camera is not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    [picker dismissModalViewControllerAnimated:YES];
    // Image created, retake, store
    self.resultImage.image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
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
