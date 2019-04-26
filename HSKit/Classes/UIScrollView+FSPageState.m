//
//  UIScrollView+FSPageState.m
//  FilmSiteClient
//
//  Created by 许彦辉 on 2018/8/9.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import "UIScrollView+FSPageState.h"
#import "M1905ActivityIndicatorView.h"
#import <objc/runtime.h>

static const char* kPageState               = "PageState";
static const char* kEmptyPageImage          = "EmptyPageImage";
static const char* kEmptyPageOffsetY        = "EmptyPageOffsetY";
static const char* kEmptyPageTitle          = "EmptyPageTitle";
static const char* kEmptyPageBtnTitle       = "EmptyPageBtnTitle";
static const char* kEmptyPageDescription    = "EmptyPageDescription";
static const char* kShowEmptyPageImage      = "ShowEmptyPageImage";
static const char* kEmptyPageTapAction      = "EmptyPageTapAction";
static const char* kEmptyPageButtonAction   = "EmptyPageButtonAction";
static const char* kEmptyPageTitleFont      = "EmptyPageTitleFont";
static const char* kEmptyPageTitleColor     = "EmptyPageTitleColor";

@implementation UIScrollView (FSPageState)

//pageState
- (void)setPageState:(FSPageState)pageState{
    objc_setAssociatedObject(self, kPageState, @(pageState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (FSPageState)pageState{
    NSNumber *value =  objc_getAssociatedObject(self, kPageState);
    return (FSPageState)value.integerValue;
}

//emptyPageImage
- (void)setEmptyPageImage:(NSString *)emptyPageImage{
    objc_setAssociatedObject(self, kEmptyPageImage, emptyPageImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (NSString *)emptyPageImage{
    NSString *path =  objc_getAssociatedObject(self, kEmptyPageImage);
    return path;
}

//EmptyPageDescription
-(void)setEmptyPageDescription:(NSString *)emptyPageDescription{
    objc_setAssociatedObject(self, kEmptyPageDescription, emptyPageDescription, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self reloadEmptyDataSet];
}
-(NSString *)emptyPageDescription{
    NSString *path =  objc_getAssociatedObject(self, kEmptyPageDescription);
    return path;
}

//emptyPageOffsetY
- (void)setEmptyPageOffsetY:(CGFloat)emptyPageOffsetY{
    objc_setAssociatedObject(self, kEmptyPageOffsetY, @(emptyPageOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (CGFloat)emptyPageOffsetY{
    NSNumber *value =  objc_getAssociatedObject(self, kEmptyPageOffsetY);
    return  value.floatValue;
}

//emptyPageTitle
- (void)setEmptyPageTitle:(NSString *)emptyPageTitle{
    objc_setAssociatedObject(self, kEmptyPageTitle, emptyPageTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self reloadEmptyDataSet];
}
- (NSString *)emptyPageTitle{
    NSString *path =  objc_getAssociatedObject(self, kEmptyPageTitle);
    return path;
}

//EmptyPageBtnTitle
-(void)setEmptyPageBtnTitle:(NSString *)emptyPageBtnTitle{
    objc_setAssociatedObject(self, kEmptyPageBtnTitle, emptyPageBtnTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self reloadEmptyDataSet];
}
-(NSString *)emptyPageBtnTitle{
    NSString *path =  objc_getAssociatedObject(self, kEmptyPageBtnTitle);
    return path;
}

//showEmptyPageImage
- (void)setShowEmptyPageImage:(BOOL)showEmptyPageImage{
    objc_setAssociatedObject(self, kShowEmptyPageImage, @(showEmptyPageImage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (BOOL)showEmptyPageImage{
    NSNumber *value =  objc_getAssociatedObject(self, kShowEmptyPageImage);
    return  value.boolValue;
}

//emptyPageTapAction
- (void)setEmptyPageTapAction:(void (^)())emptyPageTapAction{
    objc_setAssociatedObject(self,kEmptyPageTapAction , emptyPageTapAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())emptyPageTapAction{
    void (^block)() = objc_getAssociatedObject(self, kEmptyPageTapAction);
    
    return block;
}

//emptyPageButtonAction
-(void)setEmptyPageButtonAction:(void (^)())emptyPageButtonAction{
     objc_setAssociatedObject(self,kEmptyPageButtonAction , emptyPageButtonAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)())emptyPageButtonAction{
    void (^block)() = objc_getAssociatedObject(self, kEmptyPageButtonAction);
    return block;
}

//emptyPageTitleFont
- (void)setEmptyPageTitleFont:(UIFont *)emptyPageTitleFont{
    objc_setAssociatedObject(self, kEmptyPageTitleFont, emptyPageTitleFont, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (UIFont *)emptyPageTitleFont{
    UIFont *font =  objc_getAssociatedObject(self, kEmptyPageTitleFont);
    return font;
}

//emptyPageTitleColor
- (void)setEmptyPageTitleColor:(UIColor *)emptyPageTitleColor{
    objc_setAssociatedObject(self, kEmptyPageTitleColor, emptyPageTitleColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (UIColor *)emptyPageTitleColor{
    UIColor *color =  objc_getAssociatedObject(self, kEmptyPageTitleColor);
    return color;
}

#pragma mark - emptydata

- (void)configEmptyDataSet{
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}

- (void)configEmptyDataSetWithTapAction:(void (^)())emptyPageTapAction{
    [self configEmptyDataSet];
    self.emptyPageTapAction = emptyPageTapAction;
}

-(void)configEmptyDataSetWithButtonAction:(void (^)())emptyPageButtonAction{
    [self configEmptyDataSet];
    self.emptyPageButtonAction = emptyPageButtonAction;
}


//图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    switch (self.pageState) {
        case FSPageStateNormal:
            return nil;
        case FSPageStateLoading:
            return [UIImage imageNamed:@"page_loading"];
        case FSPageStateEmptyData:
            if (!self.showEmptyPageImage) {
                return nil;
            }
            if (self.emptyPageImage.length>0) {
                return [UIImage imageNamed:self.emptyPageImage];
            }else {
                return [UIImage imageNamed:@"ic_default"];
            }
        case FSPageStateCustomEmptyData:
            return nil;
            break;
        case FSPageStateBadNetwork:
            return [UIImage imageNamed:@"ic_nowifi"];
    }
    
    return nil;
}

//动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.pageState == FSPageStateLoading) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
        animation.duration = 0.25;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        return animation;
    }
    
    return nil;
}
//文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString * text = nil;
    switch (self.pageState) {
        case FSPageStateNormal:
            return nil;
        case FSPageStateLoading:
            return nil;
        case FSPageStateEmptyData:
            if (self.emptyPageTitle && [self.emptyPageTitle isKindOfClass:NSString.class]) {
                text = self.emptyPageTitle;
            }else {
                text = @"暂无数据";
            }
            break;
        case FSPageStateCustomEmptyData:
            text = @"";
            break;
        case FSPageStateBadNetwork:
            text = @"无法连接网络，请检查后刷新";
            break;
    }
    
    if (text == nil) {
        return nil;
    }
    
    UIFont *font = [self emptyPageTitleFont];
    UIColor *color = [self emptyPageTitleColor];
    
    NSDictionary *attributes = @{NSFontAttributeName:font ?:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:color ?:UIColorFromRGB(0x666666)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//描述
-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString * text = nil;
    switch (self.pageState) {
        case FSPageStateNormal:
            return nil;
        case FSPageStateLoading:
            return nil;
        case FSPageStateEmptyData:
            if (self.emptyPageDescription && [self.emptyPageDescription isKindOfClass:NSString.class]) {
                text = self.emptyPageDescription;
            }else {
                text = @"";
            }
            break;
        case FSPageStateCustomEmptyData:
            text = @"";
            break;
        case FSPageStateBadNetwork:
            text = @"";
            break;
    }
    
    if (text == nil) {
        return nil;
    }
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//按钮
-(NSAttributedString *) buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString * text = nil;
    switch (self.pageState) {
        case FSPageStateNormal:
            return nil;
        case FSPageStateLoading:
            return nil;
        case FSPageStateEmptyData:
            if (self.emptyPageBtnTitle && [self.emptyPageBtnTitle isKindOfClass:NSString.class]) {
                text = self.emptyPageBtnTitle;
            }else {
                text = @"";
            }
            break;
        case FSPageStateCustomEmptyData:
            text = @"";
            break;
        case FSPageStateBadNetwork:
            text = @"刷新";
            break;
    }
    
   
    if (text == nil) {
        return nil;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (self.emptyPageButtonAction) {
        self.emptyPageButtonAction();
    }
}

-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 20.0f;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    if (self.pageState == FSPageStateLoading) {
        return YES;
    }
    
    return NO;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    if (self.pageState == FSPageStateNormal) {
        return NO;
    }
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyPageOffsetY;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if (self.pageState == FSPageStateCustomEmptyData) {
        return;
    }
    if (self.emptyPageTapAction) {
        self.emptyPageTapAction();
    }
}

#pragma mark -customView

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"";
    switch (self.pageState) {
        case FSPageStateNormal:
            return nil;
        case FSPageStateLoading:
            return [self customLoadingView];
        case FSPageStateEmptyData:
            return nil;
        case FSPageStateCustomEmptyData:
            return [self customView];
            break;
        case FSPageStateBadNetwork:
            return [self customBadBadNetwork];
            break;
    }
    
    return nil;
}

#pragma mark -自定义空的view

- (UIView *)customLoadingView{
    UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:M1905_SCREEN_HEIGHT-M1905_NAVIGATION_BAR_HEIGHT];
    [contentView addConstraint:heightConstraint];

    M1905ActivityIndicatorView *activityView = [M1905ActivityIndicatorView showHUDAddTo:contentView size:CGSizeMake(37, 37)];
    
    return contentView;
}

-(UIView *)customView{
    UIView *contentBackGroudView = [[UIView alloc]initWithFrame:self.bounds];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:contentBackGroudView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:M1905_SCREEN_HEIGHT-M1905_NAVIGATION_BAR_HEIGHT];
    [contentBackGroudView addConstraint:heightConstraint];
    
    NSString *emptyImgName = ((!self.emptyPageImage||self.emptyPageImage.length == 0) ? @"ic_default" : self.emptyPageImage);
    UIImageView *emptyImgView = [[UIImageView alloc]initWithImage:M1905_ImageNamed(emptyImgName)];
    [contentBackGroudView addSubview:emptyImgView];
    [emptyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentBackGroudView);
        make.bottom.mas_equalTo(contentBackGroudView.mas_bottom).offset(-contentBackGroudView.mj_h*0.7);
        make.size.mas_equalTo(CGFloatAutoFit(70),CGFloatAutoFit(70));
    }];
    
    UILabel *emptyLabel = [[UILabel alloc]init];
    [contentBackGroudView addSubview:emptyLabel];
    [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyImgView.mas_bottom).offset(24);
        make.centerX.mas_equalTo(emptyImgView);
    }];
    emptyLabel.font = [UIFont systemFontOfSize:16];
    emptyLabel.textColor = M1905_UIColorFromRGB(0x666666);
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.text = (self.emptyPageTitle.length>0 ? self.emptyPageTitle :@"暂无数据");
    
    
    UILabel *emptyDesLabel = [[UILabel alloc]init];
    [contentBackGroudView addSubview:emptyDesLabel];
    [emptyDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyLabel.mas_bottom).offset(10.0f);
        make.centerX.mas_equalTo(emptyLabel);
    }];
    emptyDesLabel.font = [UIFont systemFontOfSize:16];
    emptyDesLabel.textColor = M1905_UIColorFromRGB(0x666666);
    emptyDesLabel.textAlignment = NSTextAlignmentCenter;
    if (self.emptyPageDescription.length>0) {
        emptyDesLabel.text = self.emptyPageDescription;
    }else{
        emptyDesLabel.mj_h = 0.0f;
    }
    
    UIButton *emptyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentBackGroudView addSubview:emptyBtn];
    [emptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyDesLabel.mas_bottom).offset(40.0f);
        make.centerX.mas_equalTo(contentBackGroudView);
        make.size.mas_equalTo(CGSizeMake(116, 34));
    }];
    emptyBtn.backgroundColor = M1905_UIColorFromRGB(0x4f9df9);
    emptyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [emptyBtn setTitleColor:M1905_UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [emptyBtn addTarget:self action:@selector(emptyDataSet:didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    emptyBtn.layer.cornerRadius = 17.0f;
    emptyBtn.clipsToBounds = YES;
    if (self.emptyPageBtnTitle.length>0) {
        [emptyBtn setTitle:self.emptyPageBtnTitle forState:UIControlStateNormal];
    }else{
        [emptyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(116, 0.0f));
        }];
    }
    return contentBackGroudView;
}

-(UIView *)customBadBadNetwork{
    [self layoutIfNeeded];
    
    UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
    
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:M1905_SCREEN_HEIGHT-M1905_NAVIGATION_BAR_HEIGHT];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.height];
    [contentView addConstraint:heightConstraint];
    
    NSString *iconName = ((!self.emptyPageImage||self.emptyPageImage.length == 0) ? @"ic_nowifi" : self.emptyPageImage);
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:M1905_ImageNamed(iconName)];
    [contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentView);
        make.top.mas_equalTo(contentView.mas_bottom).offset(-contentView.mj_h*0.75);
        make.size.mas_equalTo(CGFloatAutoFit(70),CGFloatAutoFit(70));
    }];
    
    UILabel *emptyLabel = [[UILabel alloc]init];
    [contentView addSubview:emptyLabel];
    [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(24);
        make.centerX.mas_equalTo(iconImageView);
    }];
    emptyLabel.font = [UIFont systemFontOfSize:15];
    emptyLabel.textColor = M1905_UIColorFromRGB(0x666666);
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.text = (self.emptyPageTitle.length>0 ? self.emptyPageTitle :@"无法连接网络，请检查后重试");
    
    
    UILabel *emptyDesLabel = [[UILabel alloc]init];
    [contentView addSubview:emptyDesLabel];
    [emptyDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyLabel.mas_bottom).offset(10.0f);
        make.centerX.mas_equalTo(emptyLabel);
    }];
    emptyDesLabel.font = [UIFont systemFontOfSize:16];
    emptyDesLabel.textColor = M1905_UIColorFromRGB(0x666666);
    emptyDesLabel.textAlignment = NSTextAlignmentCenter;
    if (self.emptyPageDescription.length>0) {
        emptyDesLabel.text = self.emptyPageDescription;
    }else{
        emptyDesLabel.mj_h = 0.0f;
    }
    
    UIButton *emptyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:emptyBtn];
    [emptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyLabel.mas_bottom).offset(36.0f);
        make.centerX.mas_equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(116, 34));
    }];
    emptyBtn.backgroundColor = M1905_UIColorFromRGB(0x4f9df9);
    emptyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [emptyBtn setTitleColor:M1905_UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [emptyBtn addTarget:self action:@selector(emptyDataSet:didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    emptyBtn.layer.cornerRadius = 17.0f;
    emptyBtn.clipsToBounds = YES;
    
    if (self.emptyPageBtnTitle.length>0) {
        [emptyBtn setTitle:self.emptyPageBtnTitle forState:UIControlStateNormal];
    }else{
        [emptyBtn setTitle:@"刷新" forState:UIControlStateNormal];
    }
    return contentView;
}

@end
