//
//  AMapBaseView.h
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/21.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapBaseView : MAMapView

/// 创建
+ (AMapBaseView *)shareAMapView;

/// 销毁
+ (void)attempDealloc;

@end

NS_ASSUME_NONNULL_END
