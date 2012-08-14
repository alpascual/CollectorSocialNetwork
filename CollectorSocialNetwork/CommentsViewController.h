//
//  CommentsViewController.h
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 8/13/12.
//
//

#import <UIKit/UIKit.h>
#import "FeedItems.h"
#import "AddCommentViewController.h"

@interface CommentsViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) FeedItems *selectedItem;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityView;

- (void) fetchData;

@end
