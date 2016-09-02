//
//  MMAnnotationView.h
//  赖狗地图
//
//  Created by 赖天翔 on 16/8/29.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MMAnnotationView : MKAnnotationView
@property (nonatomic,strong)UIImageView* avatarView;
@property (nonatomic,strong)UIBezierPath*framePath;
@end
