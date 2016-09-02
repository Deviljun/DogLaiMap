//
//  MKPAnnotation.h
//  赖狗地图
//
//  Created by 赖天翔 on 16/7/27.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKPAnnotation : MKPointAnnotation
@property (nonatomic,copy)NSString * subString;
@property (nonatomic,assign)NSInteger index;
@end
