//
//  ViewController.h
//  Jurnee
//
//  Created by ios on 8/7/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "CustomViewCell.h"
#import <Social/Social.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CreateViewController.h"
#import "FMDatabase.h"
#import "SWRevealViewController.h"
#import "Database.h"
#import "Post.h"
#import "ItemViewController.h"

@interface ViewController : UIViewController <SWTableViewCellDelegate>


@property IBOutlet UITableView * tableView ;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property NSArray * assets;
@property NSString * link_de_verificat ;
@property NSMutableArray * array ;
@property ALAssetsLibrary * library ;
@property NSArray * paths ;
@property NSString * docsPath ;
@property NSString * path ;
@property FMDatabase * db;
@property FMResultSet * result ;
@property NSInteger offset;
@property NSDate  * current;
@property NSCalendar * calendar ;
@property NSDateComponents * components;
@property NSString * textToSend;
@property UIImage * imageToSend;
@property NSInteger indexForFacebook;


-(NSInteger)getWeek:(NSInteger )offset;
-(IBAction)goText:(id)sender;
-(IBAction)goImage:(id)sender;

@end
