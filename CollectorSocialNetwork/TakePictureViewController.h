//
//  TakePictureViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/26/12.
//
//

#import <UIKit/UIKit.h>
#import "UtilsClass.h"

@interface TakePictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSTimer *viewTimer;
@property (nonatomic,strong) IBOutlet UIImageView *resultImage;
@property (nonatomic,strong) UIAlertView *alert;

@end
