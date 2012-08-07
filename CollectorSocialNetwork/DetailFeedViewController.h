//
//  DetailFeedViewController.h
//  CollectorSocialNetwork
//
//  Created by Albert Pascual on 8/4/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DetailFeedViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIImageView *detailedImage;
@property (nonatomic,strong) IBOutlet UIImageView *userImage;
@property (nonatomic,strong) IBOutlet UILabel *detailText;
@property (nonatomic,strong) IBOutlet UILabel *userName;

@end
