//
//  ViewController.m
//  PhotoSend
//
//  Created by skunk  on 15/6/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ViewController.h"
#import <ELCImagePickerController.h>
#import <ELCAlbumPickerController.h>
#import <ELCAlbumPickerController.h>

@interface ViewController ()
<UIActionSheetDelegate,
UIAlertViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
ELCImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeftMargin;

@property (weak, nonatomic) IBOutlet UIButton *takePhotos;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImage;
@property (weak, nonatomic) IBOutlet UIImageView *fifthImage;

- (IBAction)takePhotosAction:(id)sender;

@property (nonatomic, retain) ELCImagePickerController *pick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhotosAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"相册"
                                                    otherButtonTitles:@"相机", nil];
    [actionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex) {
            case 2:
            [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
            break;
            
            case 0:
//            NSLog(@"相册");
//            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                message:@"相册不可用"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确认"
//                                                      otherButtonTitles:nil];
//                [alert show];
//            }else{
//                [self pickImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
//            }
            _pick = [[ELCImagePickerController alloc] init];
            _pick.maximumImagesCount = 5;
            //_pick.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
            //_pick.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
            //_pick.onOrder = YES; //For multiple image selection, display and return selected order of images
            _pick.imagePickerDelegate = self;
           
            [self presentViewController:_pick animated:YES completion:nil];

            break;
            case 1:
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"相机不可用"
                                                               delegate:self
                                                      cancelButtonTitle:@"确认"
                                                      otherButtonTitles:nil];
                [alert show];
            }else{
                [self pickImageWithType:UIImagePickerControllerSourceTypeCamera];
            }
            break;
            
        default:
            break;
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
    /**
     *  change the queue of the imageView
     *
     *  @param UIImageView UIImageView description
     *
     *  @return return value description
     */
    UIImageView *view01 = (UIImageView *)[self.view viewWithTag:103];
    
    UIImageView *view02 = (UIImageView *)[self.view viewWithTag:104];
    [self.view insertSubview:view01 belowSubview:view02];
    for (id obj in self.view.subviews) {
        if ([obj isMemberOfClass:[UIImageView class]]) {
            UIImageView *iView = (UIImageView *)obj;
            [arrTemp addObject:iView];
        }
    }
    
    
    
    for (int i = 0 ; i < arrTemp.count; i ++) {
        
        UIImageView *iView = arrTemp[i];
        NSLog(@"iView.tag is %d",iView.tag);
        if (i == 0) {
           
            if (iView.hidden == YES) {
                iView.image = image;
                iView.hidden = NO;
                break;
            }
        }
        else{
            
            if (iView.hidden == YES) {
                iView.image = image;
                iView.hidden = NO;
                self.buttonLeftMargin.constant = (iView.tag - 101) * (iView.frame.size.width) + 30;
                [self.view layoutIfNeeded];
                [self.takePhotos layoutIfNeeded];
                if (i == 4) {
                    [self.takePhotos setHidden:YES];
                }
                break;
            }
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)pickImageWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = type;
    picker.allowsEditing = YES;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    for (NSDictionary *dic in info) {
        NSLog(@"image is %@",dic[@"UIImagePickerControllerOriginalImage"]);
        
        NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
        /**
         *  change the queue of the imageView
         *
         *  @param UIImageView UIImageView description
         *
         *  @return return value description
         */
        UIImageView *view01 = (UIImageView *)[self.view viewWithTag:103];
        
        UIImageView *view02 = (UIImageView *)[self.view viewWithTag:104];
        [self.view insertSubview:view01 belowSubview:view02];
        for (id obj in self.view.subviews) {
            if ([obj isMemberOfClass:[UIImageView class]]) {
                UIImageView *iView = (UIImageView *)obj;
                [arrTemp addObject:iView];
            }
        }
        
        
        
        for (int i = 0 ; i < arrTemp.count; i ++) {
            
            UIImageView *iView = arrTemp[i];
            NSLog(@"iView.tag is %d",iView.tag);
            if (i == 0) {
                
                if (iView.hidden == YES) {
                    iView.image = dic[@"UIImagePickerControllerOriginalImage"];
                    iView.hidden = NO;
                    break;
                }
            }
            else{
                
                if (iView.hidden == YES) {
                    iView.image = dic[@"UIImagePickerControllerOriginalImage"];
                    iView.hidden = NO;
                    self.buttonLeftMargin.constant = (iView.tag - 101) * (iView.frame.size.width) + 30;
                    [self.view layoutIfNeeded];
                    [self.takePhotos layoutIfNeeded];
                    if (i == 4) {
                        [self.takePhotos setHidden:YES];
                    }
                    break;
                }
            }
        }

    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
