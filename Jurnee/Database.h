//
//  Database.h
//  Jurnee
//
//  Created by ios on 8/12/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Database : NSObject

+(Database *)sharedInstance;
-(void)openDatabase;

@end
