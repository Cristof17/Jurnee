//
//  CreateViewController.h
//  Jurnee
//
//  Created by ios on 8/7/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong,nonatomic) IBOutlet UIImageView * image ;
@property IBOutlet UITextView * text ;

-(IBAction)takePhotoUsingCamera;
-(IBAction)selectPhotoFromLibrary;


@end
