//
//  UtilsClass.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/27/12.
//
//

#import <Foundation/Foundation.h>
#import "ServerRestUrl.h"

@interface UtilsClass : NSObject

- (NSString *) uploadImage:(UIImageView*)imageView;
- (NSString*) stringWithUUID;
- (UIImage *)thumbnailOfSize:(CGSize)size image:(UIImage*)bigImage;

@end
