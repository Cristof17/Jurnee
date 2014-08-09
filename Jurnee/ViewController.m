//
//  ViewController.m
//  Jurnee
//
//  Created by ios on 8/7/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assets.count ;
}



-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * TAG = @"TAG";
    
    CustomViewCell * cell = (CustomViewCell * )[self.tableView dequeueReusableCellWithIdentifier:TAG];
    
    if(cell == nil){
        cell = [[CustomViewCell alloc]init];
    }
    
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    NSMutableArray * rightUtilityButtons  = [NSMutableArray new];

    UIImage * facebook_image = [UIImage imageNamed:@"facebook.png"];
    UIColor * facebook_color = [UIColor colorWithRed:1.0f green:1.0f blue:0.35 alpha:0.6];
    [leftUtilityButtons sw_addUtilityButtonWithColor:facebook_color icon:facebook_image];
    
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.23f blue:0.188 alpha:1.0f] title:@"Delete"];
    
    cell.rightUtilityButtons  = rightUtilityButtons ;
    cell .leftUtilityButtons = leftUtilityButtons ;
    
    cell.delegate = self;
    
    [cell.label setText:@"Yuhuu"];
    cell.imageView.image = [UIImage imageNamed:@"default.png"];
    
    
    ALAsset * asset_curr = self.assets[indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:[asset_curr thumbnail]];
    
    
    return cell;
}



-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            NSLog(@"Logging to facebook");
            [self postToFacebook:self];
            break;
            
        default:
            break;
    }
}


-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            NSLog(@"Deleting....");
            break;
            
        default:
            break;
    }
}



-(void)postToFacebook:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:@"Post to Facebook "];
        [controller addImage:[UIImage imageNamed:@"default.png"]];
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

-(void)tableView:(UITableView * )tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row selected at position %ld ",(long)indexPath.row);
    
}




- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.link_de_verificat = @"assets-library://asset/asset.PNG?id=061D4825-C1BE-4B0F-9ADC-CAEBA1298161&ext=PNG";
    
    self.assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    
    ALAssetsLibrary * assetsLibrary = [ViewController defaultAssetslibrary];
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group , BOOL *  stop){
        [group enumerateAssetsUsingBlock:^(ALAsset *result , NSUInteger index , BOOL * stop){
            if(result){
                [tmpAssets addObject:result];
              
            }
        }];
        
        self.assets = tmpAssets;
        
        NSLog(@"Library has  ... %d ",[self.assets count]);
        
        [self.tableView reloadData ];
    }failureBlock:^(NSError * error){
        NSLog(@"Error loading images in TableView :  %@",error);
    }];
    
    
}


+(ALAssetsLibrary * )defaultAssetslibrary{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary * library = nil;
    dispatch_once (&pred ,^{
        library = [[ALAssetsLibrary alloc]init];
    });
    return library;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

