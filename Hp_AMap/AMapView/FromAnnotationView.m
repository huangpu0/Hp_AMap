//
//  FromAnnotationView.m
//  Hp_AMap
//
//  Created by 朴子hp on 2019/5/21.
//  Copyright © 2019 朴子hp. All rights reserved.
//

#import "FromAnnotationView.h"

@interface FromAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

@implementation FromAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]){
        
        self.bounds = CGRectMake(0.f, 0.f, 60, 60);
        self.backgroundColor = [UIColor clearColor];
        
        self.calloutView = [[CustomCalloutView alloc]init];
        self.calloutView.frame = CGRectMake(0, 0, 125, 40);
        self.calloutView.center = CGPointMake( self.calloutOffset.x + 10,-CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
        [self addSubview:self.calloutView];
        
    }
    
    return self;
}

@end
