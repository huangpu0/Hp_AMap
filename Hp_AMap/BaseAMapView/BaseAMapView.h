//
//  BaseAMapView.h
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/22.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAMapView : UIViewController<MAMapViewDelegate>

/// 地图
@property (strong, nonatomic) MAMapView  *mapView;

/**
 * 标注 发、收
 */
@property (strong, nonatomic) FromPointAnnotation *fromPoint;
@property (strong, nonatomic) FromAnnotationView  *fromView;
@property (strong, nonatomic) ToPointAnnotation   *toPoint;
@property (strong, nonatomic) ToAnnotationView    *toView;


/**
 * 重置发货
 *
 @param fromLoc 发货位置
 */
- (void)resetFromLocationInfo:(CLLocationCoordinate2D)fromLoc;

/**
 * 设置收货地址对应时间
 *
 @param toLoc 收货位置
 @param time  预计到达时间
 */
- (void)addToLocationTime:(CLLocationCoordinate2D)toLoc toTime:(NSString *)time;

/**
 * 加载收货地址
 @param title 收货标题
 */
- (void)addToLocationTitle:(NSString *)title;

/**
 * 加载收货地址
 @param time 收更新到达时间
 */
- (void)updateToLocationTitle:(NSString *)time;

/**
 * 加载发货地址
 @param fromLoc 发货位置
 */
- (void)addFromLocationInfo:(CLLocationCoordinate2D)fromLoc;

@end

NS_ASSUME_NONNULL_END
