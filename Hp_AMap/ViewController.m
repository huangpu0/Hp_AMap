//
//  ViewController.m
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/17.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import "ViewController.h"
#import "AMap_SearchViewCtroller.h"
#import "AMap_AMapViewCtroller.h"

@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

/// 位置信息管理\搜索定义、关键字输入框
@property (strong, nonatomic) AMapLocationManager *locManager;
@property (strong, nonatomic) MAMapView     *mapView;
@property (strong, nonatomic) AMapSearchAPI *searchAPI;
@property (assign, nonatomic) double   lat;
@property (assign, nonatomic) double   lng;

@end

@implementation ViewController

- (AMapLocationManager *)locManager{
    if (!_locManager) {
        _locManager = [[AMapLocationManager alloc] init];
    }
    return _locManager ;
}

- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:self.view.frame];
        _mapView.delegate = self;
        _mapView.showsUserLocation = NO;
        _mapView.showsCompass = NO;
        _mapView.showsScale   = NO;
        _mapView.distanceFilter  = 1000.0f;
        //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            _mapView.allowsBackgroundLocationUpdates = YES;
        }
        _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _mapView.pausesLocationUpdatesAutomatically = NO;
        _mapView.zoomLevel = 16.0f;
    }
    return _mapView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initLocationManager];
    [self.view addSubview:self.mapView];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(searchView:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

/// 初始化定位
- (void)initLocationManager{
    
    
    self.locManager.distanceFilter  = 1000.0f;
    self.locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locManager.locationTimeout  = 2.0f;
    self.locManager.reGeocodeTimeout = 5.0f;
    self.locManager.locatingWithReGeocode = YES;
    self.locManager.delegate = self;
    [self.locManager startUpdatingLocation];

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
        self.lat = location.coordinate.latitude;
        self.lng = location.coordinate.longitude;
        
        DriversPointAnnotation *driversPoint = [[DriversPointAnnotation alloc]init];
        driversPoint.coordinate = CLLocationCoordinate2DMake(self.lat, self.lng);
        [self.mapView addAnnotation:driversPoint];
        
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.lat, self.lng) animated:YES];
    }
    
}
#pragma mark - 定位失败回调
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error;{
    NSLog(@"定位失败");
}

- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager{
    [locationManager requestAlwaysAuthorization];
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
        driversView.canShowCallout = NO;       //设置气泡可以弹出，默认为NO
        driversView.imageView.width  = 18.0f;
        driversView.imageView.height = 18.0f;
        [driversView.imageView yy_setImageWithURL:[NSURL URLWithString:Driver_URL] options:1];
        return driversView;
    }else if ([annotation isKindOfClass:[FromPointAnnotation class]]){
        
        static NSString *fromReuseIndentifier = @"fromReuseIndentifier";
        FromAnnotationView *fromView = (FromAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:fromReuseIndentifier];
        if (fromView == nil)
        {
            fromView = [[FromAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:fromReuseIndentifier];
        }
        fromView.canShowCallout= NO;
        return fromView;
    }else if ([annotation isKindOfClass:[ToPointAnnotation class]]){
        
        static NSString *toReuseIndentifier = @"toReuseIndentifier";
        ToAnnotationView *toView = (ToAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:toReuseIndentifier];
        if (toView == nil)
        {
            toView = [[ToAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:toReuseIndentifier];
        }
        toView.canShowCallout= NO;
        return toView;
    }
    
    return nil;
}

- (void)searchView:(UIButton *)btn{
    AMap_SearchViewCtroller *searchVC = [[AMap_SearchViewCtroller alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
