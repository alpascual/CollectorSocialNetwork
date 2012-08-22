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
@synthesize readCommentButton = _readCommentButton;

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
    if ( self.selectedItem != nil ) {
        self.userName.text = self.selectedItem.Username;
        self.detailText.text = self.selectedItem.Comment;
        
        //add the images from url
        // Picture uploaded
        NSString *fullImageUrl = [[NSString alloc] initWithFormat:@"%@%@", [ServerRestUrl getUrlPlus:@"upload/get?filename="] ,self.selectedItem.PictureUrl];
        NSURL * imageURL = [NSURL URLWithString:fullImageUrl];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        self.detailedImage.image = image;
        
        NSURL *userImageUrl = [NSURL URLWithString:self.selectedItem.UsernamePictureUrl];
        NSData * userImageData = [NSData dataWithContentsOfURL:userImageUrl];
        UIImage * userImage = [UIImage imageWithData:userImageData];
        self.userImage.image = userImage;
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"shareCommentShowSegue"] == YES ) {
        AddCommentViewController  *itemController = [segue destinationViewController];
        itemController.selectedItem = self.selectedItem;
    }
    else if ( [segue.identifier isEqualToString:@"commentsListSegue"] == YES ) {
        CommentsViewController  *itemController = [segue destinationViewController];
        itemController.selectedItem = self.selectedItem;
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
