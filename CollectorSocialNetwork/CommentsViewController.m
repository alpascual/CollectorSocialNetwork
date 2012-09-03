//
//  CommentsViewController.m
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 8/13/12.
//
//

#import "CommentsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CommentsViewController ()

@end

@implementation CommentsViewController

@synthesize tableView = _tableView;
@synthesize selectedItem = _selectedItem;
@synthesize activityView = _activityView;
@synthesize collectedData = _collectedData;
@synthesize fetchedDataArray = _fetchedDataArray;

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
    
    self.collectedData = nil;
    self.fetchedDataArray = nil;
    self.fetchedDataArray = [[NSMutableArray alloc] init];
    self.collectedData = [[NSMutableData alloc] init];
    
    NSString *fetchUrl = [[NSString alloc] initWithFormat:@"%@%@", [ServerRestUrl getUrlPlus:@"ListComments?postid="] ,self.selectedItem.ID];
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if ( data )
        [self.collectedData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString* newStr = [NSString stringWithUTF8String:[self.collectedData bytes]];
    NSLog(@"data returned String: %@", newStr);
    
    //parse the json string.
    NSError *error = nil;
    NSArray *theJSONArray = [NSDictionary dictionaryWithJSONString:newStr error:&error];
    self.collectedData = nil;
    
    if ( theJSONArray == nil)
    {
        [self.activityView stopAnimating];
        self.activityView.hidden = YES;
        
        //[SVStatusHUD showWithoutImage:@"Failed! Try again"];
        OLGhostAlertView *ghastly = [[OLGhostAlertView alloc] initWithTitle:@"Failed." message: @"Failed, please try again."];
        [ghastly show];
        return;
    }
    
    @try {
        NSLog(@"How many items %d", theJSONArray.count);
        if ( theJSONArray.count == 0)
        {
            [self.activityView stopAnimating];
            self.activityView.hidden = YES;
        }
    }
    @catch (NSException *exception) {
        
        [self.activityView stopAnimating];
        self.activityView.hidden = YES;
        
        //[SVStatusHUD showWithoutImage:@"Failed! Try again"];
        OLGhostAlertView *ghastly = [[OLGhostAlertView alloc] initWithTitle:@"Failed" message: @"Failed please try again."];
        [ghastly show];
        
        return;
    }
    
    for(int i=0; i < theJSONArray.count; i++) {
        NSDictionary *itemDic = [theJSONArray objectAtIndex:i];
        CommentItems *item = [[CommentItems alloc] init];
        item.ID = [itemDic objectForKey:@"ID"];
        item.PostID = [itemDic objectForKey:@"PostID"];
        item.Text = [itemDic objectForKey:@"Text"];
        item.Note1 = [itemDic objectForKey:@"Note1"];
        item.UserId = [itemDic objectForKey:@"UserId"];
        item.Username = [itemDic objectForKey:@"Username"];
        NSString *timeString = [itemDic objectForKey:@"When"];
        item.UsernamePictureUrl = [itemDic objectForKey:@"UsernamePictureUrl"];
        
        timeString = [timeString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        timeString = [timeString stringByReplacingOccurrencesOfString:@")/" withString:@""];
        NSTimeInterval intervalForTimer = [timeString doubleValue] / 1000.0;
        item.When = [[NSDate alloc] initWithTimeIntervalSince1970:intervalForTimer];
        
        [self.fetchedDataArray addObject:item];
    }
    
    [self.tableView reloadData];
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
    return self.fetchedDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    NSUInteger row = [indexPath row];
    
    // Stop spinning
    if ( row == 0 ) {
        [self.activityView stopAnimating];
        self.activityView.hidden = YES;
    }
    
    if ( row > self.fetchedDataArray.count)
        return nil;
    
    CommentItems *item = [self.fetchedDataArray objectAtIndex:row];
    
    // title and detail text
    cell.textLabel.text = item.Username;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:12];
    cell.detailTextLabel.text = item.Text;
    
    // add the time in a label
    UILabel *timelabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 3, 55, 22)];
    timelabel.textColor = [UIColor grayColor];
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.font = [UIFont fontWithName:@"Verdana" size:9];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:item.When];
    timelabel.text = stringFromDate;
    [cell.contentView addSubview:timelabel];
    
    // User image first
    NSURL *userImageUrl = [NSURL URLWithString:item.UsernamePictureUrl];
    NSData * userImageData = [NSData dataWithContentsOfURL:userImageUrl];
    UIImage * userImage = [UIImage imageWithData:userImageData];    
    cell.imageView.image = userImage;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 7;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"shareCommentShowSegue2"] == YES ) {
        AddCommentViewController  *itemController = [segue destinationViewController];
        itemController.selectedItem = self.selectedItem;
    }
    else if ( [segue.identifier isEqualToString:@"backToCommentsSegue"] == YES ) {
        DetailFeedViewController  *itemController = [segue destinationViewController];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 130;
}

@end
