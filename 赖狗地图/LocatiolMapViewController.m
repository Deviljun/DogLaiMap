//
//  LocatiolMapViewController.m
//  赖狗地图
//
//  Created by 赖天翔 on 16/8/19.
//  Copyright © 2016年 赖天翔. All rights reserved.
//
#import "CLLocation+YCLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "LocatiolMapViewController.h"
#import "MKPAnnotation.h"
#import <MapKit/MapKit.h>

@interface LocatiolMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong)CLLocationManager * locationManager;
@property (nonatomic,strong)CLLocation * prevLocation;
@property (nonatomic,assign)CLLocationCoordinate2D coord;
@property (nonatomic,strong)CLLocation * userLocation;
@property (nonatomic,strong)MKPolyline * line;
@property (nonatomic,strong)MKCircle *circleTargePlace;
@end

@implementation LocatiolMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    else if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        self.locationManager.delegate = self;
        
        self.locationManager.desiredAccuracy =kCLLocationAccuracyBest;
        
        CLLocationDistance distance = 100.0;//每100米定位一次
        
        self.locationManager.distanceFilter = distance;
        
        [self.locationManager startUpdatingLocation];
        _mapView.userTrackingMode=MKUserTrackingModeFollow;
        [self.mapView setShowsUserLocation:YES];
        
        
        
        
    }
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    if (self.circleTargePlace)
    {
        [self.mapView removeOverlays:@[self.circleTargePlace]];
    }
    
    
    CLLocation *location=[locations firstObject];//取出第一个位置
    self.userLocation  = location;
    
    
    NSLog(@"%@",location);
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    //火星坐标，不准，转换一下
    CLLocation *newLocation = [location locationMarsFromEarth];
    
    
    
    
    
    
    CLLocationCoordinate2D coord = newLocation.coordinate;
    self.coord = coord;
    
    
    self.circleTargePlace=[MKCircle circleWithCenterCoordinate:coord radius:2000];
    
    [self getMKPointAnnotation];
    
    [self.mapView addOverlay:self.circleTargePlace];
    
    
    
    
}
#pragma mark -地图代理方法
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        
        MKCircleRenderer * circleRenderer = [[MKCircleRenderer alloc]initWithCircle:overlay];
        circleRenderer.fillColor = [UIColor blueColor];
        circleRenderer.strokeColor = [UIColor redColor];
        circleRenderer.alpha = 0.1;
        circleRenderer.lineWidth = 1.0;
        return circleRenderer;
        
        
    }
    
    if([overlay isKindOfClass:[MKPolyline class]])
    {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 4;
    return  renderer;
    }

    return nil;
    
}
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKPAnnotation class]])
    {
        MKPinAnnotationView * pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
        if (!pinView)
        {
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
        }
        //点击出气泡
        pinView.canShowCallout = YES;
        //动画掉落
        pinView.animatesDrop = YES;
        
        
        return pinView;
        
        
    }
    return nil;
    
}
//+31.30555565,+121.33683558
-(void)getMKPointAnnotation{
    
    
//    MKPAnnotation * annotation = [[MKPAnnotation alloc]init];
//    annotation.title = @"主题";
//    annotation.subtitle = [NSString stringWithFormat:@"%ld",(long)annotation.index];
//    annotation.index = 1;
//    
//    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(31.30555565, +121.33683558);
//    annotation.coordinate = location1;
//    
//    double dis = [self distanceFrom:self.coord to:annotation.coordinate];
//    
//    
//    
//    [self.mapView addAnnotation:annotation];
//    
//    
//    
//    
//    MKPAnnotation * annotation2 = [[MKPAnnotation alloc]init];
//    annotation2.title = @"主题2";
//    annotation2.subtitle = [NSString stringWithFormat:@"%ld",(long)annotation2.index];
//    annotation2.index = 2;
//    
//    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(31.30555, +121.33687558);
//    annotation2.coordinate = location2;
//    
//    [self.mapView addAnnotation:annotation2];
//    
//    
//    MKPAnnotation * annotation3 = [[MKPAnnotation alloc]init];
//    annotation3.title = @"主题3";
//    annotation3.subtitle = [NSString stringWithFormat:@"%ld",(long)annotation3.index];
//    annotation3.index = 3;
//    
//    CLLocationCoordinate2D location3=CLLocationCoordinate2DMake(31.33555665, +121.33687568);
//    annotation3.coordinate = location3;
//    
//    [self.mapView addAnnotation:annotation3];
//   
 
    
    for (int i = 0; i<10; i++)
    {
        MKPAnnotation * annotation = [[MKPAnnotation alloc]init];
        annotation.title = @"张骏";
        annotation.index = i;
        
        
        
        NSString * la = [NSString stringWithFormat:@"+31.30%d%d5%d65",arc4random()%10,arc4random()%10,arc4random()%5];
        NSString * li = [NSString stringWithFormat:@"+121.3%d6%d35%d8",arc4random()%10,arc4random()%10,arc4random()%4];
        
        
        
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([la doubleValue], [li doubleValue]);
        annotation.coordinate = coord;
       
        double distance = [self distanceFrom:self.coord to:coord];
//       if (distance<2000)
//        {
             [self.mapView addAnnotation:annotation];
       // }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    if (self.line)
    {
         [self.mapView removeOverlays:@[self.line]];
    }
   
    [self requestRoutWithSoure:self.coord Destination:view.annotation.coordinate];
    [self distanceFrom:self.coord to:view.annotation.coordinate];
    
}

/**
 *  画路线
 *
 *  @param start2D 开始坐标
 *  @param end2D   结束坐标
 */
-(void)requestRoutWithSoure:(CLLocationCoordinate2D)start2D  Destination:(CLLocationCoordinate2D)end2D
{
    //发送寻路请求
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    directionsRequest.transportType = MKDirectionsTransportTypeAny;
    
    MKPlacemark *startMark = [[MKPlacemark alloc] initWithCoordinate:start2D addressDictionary:nil];
    MKPlacemark *endMark = [[MKPlacemark alloc] initWithCoordinate:end2D addressDictionary:nil];
    
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startMark];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endMark];
    
    [directionsRequest setSource:startItem];
    [directionsRequest setDestination:endItem];
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    //接收rout
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if (!response)
        {
            return ;
        }
        NSArray *_routes  = [response routes];
        [_routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MKRoute *rout = obj;
            self.line = [rout polyline];
            [_mapView addOverlay:self.line];
        }];
        //根据 routes  数据 确定region的呈现范围
        //[self centerMap:_routes];
        
        
    }];
}
-(CLLocationDistance)distanceFrom:(CLLocationCoordinate2D)start to:(CLLocationCoordinate2D)end{
    CLLocation *startLocation = [[CLLocation alloc]initWithLatitude:start.latitude longitude:start.longitude];
    CLLocation * endLocation = [[CLLocation alloc]initWithLatitude:end.latitude longitude:end.longitude];
   
    CLLocationDistance distance =  [startLocation distanceFromLocation:endLocation];
    
    NSLog(@"%f",distance);
    return distance;
    
}
- (IBAction)refresh:(id)sender {
    [self getMKPointAnnotation];
}

@end
