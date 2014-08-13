//
//  Post.h
//  Jurnee
//
//  Created by ios on 8/12/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject


@property NSInteger id ;
@property UIImage * image ;
@property NSURL * url;
@property NSString * description;
@property NSInteger year;
@property NSInteger month;
@property NSInteger day;


@end
