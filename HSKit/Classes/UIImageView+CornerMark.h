//
//  UIImageView+CornerMark.h
//  FilmSiteClient
//
//  Created by SY on 15/12/25.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CornerMark)

/**
 *  根据bmoth和type来判断电影类型(收费,会员,预告)
 *  根据leftFreewTime和freeTime来判断是预售或限免
 *  根据isTrailerVideo来判断这个预告是否包含视频
 */
- (void)setCornerMarkImageWithType:(NSString *)type
                             bmoth:(NSString *)bmoth
                          freetime:(NSString *)freeTime
                      leftFreeTime:(NSString *)leftFreeTime
                    isTrailerVideo:(NSString *)isTrailerVideo;

@end
