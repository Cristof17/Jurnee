//
//  CreateViewController.h
//  Jurnee
//
//  Created by ios on 8/7/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsLibrary/AssetsLibrary.h"

@interface CreateViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>


@property IBOutlet UIImageView * image ;
@property IBOutlet UITextView * text ;
@property BOOL displayingImage;
@property (nonatomic, strong ) NSArray * assets ;
@property BOOL cleared;
@property NSMutableArray * array ;
@property BOOL delete_pressed ;

-(IBAction)takePhotoUsingCamera;
-(IBAction)selectPhotoFromLibrary;
-(IBAction)clearFields;
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
@end
