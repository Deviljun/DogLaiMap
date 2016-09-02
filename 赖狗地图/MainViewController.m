//
//  MainViewController.m
//  赖狗地图
//
//  Created by 赖天翔 on 16/7/25.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import "MainViewController.h"
#import "LocatiolMapViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.row)
    {
        case 0:
        {
            cell.textLabel.text = @"地图";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"不晓得";
        }
            break;
            
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row)
    {
        case 0:
        {
            MapViewController * mapVC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
            [self.navigationController pushViewController:mapVC animated:true];
        }
            break;
            
        case 1:
        {
            LocatiolMapViewController * mapVC = [[LocatiolMapViewController alloc]initWithNibName:@"LocatiolMapViewController" bundle:nil];
            [self.navigationController pushViewController:mapVC animated:true];
        }
            break;

        default:
            break;
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
