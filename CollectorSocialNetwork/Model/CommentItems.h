//
//  CommentItems.h
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 8/14/12.
//
//

#import <Foundation/Foundation.h>

@interface CommentItems : NSObject

//    public class Comment
//    {
//        [Key]
//        public string ID { get; set; }
//        public string PostID { get; set; }
//        public string Text { get; set; }
//        public string Note1 { get; set; }
//        public string UserId { get; set; }
//        public string Username { get; set; }
//        public DateTime When { get; set; }
//    }

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *PostID;
@property (nonatomic,strong) NSString *Text;
@property (nonatomic,strong) NSString *Note1;
@property (nonatomic,strong) NSString *UserId;
@property (nonatomic,strong) NSString *Username;
@property (nonatomic,strong) NSDate *When;

@end
