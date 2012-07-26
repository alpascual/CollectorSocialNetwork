//
//  TakePictureViewController.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/26/12.
//
//

#import <UIKit/UIKit.h>

@interface TakePictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSTimer *viewTimer;
@end
