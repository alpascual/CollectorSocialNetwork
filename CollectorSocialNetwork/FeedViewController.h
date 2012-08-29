//
//  FirstViewController.h
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODRefreshControl.h"
//#import "TMQuiltView.h"
#import "CJSONDeserializer.h"
#import "NSDictionary_JSONExtensions.h"
#import "FeedItems.h"
#import "UtilsClass.h"
#import "DetailFeedViewController.h"
#import "SVStatusHUD.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "CacheObjects.h"

@interface FeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) ODRefreshControl *refreshControl;
@property (nonatomic,strong) NSMutableArray *fetchedDataArray;
//@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) FeedItems *selectedItem;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic,strong) NSMutableData *collectedData;
@property (nonatomic,strong) NSArray *backupResponseArray;
@property (nonatomic,strong) NSMutableArray *userImageArray;
@property (nonatomic,strong) NSMutableArray *pictureImageArray;
@property (nonatomic) BOOL bPictureView;


- (void) fetchData;
- (void) processJsonResults:(NSString*)newStr;

@end
