//
//  DetailFeedViewController.m
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 8/4/12.
//
//

#import "DetailFeedViewController.h"

@interface DetailFeedViewController ()

@end

@implementation DetailFeedViewController

@synthesize detailedImage = _detailedImage;
@synthesize userImage = _userImage;
@synthesize userName = _userName;
@synthesize detailText = _detailText;
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
	
    self.detailedImage.layer.cornerRadius = 5;
    self.userImage.layer.cornerRadius = 3;
    
    // get the item in the right places
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
