//
//  ShareViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/27/12.
//
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController <UITextViewDelegate>

@property (nonatomic,strong) IBOutlet UITextView *postText;
@property (nonatomic,strong) IBOutlet UIImageView *imageThumbnail;
@property (nonatomic,strong) NSString *fullImageUrl;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) IBOutlet UILabel *charactersLeft;

- (IBAction)postPressed:(id)sender;

@end
