//
//  AMap_AMapViewCtroller.m
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/20.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import "AMap_AMapViewCtroller.h"

@interface AMap_AMapViewCtroller ()

@end

@implementation AMap_AMapViewCtroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标注处理";
    [self setUpTouchEventUI];
    [self addFromLocationInfo:CLLocationCoordinate2DMake(31.294231, 121.115371)];
}

#pragma mark - 对应事件UI
- (void)setUpTouchEventUI{
    
    UIButton *driverBtn = [[UIButton alloc]init];
    driverBtn.tag = 100;
    driverBtn.frame = CGRectMake(20, kNavH + 10, 40, 40);
    [driverBtn setTitle:@"添加" forState:UIControlStateNormal];
    [driverBtn addTarget:self action:@selector(userThouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    driverBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:driverBtn];
    
    UIButton *timeBtn = [[UIButton alloc]init];
    timeBtn.tag = 101;
    timeBtn.frame = CGRectMake(75, kNavH + 10, 40, 40);
    [timeBtn setTitle:@"重置" forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(userThouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:timeBtn];
    
    UIButton *removeBtn = [[UIButton alloc]init];
    removeBtn.tag = 102;
    removeBtn.frame = CGRectMake(130, kNavH + 10, 40, 40);
    [removeBtn setTitle:@"移除" forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(userThouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    removeBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:removeBtn];
    
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.tag = 103;
    searchBtn.frame = CGRectMake(185, kNavH + 10, 40, 40);
    [searchBtn setTitle:@"更新" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(userThouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:searchBtn];
    
}

#pragma mark - 对应事件处理
- (void)userThouchEvent:(UIButton *)btn{
    
    switch (btn.tag) {
            
            /// 添加
        case 100:{
            [self addFromLocationInfo:CLLocationCoordinate2DMake(31.394216, 121.115368)];
            [self addToLocationTime:CLLocationCoordinate2DMake(31.294216, 121.115368) toTime:@"12:00"];
        }break;
            
            /// 重置
        case 101:{
            [self resetFromLocationInfo:CLLocationCoordinate2DMake(31.294216, 121.215368)];
        }break;
            
            /// 移除
        case 102:{
            [self.mapView removeAnnotation:self.fromPoint];
        }break;
            
            /// 更新
        case 103:{
            [self updateToLocationTitle:@"13:00"];
        }break;
            
    }
    
}

- (void)dealloc{
    NSLog(@"地图销毁");
}

@end
