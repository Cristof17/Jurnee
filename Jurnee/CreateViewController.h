//
//  CreateViewController.h
//  Jurnee
//
//  Created by ios on 8/7/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsLibrary/AssetsLibrary.h"
#import "FMDatabase.h"

@interface CreateViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>


@property IBOutlet UIImageView * image ;
@property IBOutlet UITextView * text ;
@property BOOL displayingImage;
@property (nonatomic, strong ) NSArray * assets ;
@property BOOL cleared;
@property NSMutableArray * array ;
@property BOOL delete_pressed ;
@property FMDatabase * db;
@property NSURL * path ;
@property NSString * description;

-(IBAction)takePhotoUsingCamera;
-(IBAction)selectPhotoFromLibrary;
-(IBAction)goBack:(id)sender;

-(IBAction)clearFields;
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
-(NSInteger)getWeek;
-(void)insertInDatabase:(NSString *)path description:(NSString *)description week:(NSInteger)week ;

@end
