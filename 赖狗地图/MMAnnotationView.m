//
//  MMAnnotationView.m
//  赖狗地图
//
//  Created by 赖天翔 on 16/8/29.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import "MMAnnotationView.h"

@implementation MMAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if ( self )
    {
        self.frame = CGRectMake(0, 0, 70, 70);
        self.centerOffset = CGPointMake(0, -(70)/2);
        self.canShowCallout = NO;
        
        self.avatarView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.avatarView];
        self.avatarView.contentMode = UIViewContentModeScaleToFill;
        
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        shapelayer.frame = self.bounds;
        shapelayer.path = self.framePath.CGPath;
        self.avatarView.layer.mask = shapelayer;
        
        self.layer.shadowPath = self.framePath.CGPath;
        self.layer.shadowRadius = 1.0f;
       // self.layer.shadowColor = [UIColor colorWithHex:0x666666FF].CGColor;
        self.layer.shadowOpacity = 1.0f;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.masksToBounds = NO;
    }
    return self;
}
//mask路径
- (UIBezierPath *)framePath
{
    if ( !_framePath )
    {
        CGFloat arrowWidth = 70;
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGRect rectangle = CGRectInset(CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetWidth(self.bounds)), 10,10);
        
        CGPoint p[3] = {
            {CGRectGetMidX(self.bounds)-arrowWidth/3, CGRectGetWidth(self.bounds)-16},
            {CGRectGetMidX(self.bounds)+arrowWidth/3, CGRectGetWidth(self.bounds)-16},
            {CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds)-4}
        };
        
        CGPathAddRoundedRect(path, NULL, rectangle, 10, 10);
        CGPathAddLines(path, NULL, p, 3);
        
        CGPathCloseSubpath(path);
        
        _framePath = [UIBezierPath bezierPathWithCGPath:path];
        
        CGPathRelease(path);
        
        
       
    }
    
    return _framePath;
}
@end
