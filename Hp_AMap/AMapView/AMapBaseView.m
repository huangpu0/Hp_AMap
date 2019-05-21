//
//  AMapBaseView.m
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/21.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import "AMapBaseView.h"

static AMapBaseView    *mapView = nil;
static dispatch_once_t onceToken1;
static dispatch_once_t onceToken2;

@implementation AMapBaseView

+ (AMapBaseView *)shareAMapView {
    
    dispatch_once(&onceToken1, ^{
        
        if (mapView == nil) {
            CGRect frame = [[UIScreen mainScreen] bounds];
            mapView = [[AMapBaseView alloc] initWithFrame:frame];
            mapView.autoresizingMask =
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            mapView.showsCompass = NO;
            mapView.showsScale   = NO;
            mapView.zoomLevel    = 16.0f;
            mapView.showsUserLocation = YES;
        }
        mapView.frame = [UIScreen mainScreen].bounds;
    });
    return mapView;
}

/// 重写allocWithZone保证分配内存alloc相同
+ (id)allocWithZone:(NSZone *)zone {
    dispatch_once(&onceToken2, ^{
        if (mapView == nil) {
            mapView = [super allocWithZone:zone];
        }
    });
    return mapView;
}

/// 保证copy相同
- (id)copyWithZone:(NSZone *)zone {
    return mapView;
}

/**
 * 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
 */
+(void)attempDealloc{
    onceToken1 = 0;
    onceToken2 = 0;
    mapView = nil;
}

@end
