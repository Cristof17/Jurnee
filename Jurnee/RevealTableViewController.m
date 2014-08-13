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
    
    UIButton * button = (UIButton * )sender ;
    
    //configure the destination
    if (button.tag == 1 )

    {
        NSLog(@"Button tag is 1");
        ViewController *vc = segue.destinationViewController;
        vc.offset = 0;
    }
      if (button.tag == 2 )
    {
        NSLog(@"Button tag is 2");
        ViewController *vc = segue.destinationViewController;
        vc.offset = 1;
    }
      if (button.tag == 3 )
    {
        NSLog(@"Button tag is 3");
        ViewController *vc = segue.destinationViewController;
        vc.offset = 2;
    }
    
    //configure the segue
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue* rvcs = (SWRevealViewControllerSegue*) segue;
        
        SWRevealViewController* rvc = self.revealViewController;
        NSAssert( rvc != nil, @"oops! must have a revealViewController" );
        
        NSAssert( [rvc.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );
        
        rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc)
        {
            UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:dvc];
            [rvc pushFrontViewController:nc animated:YES];
        };
    }

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
