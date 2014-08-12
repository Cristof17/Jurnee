//
//  Database.m
//  Jurnee
//
//  Created by ios on 8/12/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import "Database.h"


@implementation Database

Database *database;

+(Database *)sharedInstance
{
    if( database == nil) database = [[Database alloc] init];
    
    return database;
}

@end
