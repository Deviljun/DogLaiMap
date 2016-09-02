//
//  MapViewController.m
//  赖狗地图
//
//  Created by 赖天翔 on 16/7/25.
//  Copyright © 2016年 赖天翔. All rights reserved.
//
#import "MMAnnotationView.h"
#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MKPAnnotation.h"
@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl * segmentControl;
@property (nonatomic,strong)NSArray * routes;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    [self addMKAnnotation];
    
    
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
- (IBAction)selectMapType:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            self.mapView.mapType = 0;
            [self.mapView removeAnnotations:self.mapView.annotations];
            [self.mapView removeOverlays:self.mapView.overlays];
        }
            break;
        case 1:
        {
             self.mapView.mapType = 1;
           
        }
            break;
        case 2:
        {
             self.mapView.mapType = 2;
        }
            break;
            
        default:
            break;
    }
}
-(void)addMKAnnotation{
    
    MKPointAnnotation * pointAnnotation = [[MKPointAnnotation alloc]init];
    pointAnnotation.title = @"主题";
    pointAnnotation.subtitle = @"副标题副标题副标题副标题副标题";
   CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(39.95, 116.35);
    pointAnnotation.coordinate = location1;
    [self.mapView addAnnotation:pointAnnotation];
    
    MKCircle *circleTargePlace=[MKCircle circleWithCenterCoordinate:location1 radius:2000];
    
    [_mapView addOverlay:circleTargePlace];
    
    
    
    CLLocation * loc1 = [[CLLocation alloc]initWithLatitude:39.95 longitude:116.35];
    CLLocation * loc2 = [[CLLocation alloc]initWithLatitude:40 longitude:116.35];
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    MKPointAnnotation * p = [[MKPointAnnotation alloc]init];
    p.title = @"主题";
    p.subtitle = @"啊？";
   // p.subString = @"123";
    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(40, 116.35);
    p.coordinate = location2;
    [self.mapView addAnnotation:p];
    
     [self.mapView showAnnotations:@[pointAnnotation,p] animated:true];
    [self requestRoutWithSoure:pointAnnotation.coordinate Destination:p.coordinate];

//    [self.mapView selectAnnotation:pointAnnotation animated:true];
//    [self.mapView selectAnnotation:p animated:true];
    [self.mapView setSelectedAnnotations:@[pointAnnotation]];
    [self.mapView setSelectedAnnotations:@[p]];
    
    
}

/******************
MKAnnotationView和MKPinAnnotationView的区别:
 MKAnnotationView是MKPinAnnotationView的父类
 MKAnnotationView可以自定义大头针的图片，但没有动画效果
 
**********/



-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString * identifier = @"pin";
    
    if ([annotation isKindOfClass:[MKPAnnotation class]])
    {
        MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"待配送@2x.png"];
//            
//         [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"] options:SDWebImageDownloaderProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//             
//         } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//             annotationView.image = [UIImage imageWithData:data];
//         }];
            
        }

        
        
        MKPAnnotation * p = (MKPAnnotation*)annotation;
        NSLog(@"%@",p.subString);
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        button.backgroundColor = [UIColor redColor];
        button.tag = [p.subString integerValue];
        
        [button addTarget:self action:@selector(annination:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = button;
        NSLog(@"%f",annotationView.frame.origin.y);
        annotationView.selected = YES;
        
        return annotationView;
        
    }
    
    
    
    
    
    MMAnnotationView * annotationView = (MMAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil)
    {
        annotationView = [[MMAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
       // annotationView.canShowCallout = YES;
    }
    
    [annotationView.avatarView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"]];
    
//    annotationView.image = [UIImage imageNamed:@"待配送@2x.png"];
//    
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    imageView.image = [UIImage imageNamed:@"待配送@2x.png"];
//    annotationView.leftCalloutAccessoryView = imageView;
    

    
//    annotationView.animatesDrop = YES;
//    annotationView.selected = YES;
    
    
    return annotationView;
}
#pragma mark -地图代理
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
        _routes  = [response routes];
        [_routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MKRoute *rout = obj;
            MKPolyline *line = [rout polyline];
            [_mapView addOverlay:line];
        }];
        //根据 routes  数据 确定region的呈现范围
        //[self centerMap:_routes];
        
        
    }];
}
/**
 *  覆盖物
 *
 *  @param mapView 地图
 *  @param overlay 覆盖
 *
 *  @return 渲染覆盖物
 */



  
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        
        MKCircleView *_circleView= [[MKCircleView alloc] initWithCircle:overlay] ;
        
        _circleView.fillColor =  [UIColor blueColor];
        
        _circleView.strokeColor = [UIColor redColor];
        _circleView.alpha = 0.3;
        
        _circleView.lineWidth=2.0;
        
        return _circleView;
        
        
    }

    
    
    
    
    
    
    
    
    
    
    
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 4;
    return  renderer;
}
#pragma mark -lazy
-(NSArray*)routes{
    if(!_routes)
    {
        _routes = [NSArray array];
    }
    return _routes;
}

-(void)annination:(UIButton*)button{
    NSLog(@"%ld",(long)button.tag);
}

@end
