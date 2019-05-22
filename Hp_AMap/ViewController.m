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

/// 标注 发、收
@property (strong, nonatomic) FromPointAnnotation *fromPoint;
@property (strong, nonatomic) FromAnnotationView  *fromView;
@property (strong, nonatomic) ToPointAnnotation   *toPoint;
@property (strong, nonatomic) ToAnnotationView    *toView;

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
        _mapView.distanceFilter  = kCLLocationAccuracyHundredMeters;
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
    
    UIButton *driverBtn = [[UIButton alloc]init];
    driverBtn.frame = CGRectMake(20, kNavH + 10, 40, 40);
    [driverBtn setTitle:@"司机" forState:UIControlStateNormal];
    [driverBtn addTarget:self action:@selector(driverThouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    driverBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:driverBtn];
    
   
    UIButton *timeBtn = [[UIButton alloc]init];
    timeBtn.frame = CGRectMake(75, kNavH + 10, 40, 40);
    [timeBtn setTitle:@"时间" forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(timeThouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:timeBtn];
    
    UIButton *removeBtn = [[UIButton alloc]init];
    removeBtn.frame = CGRectMake(130, kNavH + 10, 40, 40);
    [removeBtn setTitle:@"移除" forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removeThouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    removeBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:removeBtn];
    
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.frame = CGRectMake(185, kNavH + 10, 40, 40);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchView:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:searchBtn];
    
    UIButton *mapBtn = [[UIButton alloc]init];
    mapBtn.frame = CGRectMake(240, kNavH + 10, 40, 40);
    [mapBtn setTitle:@"地图" forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(mapView:) forControlEvents:UIControlEventTouchUpInside];
    mapBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:mapBtn];
    
}
- (void)driverThouchEvent:(UIButton *)btn{
    
    for (int d = 0; d < 4; d ++) {
        
        DriversPointAnnotation *driverPoint = [[DriversPointAnnotation alloc]init];
        driverPoint.coordinate = CLLocationCoordinate2DMake(31.294244 + d/10, 121.115348 + d/10);
        [self.mapView addAnnotation:driverPoint];
    }
   
}
- (void)timeThouchEvent:(UIButton *)btn{
    
    ToPointAnnotation *toPoint = [[ToPointAnnotation alloc]init];
    toPoint.coordinate = CLLocationCoordinate2DMake(31.994234, 121.115388);
    [self.mapView addAnnotation:toPoint];
    [self.mapView showAnnotations:self.mapView.annotations edgePadding:UIEdgeInsetsMake(200, 100, 200, 100) animated:YES];
}
- (void)removeThouchEvent:(UIButton *)btn{
    [self.mapView removeAnnotations:self.mapView.annotations];
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
        
        FromPointAnnotation *fromPoint = [[FromPointAnnotation alloc]init];
        fromPoint.coordinate = CLLocationCoordinate2DMake(self.lat, self.lng);
        [self.mapView addAnnotation:fromPoint];
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
        fromView.image = [UIImage imageNamed:@"发"];
        fromView.calloutView.title = @"附近2位配送员";
        return fromView;
    }else if ([annotation isKindOfClass:[ToPointAnnotation class]]){
        
        static NSString *toReuseIndentifier = @"toReuseIndentifier";
        ToAnnotationView *toView = (ToAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:toReuseIndentifier];
        if (toView == nil)
        {
            toView = [[ToAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:toReuseIndentifier];
        }
        toView.canShowCallout= NO;
        toView.image = [UIImage imageNamed:@"收"];
        toView.calloutView.title = @"预计12:00到达";
        return toView;
    }
    
    return nil;
}

- (void)searchView:(UIButton *)btn{
    AMap_SearchViewCtroller *searchVC = [[AMap_SearchViewCtroller alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)mapView:(UIButton *)btn{
    AMap_AMapViewCtroller *mapVC = [[AMap_AMapViewCtroller alloc]init];
    [self.navigationController pushViewController:mapVC animated:YES];
}

@end
