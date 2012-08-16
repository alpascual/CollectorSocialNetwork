//
//  AccountViewController.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/25/12.
//
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize tableView = _tableView;
@synthesize myArray = _myArray;
@synthesize twitterImage = _twitterImage;
@synthesize labelsArray = _labelsArray;

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
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NetworkStatus netStatus = [app.internetReachability currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        [SVStatusHUD showWithoutImage:@"No internet"];
        return;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *email = [defaults objectForKey:@"email"];
    NSString *twitter = [defaults objectForKey:@"twitter"];
    self.myArray = [[NSMutableArray alloc] init];
    [self.myArray addObject:email];
    
    self.labelsArray = [[NSMutableArray alloc] init];
    [self.labelsArray addObject:@"email"];
    [self.labelsArray addObject:@"twitter"];
    
    if ( twitter != nil) {
        [self.myArray addObject:twitter];
    
        //https://api.twitter.com/1/users/profile_image?screen_name=twitterapi&size=normal
        NSString *twitterPicture = [[NSString alloc] initWithFormat:@"https://api.twitter.com/1/users/profile_image?screen_name=%@&size=bigger", [defaults objectForKey:@"twitter"]];
        
        NSURL * imageURL = [NSURL URLWithString:twitterPicture];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        
        self.twitterImage.image = image;
    }
    
    [self.tableView reloadData];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.myArray.count;
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
   
    cell.textLabel.text = [self.labelsArray objectAtIndex:row];
    cell.detailTextLabel.text = [self.myArray objectAtIndex:row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
}

- (IBAction)goHome:(id)sender
{   
    [self performSegueWithIdentifier:@"HomeFromSettings" sender:self];
}

- (IBAction)deleteAccount:(id)sender {
    // Delete the account
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ( [defaults objectForKey:@"userid"] != nil )
    {
        NSString *accountID = [defaults objectForKey:@"userid"];
        
        //@todo delete now here and then delete the keys
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleting Account" message:@"Are you sure? TODO right now does not delete it on the server" delegate:nil cancelButtonTitle:@"TODO" otherButtonTitles:nil];
        [alert show];
        
        [defaults removeObjectForKey:@"userid"];
        [defaults removeObjectForKey:@"email"];
        [defaults removeObjectForKey:@"password"];
        [defaults removeObjectForKey:@"passwordhash"];
        [defaults removeObjectForKey:@"twitter"];
        
        [defaults synchronize];
    }
    
    
}

@end
