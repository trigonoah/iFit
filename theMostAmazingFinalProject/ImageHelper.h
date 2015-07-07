//
//  ImageHelper.h
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageHelper : NSObject

+(void)setImage:(UIImageView *)imageView FromPath:(NSString *)url;

@end
