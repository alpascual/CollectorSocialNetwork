//
//  FirstViewController.h
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODRefreshControl.h"
#import "TMQuiltViewController.h"

@interface FeedViewController : TMQuiltViewController

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) ODRefreshControl *refreshControl;

@end
