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


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
        
        return YES;
}



-(IBAction)clearFields{
    
    NSLog(@"La intrare delete_pressed = %d ",self.delete_pressed);
    
    if(self.displayingImage){
       self.image.image = [UIImage imageNamed:@"default.png"];
        self.displayingImage = YES;
        
        if(self.array.count >0 && !self.delete_pressed){
            [self.array removeObjectAtIndex:self.array.count -1];
            self.delete_pressed = YES;
        }
        
    }else{
        
        [self animateBackwards];
        self.text.text =@"Description";
        self.image.image  =[UIImage imageNamed:@"default.png"];
        
        if(self.array.count >0 && !self.delete_pressed){
            [self.array removeObjectAtIndex:self.array.count -1];
            self.delete_pressed = YES;
        }
    }
    
    
    NSLog(@"Dupa stergere self.delete_pressed = %d ",self.delete_pressed);
    NSLog(@"Array-ul dupa stergere are %lu",(unsigned long)self.array.count);
}



-(IBAction)selectPhotoFromLibrary{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = NO ;
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
    
    
    UIImage  * image ;
    
    
   //getting image information
    
    if(info == nil){
        NSLog(@"Dictionary is nil ");
    }else{
        
        NSURL * path = [info valueForKey:UIImagePickerControllerReferenceURL];
        
        
        if(path != nil){
            
            [self.array addObject:[path absoluteString]];
            
        }else{
            
             path = [info valueForKey:UIImagePickerControllerMediaURL];
            
            if(path == nil){
                
                
                NSLog(@"Path of the image is nil ");
                
                image = info[UIImagePickerControllerOriginalImage];
                
                
                ALAssetsLibrary * library = [[ALAssetsLibrary alloc]init];
                [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *    assetURL ,NSError * error){
                    if(error){
                        NSLog(@"error");
                        
                    }else{
                        [self.array addObject:[assetURL absoluteString]];
                        NSLog(@"url of captured image %@",assetURL);
                    }
                }];
            }
        }
        NSLog(@"Array-ul are %lu elemente ",(unsigned long)self.array.count);
    }
    
    
    NSLog(@" URL is  %@ ",[info valueForKey:UIImagePickerControllerReferenceURL]);
    
    
    
    if(! self.displayingImage){
        [self animateBackwards];
    }
    
    
    
    if(image == nil){
        
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        if(image == nil){
            NSLog(@"Image is nil ");
        }
    }
    
    self.image.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    if(self.displayingImage){
        
        [self performSelector:@selector(animateBackwards) withObject:nil afterDelay:1];
    }
    
    

     self.delete_pressed = NO;
}

-(void)animateBackwards
{
    [UIView transitionWithView:self.image duration:2 options:UIViewAnimationOptionTransitionFlipFromRight
     
                    animations:^{
                        
                        [UIView animateWithDuration:2 animations:^(void){
                            
                            if(self.displayingImage){
                                
                                [self.image setAlpha:0];
                                
                            }else{
                                
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
                                
                                [self.text setAlpha:1];
                                
                            }else{
                                
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
    self.delete_pressed = NO;
    [self.text setAlpha:0];
    
    
    if(self.assets == nil){
        NSLog(@"Assets array is nil ");
    }
    
    
    if(self.array == nil){
        NSLog(@"Array is nil in CreateViewController ");
    }
        
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
