//
//  FromAnnotationView.h
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/21.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FromAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end

NS_ASSUME_NONNULL_END
