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
    return 3 ;
}



-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * TAG = @"TAG";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TAG];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TAG];
    }
    cell.textLabel.text = @"Test ";
    
    return cell;
}




-(void)tableView:(UITableView * )tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row selected at position %d ",indexPath.row);
    
}







- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableDictionary * rootObj = [NSMutableDictionary dictionaryWithCapacity:3];
    NSDictionary * innerDict;
    NSString * description;
    
    description = @"@Test Line ";
    innerDict =[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Name", nil] forKeys:[NSArray arrayWithObjects:@"Descriere", nil]];
    
    [rootObj setObject:innerDict forKey:@"TIUTLTUTUTU"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
