/*---------------------------------------------------------------------
   文件名称 : SNRuntimeUtil
   创建作者 : sam
   创建时间 : 16/5/20
   文件描述 : runtime一些常规方法
   ---------------------------------------------------------------------*/
#import <Foundation/Foundation.h>

@interface SNRuntimeUtil : NSObject
#pragma mark - 普通属性

#pragma mark - 数据模型属性

#pragma mark - 视图属性

#pragma mark - 方法
/**
 *  替换方法
 *
 *  @param cls              需要替换的类
 *  @param originalSelector 原方法
 *  @param swizzledSelector 新方法
 */
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
