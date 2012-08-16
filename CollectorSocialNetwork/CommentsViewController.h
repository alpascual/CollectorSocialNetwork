//
//  CommentsViewController.h
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 8/13/12.
//
//

#import <UIKit/UIKit.h>
#import "FeedItems.h"
#import "CommentItems.h"
#import "AddCommentViewController.h"
#import "CJSONDeserializer.h"
#import "NSDictionary_JSONExtensions.h"
#import "SVStatusHUD.h"
#import "DetailFeedViewController.h"

@interface CommentsViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) FeedItems *selectedItem;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic,strong) NSMutableData *collectedData;
@property (nonatomic,strong) NSMutableArray *fetchedDataArray;

- (void) fetchData;

@end
