//
//  UIScrollView+FSPageState.h
//  FilmSiteClient
//
//  Created by 许彦辉 on 2018/8/9.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

typedef NS_ENUM(NSInteger, FSPageState) {
    FSPageStateNormal,
    FSPageStateLoading,
    FSPageStateEmptyData,
    FSPageStateCustomEmptyData,//自定义空的view
    FSPageStateBadNetwork,
};

@interface UIScrollView (FSPageState)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, assign) FSPageState  pageState;

@property (nonatomic, copy) NSString   *emptyPageTitle;

@property (nonatomic, copy) NSString   *emptyPageDescription;

@property (nonatomic, copy) NSString  *emptyPageImage;

@property (nonatomic, copy) NSString  *emptyPageBtnTitle;

@property (nonatomic, assign) CGFloat  emptyPageOffsetY;

@property (nonatomic, strong) UIFont  *emptyPageTitleFont;

@property (nonatomic, strong) UIColor  *emptyPageTitleColor;

@property (nonatomic, assign) BOOL  showEmptyPageImage;

@property (nonatomic, copy) void (^emptyPageTapAction)();

@property (nonatomic, copy) void (^emptyPageButtonAction)();

- (void)configEmptyDataSet;

- (void)configEmptyDataSetWithTapAction:(void (^)())emptyPageTapAction;

- (void)configEmptyDataSetWithButtonAction:(void (^)())emptyPageButtonAction;

@end
