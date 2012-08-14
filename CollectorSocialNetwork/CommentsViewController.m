//
//  CommentsViewController.m
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 8/13/12.
//
//

#import "CommentsViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

@synthesize tableView = _tableView;
@synthesize selectedItem = _selectedItem;
@synthesize activityView = _activityView;

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
	
    [self fetchData];
}

- (void) fetchData
{
    [self.activityView startAnimating];
    self.activityView.hidden = NO;
    
    //self.collectedData = nil;
    
    //@todo get all data here
//    self.fetchedDataArray = [[NSMutableArray alloc] init];
//    self.collectedData = [[NSMutableData alloc] init];
    
    NSString *fetchUrl = [[NSString alloc] initWithFormat:@"http://birds.alsandbox.us/api/ListComments?postid=%@", self.selectedItem.ID];
    NSURL * nURL = [NSURL URLWithString:fetchUrl];
    NSURLRequest *aReq = [NSURLRequest requestWithURL:nURL];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:aReq delegate:self];
    if (theConnection) {
        
    } else {
        // inform the user that the download could not be made
        NSLog(@"cannot fetch now");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Cannot access the feed, internet down or problem on the server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    NSUInteger row = [indexPath row];
   
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"shareCommentShowSegue2"] == YES ) {
        AddCommentViewController  *itemController = [segue destinationViewController];
        itemController.selectedItem = self.selectedItem;
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger row = [indexPath row];
//    self.selectedItem = [self.fetchedDataArray objectAtIndex:row];
//    
//    [self performSegueWithIdentifier:@"detailSegue" sender:self];
//    //@todo do the detailSegue and add the selecteditem
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    if ( self.bPictureView == YES)
//        return 200;
//    else
//        return 130;
//}

@end
