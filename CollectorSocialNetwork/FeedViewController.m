//
//  FirstViewController.m
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
//    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

//- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
//{
//    double delayInSeconds = 3.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [refreshControl endRefreshing];
//    });
//}

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


@end
