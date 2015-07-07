//
//  ImageHelper.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ImageHelper.h"

@implementation ImageHelper

+(void)setImage:(UIImageView *)imageView FromPath:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
}

@end
