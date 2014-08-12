//
//  RevealTableViewController.h
//  Jurnee
//
//  Created by ios on 8/12/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewCell.h"
#import "ViewController.h"

@interface RevealTableViewController : UIViewController

@property UIButton * buttonToday ;
@property UIButton * buttonOneWeek ;
@property UIButton * buttonTwoWeeks;

-(IBAction)goToday:(id)sender;
-(IBAction)goOneWeek:(id)sender;
-(IBAction)goTwoWeeks:(id)sender;

@end
