/*---------------------------------------------------------------------
   文件名称 : SNRuntimeUtil
   创建作者 : sam
   创建时间 : 16/5/20
   文件描述 :
   ---------------------------------------------------------------------*/
#import "SNRuntimeUtil.h"
#import <objc/runtime.h>

@interface SNRuntimeUtil ()

@end

@implementation SNRuntimeUtil

#pragma mark - 数据加载
#pragma mark - 通知
#pragma mark - 公共方法
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
	Class clzz = cls;
	Method originalMethod = class_getInstanceMethod(clzz, originalSelector);
	Method swizzMethod = class_getInstanceMethod(clzz, swizzledSelector);
	BOOL didAddMethod = class_addMethod(clzz, originalSelector, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
	if (didAddMethod) {
        NSLog(@"replace方法成功");
		class_replaceMethod(clzz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	}
	else {
        NSLog(@"交换方法成功");
		method_exchangeImplementations(originalMethod, swizzMethod);
	}
}
#pragma mark - 重载方法
#pragma mark - KVO
#pragma mark - CallBack回调
#pragma mark - 代理
#pragma mark - 私有方法
#pragma mark - getter / setter
#pragma mark -

@end
