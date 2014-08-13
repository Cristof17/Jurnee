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
    NSString * query = [NSString stringWithFormat:@"SELECT COUNT(*) FROM fields WHERE week = %d ",[self getWeek:self.offset]];
    FMResultSet * result = [self.db executeQuery:query];
    [result next];
    int count = [result intForColumnIndex:0];
    
    return count ;
}


-(NSInteger) getWeek:(NSInteger )offset{
    
    
    NSDate * data = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * components = [calendar components:NSYearCalendarUnit | NSWeekCalendarUnit fromDate:data];;
    components.week -= offset;

    NSLog(@"Week is %ld ",[components week]);
    return [components week];
}


- (UIImage*)rotateUIImage:(UIImage*)sourceImage clockwise:(BOOL)clockwise
{
    CGSize size = sourceImage.size;
    UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
    [[UIImage imageWithCGImage:[sourceImage CGImage] scale:1.0 orientation:clockwise ? UIImageOrientationRight : UIImageOrientationLeft] drawInRect:CGRectMake(0,0,size.height ,size.width)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getWeek:0];
       
    
    
    FMResultSet *set = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM fields WHERE week= %ld",(long)[self getWeek:self.offset]]];
    
    while([set next]){
        NSLog(@"Path is %@ %@",[set stringForColumnIndex:1],[set stringForColumnIndex:2]);
    }
    
//    [self.db executeUpdate:[NSString stringWithFormat:@"drop table if exists fields"]];
    [self.db executeUpdate:@"create table fields(id integer primary key , path text ,description text , week integer)"];
    
    self.result = [self.db 	executeQuery:@"SELECT * FROM fields"];
    
    
    self.array = [[NSMutableArray alloc]init];
    
    while([self.result next]){
        
        __block UIImage * img ;
        
        Post * newPost = [[Post alloc]init];
        [newPost setId:[self.result intForColumnIndex:0]];
        [newPost setUrl:[NSURL URLWithString:[self.result stringForColumnIndex:1]]];
        [newPost setDescription:[self.result stringForColumnIndex:2]];
        [newPost setYear:[self.result intForColumnIndex:3]];
        [newPost setMonth:[self.result intForColumnIndex:4]];
        [newPost setDay:[self.result intForColumnIndex:5]];
        
        [self.library assetForURL:newPost.url
         
                      resultBlock:^(ALAsset * asset){
                          newPost.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage scale:1.0f orientation:UIImageOrientationRight ];
                          //cell.label.text = post.description;
                          
                      }
                     failureBlock:^(NSError * error){
                         NSLog(@"An error occurred when loading image in viewWillAppear ");
                     }];
//        
//        newPost.image = [self rotateUIImage:img clockwise:YES	];
        [self.array addObject:newPost];
        [self.tableView reloadData];
    }
    
    NSLog(@"Reloading data into table from database");
    
}



-(void)tableView:(UITableView * )tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row selected at position %ld ",(long)indexPath.row);
    
    Post * post = [self.array objectAtIndex:indexPath.row];
    

    
    self.textToSend  = post.description;
    self.imageToSend = post.image;
    
    [self performSegueWithIdentifier:@"itemSegue" sender:self];
    
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
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.clipsToBounds = YES;
    
    
    
    //Getting asset image using string from URL array modified by the CreateViewController
    

    
//    FMResultSet * resultSet = [self.db executeQuery:[NSString stringWithFormat:@"select * from fields where id = %d",indexPath.row+1]];
//    NSURL * path;
//    NSString * description ;
//    
//    if(!resultSet)
//        NSLog(@"Error retrieving information from database ");
//    
//    else{
//        
//        if([resultSet next]){
//            
//            path = [NSURL URLWithString:[resultSet stringForColumnIndex:1]];
//            description = [resultSet stringForColumnIndex:2];
//            
//            NSLog(@"Path in %@ ",path);
//            NSLog(@"Description is %@",description);
//
//        }
//    }
    
    Post * post = [self.array objectAtIndex:indexPath.row];
    
    
    [self.library assetForURL:post.url
    
    resultBlock:^(ALAsset * asset){
        cell.imageView.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage scale:1.0f orientation:UIImageOrientationRight];
        //cell.label.text = post.description;
        
    }
    failureBlock:^(NSError * error){
        NSLog(@"An error occurred when loading image ");
    }];
    
    
   
    
    
//    ALAsset * asset_curr = self.assets[indexPath.row];
    
//    cell.imageView.image = [UIImage imageWithCGImage:[asset_curr thumbnail]];
    
    cell.label.text = post.description;
    NSLog(@"Description is %@ ",post.description);
    return cell;

}








-(IBAction)goText:(id)sender{
    [self performSegueWithIdentifier:@"textSegue" sender:self];
}



-(IBAction)goImage:(id)sender{
    [self performSegueWithIdentifier:@"imageSegue" sender:self];
}





-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
    UITableView * parent = (UITableView *)cell.superview.superview;
    NSIndexPath * indexPath =[parent indexPathForCell:cell];
    NSInteger row =[indexPath row];
    NSLog(@"Row = %ld",row);
    switch (index) {
        case 0:
            
            NSLog(@"Deleting....");
            Post * post = [self.array objectAtIndex:row];
            NSString * query  = [NSString stringWithFormat:@"delete from fields where id = %ld",(long)post.id];
            [self.db executeUpdate:query];
            [self.array removeObjectAtIndex:index];
            [self.tableView reloadData ];
            break;
    }
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    
    UITableView * parent = (UITableView *)cell.superview.superview;
    NSIndexPath * indexPath =[parent indexPathForCell:cell];
    NSInteger row =[indexPath row];
    NSLog(@"Row = %ld",row);
    
    
    Post * post = [self.array objectAtIndex:row];
    
    switch (index) {
        case 0:
            
            
            NSLog(@"Logging to facebook");
            [self postToFacebook:self withId:row];
            break;
            
        default:
            break;
    }
}

-(void)postToFacebook:(id)sender withId:(NSInteger)poz{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
       
        
        
        Post * post   = [self.array objectAtIndex:poz];
        [controller setInitialText:post.description];
      
        [controller addImage:post.image];
        [self presentViewController:controller animated:YES completion:NULL];
    }
}





- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    NSLog(@"Offset is %d",self.offset);
    
    [self.revealButtonItem setTarget:self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    self.revealButtonItem.image = [UIImage imageNamed:@"reveal-icon.png"];
    self.revealButtonItem.title = @"";

    
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
    
    if([segue.identifier isEqualToString:@"itemSegue"]){
        ItemViewController * controller =segue.destinationViewController ;
        
        controller.text = self.textToSend;
        controller.image = self.imageToSend;
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

