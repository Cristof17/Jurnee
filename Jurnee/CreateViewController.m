//
//  CreateViewController.m
//  Jurnee
//
//  Created by ios on 8/7/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()

@end

@implementation CreateViewController




-(IBAction)takePhotoUsingCamera{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = NO ;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


-(IBAction)selectPhotoFromLibrary{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES ;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSLog(@"didFinishPickingMediaWithInfo");
    
   

  /*
    UIImage * originalImage = nil;
    
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if(originalImage == nil){
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if(originalImage == nil){
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    
    
    
    
    if(originalImage == nil){
        NSLog(@"Image is nil");
    }
    */
    
    UIImage * image = info[UIImagePickerControllerEditedImage];
    
    if(image == nil){
        
        image = info[UIImagePickerControllerOriginalImage];
        
        if(image == nil){
            NSLog(@"Image is nil ");
        }
    }
    self.image.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
