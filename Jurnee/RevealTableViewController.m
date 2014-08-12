//
//  RevealTableViewController.m
//  Jurnee
//
//  Created by ios on 8/12/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import "RevealTableViewController.h"

@interface RevealTableViewController ()

@end

@implementation RevealTableViewController


-(IBAction)goToday:(id)sender{
    NSLog(@"Today pressed ");
}
-(IBAction)goOneWeek:(id)sender{
    NSLog(@"One week ago pressed ");
}
-(IBAction)goTwoWeeks:(id)sender{
    NSLog(@"Two weeks ago pressed ");
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
