//
//  FeedItems.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/2/12.
//
//

#import <Foundation/Foundation.h>

@interface FeedItems : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *Title;
@property (nonatomic,strong) NSString *Comment;
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *PictureUrl;
@property (nonatomic) NSInteger NumberOfComments;
@property (nonatomic,strong) NSDate *When;

@end
