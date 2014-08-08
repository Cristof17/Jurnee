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
    
    /*
    [UIView beginAnimations:@"flipView" context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.image cache:YES];
    
    [UIView commitAnimations];
    */
    
    
    
    
    
    [self performSelector:@selector(animateBackwards) withObject:nil afterDelay:1];
    

    
}

-(void)animateBackwards
{
    [UIView transitionWithView:self.image duration:2 options:UIViewAnimationOptionTransitionFlipFromRight
     
                    animations:^{
                        
                        [UIView animateWithDuration:2 animations:^(void){
                            
                            if(self.displayingImage){
                                NSLog(@"Setting image alpha to 0 cu displaying %d",self.displayingImage);
                                
                                [self.image setAlpha:0];
                                
                            }else{
                                NSLog(@"Setting image alpha to 1 cu displaying %d",self.displayingImage);
                                
                                [self.image setAlpha:1];
                            }
                            
                            
                            
                            
                        }];
                    }
     
     
                    completion: ^(BOOL finished){
                        if(finished){
                            
                            self.displayingImage = !self.displayingImage;
                        }
                    }];
    
    [UIView transitionWithView:self.text duration:2 options:UIViewAnimationOptionTransitionFlipFromRight
     
                    animations:^{
                        
                        
                        
                        [UIView animateWithDuration:2 animations:^(void){
                            if(self.displayingImage){
                                NSLog(@"Setting text alpha to 1 cu displaying %d",self.displayingImage);
                                
                                [self.text setAlpha:1];
                                
                            }else{
                                NSLog(@"Setting text alpha to 0 cu displaying %d",self.displayingImage);
                                
                                [self.text setAlpha:0];
                            }
                        }];
                    }
     
     
                    completion: ^(BOOL finished){
                        if(finished){
                            
                        }
                    }];
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
    
    self.displayingImage = YES;
    [self.text setAlpha:0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
