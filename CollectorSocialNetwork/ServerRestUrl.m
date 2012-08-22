//
//  ServerRestUrl.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/22/12.
//
//

#import "ServerRestUrl.h"

@implementation ServerRestUrl


+ (NSString*) getUrlPlus:(NSString*) suffix
{
    return [[NSString alloc] initWithFormat:@"%@%@%@", kHostUrl, kFullUrl, suffix];
}

+ (NSString*) getUploadUrlPlus:(NSString*) suffix
{
    return [[NSString alloc] initWithFormat:@"%@%@%@", kHostUrl ,kFullUrlUpload, suffix];
}

@end
