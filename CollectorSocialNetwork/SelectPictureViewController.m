//
//  SelectPictureViewController.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/26/12.
//
//

#import "SelectPictureViewController.h"

@interface SelectPictureViewController ()

@end

@implementation SelectPictureViewController

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
	
    self.viewTimer = [NSTimer scheduledTimerWithTimeInterval:(0.5) target:self selector:
                      @selector(refreshTimer:) userInfo:nil repeats:NO];
}

- (void)refreshTimer:(NSTimer *)timer
{   
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    [self presentModalViewController:picker animated:YES];
    
    
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
