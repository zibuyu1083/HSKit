//
//  UIImageView+CornerMark.m
//  FilmSiteClient
//
//  Created by SY on 15/12/25.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "UIImageView+CornerMark.h"
#import "UserTransaction.h"


@implementation UIImageView (CornerMark)

- (void)setCornerMarkImageWithType:(NSString *)type bmoth:(NSString *)bmoth freetime:(NSString *)freeTime leftFreeTime:(NSString *)leftFreeTime isTrailerVideo:(NSString *)isTrailerVideo{
	NSString *type1 = [NSString stringWithFormat:@"%@", type];
	NSString *bmonth1 = [NSString stringWithFormat:@"%@", bmoth];
	NSString *freeTime1 = [NSString stringWithFormat:@"%@", freeTime];
	NSString *leftFreeTime1 = [NSString stringWithFormat:@"%@", leftFreeTime];
    NSString * isTrailerVideo1 = [NSString stringWithFormat:@"%@", isTrailerVideo];
	UIImage *cornerImgae = [UIImage new];
	CGFloat cornerX = 30.f;
	if ([type1 integerValue] == 7) {
		if ([bmonth1 integerValue] == 0 || [bmonth1 integerValue] == 1) {
            if ([[UserTransaction sharedInstance] auditModle]) {
                cornerX = 30.f;
                cornerImgae = [UIImage imageNamed:@"pianku_yugao_icon_normal"];
            }else
            {
                cornerX = 30.f;
                cornerImgae = [UIImage imageNamed:@"pianku_fufei_icon_normal"];
            }
		}
		else if ([bmonth1 integerValue] == 2) {
			cornerImgae = [UIImage imageNamed:@"pianku_mianfei_icon_normal"];
			cornerX = 43.f;
		}
	}
	else if ([type1 integerValue] == 1 && [isTrailerVideo1 integerValue] == 1) {
        cornerX = 30.f;
		cornerImgae = [UIImage imageNamed:@"pianku_yugao_icon_normal"];
    }else if([type1 integerValue] == 1 && [isTrailerVideo1 integerValue] != 1){
        cornerX = 30.f;
        cornerImgae = [UIImage imageNamed:@"ziliao_icon_normal"];
    }else if ([type1 integerValue] == 2) {
        cornerImgae = [UIImage new];
    }
	if ([freeTime1 integerValue] == 1 && leftFreeTime1.length != 0 && ![leftFreeTime1 isEqualToString:@"(null)"]) {
        cornerX = 30.f;
		cornerImgae = [UIImage imageNamed:@"pianku_xianmian_icon_normal"];
        if ([[UserTransaction sharedInstance] auditModle]) {
            cornerImgae = [UIImage imageNamed:@"pianku_yugao_icon_normal"];
        }
	}
	else if ([freeTime1 integerValue] == 2 && leftFreeTime1.length != 0 && ![leftFreeTime1 isEqualToString:@"(null)"]) {
        cornerX = 30.f;
		cornerImgae = [UIImage imageNamed:@"pianku_yushou_icon_normal"];
        if ([[UserTransaction sharedInstance] auditModle]) {
            cornerImgae = [UIImage imageNamed:@"pianku_yugao_icon_normal"];
        }
	}

	//为了避免在tableview上使用的时候,出现重复叠加的问题
//    for(UIView * view in [self subviews])
//    {
//        [view removeFromSuperview];
//    }
	[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

	UIImageView *corerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cornerX, 18)];
	corerImageView.image = cornerImgae;
	corerImageView.contentMode = UIViewContentModeScaleAspectFit;
	[self addSubview:corerImageView];
}

@end
