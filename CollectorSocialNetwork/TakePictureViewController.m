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
@synthesize alert = _alert;

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
    
    self.alert = [[UIAlertView alloc] initWithTitle:@"Upload Image" message:@"Do you want to upload this image?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES",nil];
    self.alert.delegate = self;
    [self.alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == 1 )
    {
        // Upload here
        UtilsClass *util = [[UtilsClass alloc] init];
        NSString *stringID = [util uploadImage:self.resultImage];
        NSLog(@"Picture ID %@", stringID);
        
        // to the share controller
        [self performSegueWithIdentifier:@"uploadPicture" sender:self];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"uploadPicture"])
    {
        // Upload the picture
    }
}

@end
