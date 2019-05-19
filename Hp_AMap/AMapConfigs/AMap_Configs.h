//
//  AMap_Configs.h
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/17.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#ifndef AMap_Configs_h
#define AMap_Configs_h


#pragma mark - iPhone设备相关

#define IPHONE_5  (([UIScreen mainScreen].bounds.size.width == 320) && ([UIScreen mainScreen].bounds.size.height == 568))

#define IPHONE_6  (([UIScreen mainScreen].bounds.size.width == 375) && ([UIScreen mainScreen].bounds.size.height == 667))

#define IPHONE_6P (([UIScreen mainScreen].bounds.size.width == 414) && ([UIScreen mainScreen].bounds.size.height == 736))
/// iphoneX与XS 一样
#define IPHONE_X  (([UIScreen mainScreen].bounds.size.width == 375) && ([UIScreen mainScreen].bounds.size.height == 812))

#define IPHONE_XSMAX  (([UIScreen mainScreen].bounds.size.width == 375) && ([UIScreen mainScreen].bounds.size.height == 896))

#define IPHONE_XR  (([UIScreen mainScreen].bounds.size.width == 414) && ([UIScreen mainScreen].bounds.size.height == 896))

/**
 * 适配刘海导航栏、状态栏、屏幕宽高等
 */
#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

#define kAdapt (TN_ScreenW)/750.0   // 750根据设计图宽度

#define kStatusH  (IPHONE_X || IPHONE_XSMAX || IPHONE_XR ? 44.0 : 20.0)
#define kNavH     (IPHONE_X || IPHONE_XSMAX || IPHONE_XR ? 88.0 : 64.0)

#define kBootH    (IPHONE_X || IPHONE_XSMAX || IPHONE_XR ? 34.0 : 0.0)
#define kTarbarH  (IPHONE_X || IPHONE_XSMAX || IPHONE_XR ? 83.0 : 49.0)

#define GD_APP_KEY    @"02935469234881d1c446228ae8740bce"


#endif /* AMap_Configs_h */
