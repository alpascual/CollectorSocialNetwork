//
//  CacheObjects.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/29/12.
//
//

#import "CacheObjects.h"

@implementation CacheObjects

@synthesize cachedFetchedArray = _cachedFetchedArray;

+ (id)sharedCache {
    static CacheObjects *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[self alloc] init];
    });
    return sharedCache;
}

- (id)initWithArray:(NSMutableArray*) fetchedArray {
    if (self = [super init]) {
        self.cachedFetchedArray = fetchedArray;
    }
    return self;
}

@end
