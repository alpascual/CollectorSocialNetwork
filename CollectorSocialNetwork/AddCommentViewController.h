//
//  AddCommentViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/7/12.
//
//

#import <UIKit/UIKit.h>

#import "FeedItems.h"
#import "JFUrlUtil.h"
#import "CommentsViewController.h"

@interface AddCommentViewController : UIViewController <UITextViewDelegate>

@property (nonatomic,strong) IBOutlet UITextView *postText;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *commentButton;
@property (nonatomic,strong) IBOutlet UILabel *charactersLeft;
@property (nonatomic,strong) FeedItems *selectedItem;

@end
