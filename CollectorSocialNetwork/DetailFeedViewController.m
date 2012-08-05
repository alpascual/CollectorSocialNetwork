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
