//
//  SelectPictureViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/26/12.
//
//

#import <UIKit/UIKit.h>

@interface SelectPictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSTimer *viewTimer;
@property (nonatomic,strong) IBOutlet UIImageView *resultImage;

@end
