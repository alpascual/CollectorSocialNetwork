//
//  UtilsClass.m
//  CollectorSocialNetwork
//
//  Created by Al Pascual on 7/27/12.
//
//

#import "UtilsClass.h"

@implementation UtilsClass

- (NSString *) uploadImage:(UIImageView*)imageView
{
    UIImage *myImage = imageView.image;
    NSData *imageData = UIImagePNGRepresentation(myImage);
    // setting up the URL to post to
    NSString *urlString = @"http://birds.alsandbox.us/uploads/index";
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSString *guid = [self stringWithUUID];
    NSString *filename = [[NSString alloc] initWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.png\"\r\n", guid];
    /*
     now lets create the body of the post
     */
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[filename dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returning %@", returnString);
    
    //@todo send guid?
    
    return returnString;
}

- (NSString*) stringWithUUID {
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (__bridge NSString *)(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

@end
