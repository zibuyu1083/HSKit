//
//  FLAnimatedImageView+FSGif.m
//  FilmSiteClient
//
//  Created by 许彦辉 on 2018/9/5.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import "FLAnimatedImageView+FSGif.h"

@implementation FLAnimatedImageView (FSGif)


#pragma mark - gif


-(void)gifImgViewWithUrl:(NSString *)gifUrl{
    
    __weak typeof(self)WeakSelf = self;
    NSData * gifImageData  = [WeakSelf imageDataFromDiskCacheWithKey:gifUrl];
    if (gifImageData) {
        [WeakSelf animatedImageView:WeakSelf data:gifImageData];
    } else {
        NSURL *url = [NSURL URLWithString:gifUrl];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            
            [[[SDWebImageManager sharedManager] imageCache] storeImage:image recalculateFromImage:NO imageData:data forKey:url.absoluteString toDisk:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [WeakSelf animatedImageView:WeakSelf data:data];
            });
        }];
    }
}


- (void)animatedImageView:(FLAnimatedImageView *)imageView data:(NSData *)data {
    
    FLAnimatedImage *gifImage = [FLAnimatedImage animatedImageWithGIFData:data];
   // imageView.frame  = CGRectMake(0, 0, gifImage.size.width, gifImage.size.height);
    imageView.animatedImage  = gifImage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.alpha  = 0.f;
    
    [UIView animateWithDuration:1.f animations:^{
        imageView.alpha = 1.f;
    }];
}

- (NSData *)imageDataFromDiskCacheWithKey:(NSString *)key {
    
    NSString *path = [[[SDWebImageManager sharedManager] imageCache] defaultCachePathForKey:key];
    return [NSData dataWithContentsOfFile:path];
}

@end
