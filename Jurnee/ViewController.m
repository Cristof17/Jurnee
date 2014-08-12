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
    NSString * query = @"SELECT COUNT(*) FROM fields";
    FMResultSet * result = [self.db executeQuery:query];
    [result next];
    int count = [result intForColumnIndex:0];
    
    return count ;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    self.result = [self.db 	executeQuery:@"SELECT * FROM fields"];
    NSLog(@"Reloading data into table from database");
    
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
    
    //Getting asset image using string from URL array modified by the CreateViewController
    
    FMResultSet * resultSet = [self.db executeQuery:@"SELECT * FROM fields WHERE id = %d",indexPath.row+1];
    NSString * path;
    NSString * description ;
    
    if(!resultSet)
        NSLog(@"Error retrieving information from database ");
    
    else{
        if([resultSet next]){
            path = [resultSet valueForKey:@"path"];
            description = [resultSet valueForKey:@"description"];
            
            NSLog(@"Path in %@ ",path);
            NSLog(@"Description is %@",description);

        }
    }
    
    [self.library assetForURL:[NSURL URLWithString:path]
    
     
     
    resultBlock:^(ALAsset * asset){
        cell.imageView.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
        cell.label.text = description ;
        NSLog(@"Image loaded successfully ");
        
    }
    failureBlock:^(NSError * error){
        NSLog(@"An error occurred when loading image ");
    }];
    
    
   
    
    
//    ALAsset * asset_curr = self.assets[indexPath.row];
    
//    cell.imageView.image = [UIImage imageWithCGImage:[asset_curr thumbnail]];
    
    
    return cell;

}



-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            NSLog(@"Logging to facebook");
            [self postToFacebook:self withId:index];
            break;
            
        default:
            break;
    }
}


-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            NSLog(@"Deleting....");
            [self.array removeObjectAtIndex:index];
            [self.tableView reloadData ];
            
            
            break;
            
        default:
            break;
    }
}



-(void)postToFacebook:(id)sender withId:(NSInteger)poz{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:@"Post to Facebook "];
        [controller addImage:[UIImage imageNamed:[self.array objectAtIndex:poz]]];
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

-(void)tableView:(UITableView * )tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row selected at position %ld ",(long)indexPath.row);
    
}




- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.revealButtonItem setTarget:self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];

    
    if(self.library == nil){
        self.library = [[ALAssetsLibrary alloc]init];
    }
    
    NSLog(@"viewDidLoad");
    
    
    
    //setting up the sliding menu button
    
    
    //....
    
    //Accessing the database
    
    //[[Database sharedInstance] openDatabase];
    
    //design patttern singleton
    if(self.db == nil){
        self.paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.docsPath = [self.paths  objectAtIndex:0];
        self.path   = [self.docsPath stringByAppendingPathComponent:@"jurnee.sqlite"];
        // stringByAppendingPathComponent:
    
        self.db = [FMDatabase databaseWithPath:self.path];
    }
    
    
    if(![self.db open]){
        NSLog(@"Cannot open database ");
        
        return;
    }
    else
    {
        [self.db executeUpdate:@"create table fields(id integer primary key , path text ,description text , year integer , month integer ,  day interger)"];
        
        self.result = [self.db 	executeQuery:@"SELECT * FROM fields"];
        
    }
    
                     
    
    
    //Retrieving data from library and populate the TableView
    
    /*
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
    */
    
    
    //Instantiating array
    
    if(self.array == nil){
        self.array = [[NSMutableArray alloc]init];
    }
    
    
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if(self.array == nil){
        NSLog(@"Array is nil , creating one");
    }
    
    if( [segue.identifier isEqualToString:@"createSegue" ]){
        NSLog(@"Passing the array ");
        CreateViewController * destination = segue.destinationViewController;
//        destination.array = self.array;
        destination.db = self.db;
    }
    
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

