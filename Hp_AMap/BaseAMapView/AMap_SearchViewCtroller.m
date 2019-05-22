//
//  AMap_SearchViewCtroller.m
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/20.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import "AMap_SearchViewCtroller.h"

@interface AMap_SearchViewCtroller ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

/// 位置信息管理\搜索定义、关键字输入框
@property (strong, nonatomic) AMapLocationManager *locationManager;
@property (strong, nonatomic) MAMapView     *mapView;
@property (strong, nonatomic) AMapSearchAPI *search;
@property (assign, nonatomic) double   lat;
@property (assign, nonatomic) double   lng;

@end

@implementation AMap_SearchViewCtroller

- (AMapLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
    }
    return _locationManager ;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [AMapBaseView attempDealloc];
}

- (MAMapView *)mapView{
    
    if (!_mapView) {
        _mapView = [AMapBaseView shareAMapView];
    }
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLocationManager];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
}

/// 初始化定位
- (void)initLocationManager{
    
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 1000.0f;
    self.locationManager.locatingWithReGeocode = YES;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - 定位代理
/// 定位状态改变回调及位置信息的返回
- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    /// 用户拒绝App使用定位权限
    if(status != kCLAuthorizationStatusAuthorizedAlways && status != kCLAuthorizationStatusAuthorizedWhenInUse){
        
        
    }
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode;{
    
    if (reGeocode) {
        
        NSLog(@"定位成功: %@ --lat-%f--lng -- %f",reGeocode,location.coordinate.latitude,location.coordinate.longitude);
        [self.locationManager stopUpdatingLocation];

        self.lat = location.coordinate.latitude;
        self.lng = location.coordinate.longitude;
        
    }
    
}
#pragma mark - 定位失败回调
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error;{
    NSLog(@"定位失败");
}
- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager{
    
}

- (void)dealloc{
    NSLog(@"页面销毁");
}

@end
