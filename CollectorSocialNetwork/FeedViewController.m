//
//  FirstViewController.m
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedViewController.h"
#import "TMPhotoQuiltViewCell.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

@synthesize tableView = _tableView;
@synthesize refreshControl = _refreshControl;
@synthesize fetchedDataArray = _fetchedDataArray;
//@synthesize images = _images;

- (void)viewDidLoad
{
    //@todo redirect if not acccount with alert first
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ( [defaults objectForKey:@"userid"] == nil )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Need Account" message:@"You need to go to settings and create an account before accessing the posts" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        return;
    }

    [super viewDidLoad];
    
    //self.quiltView.backgroundColor = [UIColor blackColor];
    
    [self fetchData];
    
	
    self.refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [self.refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
    
    [self fetchData];
}

- (void) fetchData
{
    //@todo get all data here
    self.fetchedDataArray = [[NSMutableArray alloc] init];
    
    NSString *fetchUrl = @"http://birds.alsandbox.us/api/LastPosts?many=50";
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
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    NSLog(@"data returned: %@", data);
    NSString* newStr = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"data returned String: %@", newStr);
    
    //parse the json string.
    NSError *error = nil;
    NSArray *theJSONArray = [NSDictionary dictionaryWithJSONString:newStr error:&error];
    
    NSLog(@"How many items %d", theJSONArray.count);
    
    for(int i=0; i < theJSONArray.count; i++) {
        NSDictionary *itemDic = [theJSONArray objectAtIndex:i];
        FeedItems *item = [[FeedItems alloc] init];
        item.ID = [itemDic objectForKey:@"ID"];
        item.UserID = [itemDic objectForKey:@"UserId"];
        item.Title = [itemDic objectForKey:@"Title"];
        item.Comment = [itemDic objectForKey:@"Comment"];
        item.UsernamePictureUrl = [itemDic objectForKey:@"UsernamePictureUrl"];
        
        NSString *timeString = [itemDic objectForKey:@"When"];
        timeString = [timeString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        timeString = [timeString stringByReplacingOccurrencesOfString:@")/" withString:@""];
        NSTimeInterval intervalForTimer = [timeString doubleValue] / 1000.0;
        item.When = [[NSDate alloc] initWithTimeIntervalSince1970:intervalForTimer];
        
        item.PictureUrl = [itemDic objectForKey:@"PictureUrl"];
        item.NumberOfComments = [[itemDic objectForKey:@"NumberOfComments"] intValue];
        item.Username = [itemDic objectForKey:@"Username"];
        
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    NSUInteger row = [indexPath row];
    FeedItems *item = [self.fetchedDataArray objectAtIndex:row];
    
    if ( item.NumberOfComments > 0 )
    {
        //add a converstation logo somewhere
        UIImageView *backgroundCellImage=[[UIImageView alloc] initWithFrame:CGRectMake(260, 3, 14, 12)];
        backgroundCellImage.image=[UIImage imageNamed:@"09-chat-2.png"];
        [cell.contentView addSubview:backgroundCellImage];
    }
    
    // add the time in a label
    UILabel *timelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 55, 22)];
    timelabel.textColor = [UIColor grayColor];
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.font = [UIFont fontWithName:@"Verdana" size:9];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:item.When];
    timelabel.text = stringFromDate;
    [cell.contentView addSubview:timelabel];
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.numberOfLines = 10;
    
    //@todo
    cell.textLabel.text = item.Username;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:12];
    cell.detailTextLabel.text = item.Comment;
    
    // User image first
    UtilsClass *util = [[UtilsClass alloc] init];
    NSURL *userImageUrl = [NSURL URLWithString:item.UsernamePictureUrl];
    NSData * userImageData = [NSData dataWithContentsOfURL:userImageUrl];
    UIImage * userImage = [UIImage imageWithData:userImageData];
    UIImage *userThumb = [util thumbnailOfSize:CGSizeMake(50,50) image:userImage];
    cell.imageView.image = userThumb;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 5;
    
    // Picture uploaded
    NSString *fullImageUrl = [[NSString alloc] initWithFormat:@"http://birds.alsandbox.us/upload/get?filename=%@", item.PictureUrl];
    NSURL * imageURL = [NSURL URLWithString:fullImageUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];    
    UIImage *thumb = [util thumbnailOfSize:CGSizeMake(40,40) image:image];
    
    UIImageView *uploadCellImage=[[UIImageView alloc] initWithFrame:CGRectMake(200, 3, 40, 40)];
    uploadCellImage.image=thumb;
    uploadCellImage.layer.masksToBounds = YES;
    uploadCellImage.layer.cornerRadius = 5;
    [cell.contentView addSubview:uploadCellImage];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 110;
}


//#pragma mark - QuiltViewControllerDataSource
//
//- (NSArray *)images {
//    
//    if ( !self.images) {
//        self.images = [[NSMutableArray alloc] init];
//        [self.images addObject:@"lake.jpg"];
//    }
//    
//
//    
//    return self.images;
//}
//
//- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
//    return [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
//}
//
//- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
//    return [self.images count];
//}
//
//- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
//    
//    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
//    if (!cell) {
//        cell = [[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"];
//    }
//    
//    cell.photoView.image = [self imageAtIndexPath:indexPath];
//    cell.titleLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
//    return cell;
//}
//
//#pragma mark - TMQuiltViewDelegate
//
//- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
//    
//    
//    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
//        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
//        return 3;
//    } else {
//        return 2;
//    }
//}
//
//- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath {
//    return [self imageAtIndexPath:indexPath].size.height / [self quiltViewNumberOfColumns:quiltView];
//}

@end
