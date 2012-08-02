//
//  ShareViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/27/12.
//
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITextView *postText;
@property (nonatomic,strong) IBOutlet UIImageView *imageThumbnail;
@property (nonatomic,strong) NSString *fullImageUrl;

@end
