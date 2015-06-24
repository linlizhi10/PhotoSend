//
//  PhotoGet.h
//  PhotoSend
//
//  Created by skunk  on 15/6/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoGet : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

+ (NSArray *)getPhotoFromPhotoAlbum;

- (void)takePhoto;

@end
