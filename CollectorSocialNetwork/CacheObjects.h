//
//  CacheObjects.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/29/12.
//
//

#import <Foundation/Foundation.h>

@interface CacheObjects : NSObject

@property (strong) NSMutableArray *cachedFetchedArray;
@property (strong) NSMutableArray *cachedPictureImageArray;
@property (strong) NSMutableArray *cachedUserImageArray;

+ (id)sharedCache;

@end
