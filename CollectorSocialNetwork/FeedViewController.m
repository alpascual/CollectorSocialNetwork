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
        item.UserID = [itemDic objectForKey:@"UserID"];
        item.Title = [itemDic objectForKey:@"Title"];
        item.Comment = [itemDic objectForKey:@"Comment"];
        
        [self.fetchedDataArray addObject:item];
    }
    
//    NSDictionary *data = [theDictionary objectForKey:@"data"];
//    NSArray *currentDictionaty = [data objectForKey:@"current_condition"];    
//    NSDictionary *temp = [currentDictionaty objectAtIndex:0];
    
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
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.numberOfLines = 2;
    
    //@todo
    //cell.textLabel.text = [self.labelsArray objectAtIndex:row];
    //cell.detailTextLabel.text = [self.myArray objectAtIndex:row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
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
