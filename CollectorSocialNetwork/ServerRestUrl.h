//
//  ServerRestUrl.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/22/12.
//
//

#import <Foundation/Foundation.h>

#define kHostUrl @"http://bird.alpascual.com"
#define kFullUrl @"/api/"
#define kFullUrlUpload @"/upload/"

@interface ServerRestUrl : NSObject

+ (NSString*) getUrlPlus:(NSString*) suffix;
+ (NSString*) getUploadUrlPlus:(NSString*) suffix;


@end
