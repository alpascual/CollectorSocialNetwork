//
//  AccountViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/25/12.
//
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "AppDelegate.h"
#import "SVStatusHUD.h"
#import "ServerRestUrl.h"
#import "OLGhostAlertView.h"

@interface AccountViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *myArray;
@property (nonatomic,strong) NSMutableArray *labelsArray;
@property (nonatomic,strong) IBOutlet UIImageView *twitterImage;

@end
