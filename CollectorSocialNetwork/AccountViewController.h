//
//  AccountViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/25/12.
//
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@end
