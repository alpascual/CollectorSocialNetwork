//
//  SelectPictureViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/26/12.
//
//

#import <UIKit/UIKit.h>
#import "UtilsClass.h"
#import "SVStatusHUD.h"
#import "OLGhostAlertView.h"

@interface SelectPictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic,strong) NSTimer *viewTimer;
@property (nonatomic,strong) IBOutlet UIImageView *resultImage;
@property (nonatomic,strong) UIAlertView *alert;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityView;

-(void) UploadingBackgroundProcess:(NSString*)nothing;
-(void)doneParsing;

@end
