//
//  ToPointAnnotation.h
//  TNShipper
//
//  Created by 朴子hp on 2019/5/10.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToPointAnnotation : MAPointAnnotation

/// 收类型 0司机图片 1附近司机
@property (assign, nonatomic) NSInteger fromType;

/// 收类型 0附近司机 1预计到达时间
@property (assign, nonatomic) NSInteger toType;

@end

NS_ASSUME_NONNULL_END
