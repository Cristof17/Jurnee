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


-(BOOL)textFieldShouldReturn:(UITextField * )textField{
    [textField resignFirstResponder];
    return YES;
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
    self.newMedia = YES;
   
    
    UIImage * image = info[UIImagePickerControllerEditedImage];
    
    
    
    
    
    if(image == nil){
        
        image = info[UIImagePickerControllerOriginalImage];
        
        if(image == nil){
            NSLog(@"Image is nil ");
        }
    }
    
    ALAssetsLibrary * library = [[ALAssetsLibrary alloc]init];
    [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL * assetURL ,NSError * error){
        if(error){
            NSLog(@"error");
            
        }else{
            NSLog(@"url %@",assetURL);
        }
    }];
    
    self.image.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    if(self.newMedia){
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    }
    
}


-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void * )contextInfo{
    if(error){
        UIAlertView * alert =[ [UIAlertView alloc]initWithTitle:@"Save failed" message:@"Failed to save image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.text setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
