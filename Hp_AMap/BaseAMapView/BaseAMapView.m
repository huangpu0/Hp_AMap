//
//  BaseAMapView.m
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/22.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import "BaseAMapView.h"

@interface BaseAMapView ()

@end

@implementation BaseAMapView

- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:self.view.frame];
        _mapView.delegate     = self;
        _mapView.zoomLevel    = 16.0f;
        _mapView.showsScale   = NO;
        _mapView.showsCompass = NO;
        _mapView.showsUserLocation = NO;
        //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
            _mapView.allowsBackgroundLocationUpdates = YES;
        }
        _mapView.distanceFilter  = kCLLocationAccuracyHundredMeters;
        _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _mapView.pausesLocationUpdatesAutomatically = NO;
    }
    return _mapView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    
    /// 默认添加一个发货地址
    [self addFromLocationInfo:CLLocationCoordinate2DMake(31.294260, 121.115354)];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[DriversPointAnnotation class]])
    {
        static NSString *driversReuseIndentifier = @"driversReuseIndentifier";
        MAPinAnnotationView *driversView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:driversReuseIndentifier];
        if (driversView == nil)
        {
            driversView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:driversReuseIndentifier];
        }
        driversView.canShowCallout = NO;
        driversView.imageView.width  = 18.0f;
        driversView.imageView.height = 18.0f;
        [driversView.imageView yy_setImageWithURL:[NSURL URLWithString:Driver_URL] options:1];
        return driversView;
    }else if ([annotation isKindOfClass:[FromPointAnnotation class]]){
        
        static NSString *fromReuseIndentifier = @"fromReuseIndentifier";
        _fromView = (FromAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:fromReuseIndentifier];
        if (_fromView == nil)
        {
            _fromView = [[FromAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:fromReuseIndentifier];
        }
        _fromView.canShowCallout= NO;
        _fromView.image = [UIImage imageNamed:@"发"];
        _fromView.calloutView.title = @"附近有2位骑手";
        return _fromView;
    }else if ([annotation isKindOfClass:[ToPointAnnotation class]]){
        
        static NSString *toReuseIndentifier = @"toReuseIndentifier";
        _toView = (ToAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:toReuseIndentifier];
        if (_toView == nil)
        {
            _toView = [[ToAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:toReuseIndentifier];
        }
        _toView.canShowCallout= NO;
        _toView.image = [UIImage imageNamed:@"收"];
        _toView.calloutView.title = @"附近3位骑手";
        return _toView;
    }
    
    return nil;
}

/**
 * 重置发货
 *
 @param fromLoc 发货位置
 */
- (void)resetFromLocationInfo:(CLLocationCoordinate2D)fromLoc;{
    
    _fromPoint.coordinate = fromLoc;
    [self.mapView setCenterCoordinate:fromLoc animated:YES];
}

/**
 * 设置收货地址对应时间
 *
 @param toLoc 收货位置
 @param time  预计到达时间
 */
- (void)addToLocationTime:(CLLocationCoordinate2D)toLoc toTime:(NSString *)time;{
    
    [self.mapView removeAnnotation:_toPoint];
    _toPoint = [[ToPointAnnotation alloc]init];
    _toPoint.coordinate = toLoc;
    [self.mapView addAnnotation:_toPoint];
    _toView.calloutView.title = time;
}

/**
 * 加载收货地址
 @param title 收货标题
 */
- (void)addToLocationTitle:(NSString *)title;{
    
    _toView.calloutView.title = title;
}

/**
 * 加载收货地址
 @param time 更新到达时间
 */
- (void)updateToLocationTitle:(NSString *)time;{
    
    _toView.calloutView.title = time;
}

/**
 * 加载发货地址
 @param fromLoc 发货位置
 */
- (void)addFromLocationInfo:(CLLocationCoordinate2D)fromLoc;{

    [self.mapView removeAnnotation:_fromPoint];
    _fromPoint = [[FromPointAnnotation alloc]init];
    _fromPoint.coordinate = fromLoc;
    [self.mapView addAnnotation:_fromPoint];
    [self.mapView setCenterCoordinate:fromLoc animated:YES];
    [self.mapView showAnnotations:self.mapView.annotations edgePadding:UIEdgeInsetsMake(200, 120, 200, 120) animated:YES];
}

- (void)dealloc{
    NSLog(@"base地图销毁");
}


@end
