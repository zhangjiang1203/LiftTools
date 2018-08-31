//
//  ViewController.m
//  SystemMapViewScroller
//
//  Created by 栗子 on 2018/6/20.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

#import "ViewController.h"
#import "SystemMapViewScroller.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UITableView *tableView     = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate         = self;
    tableView.dataSource       = self;
    [self.view addSubview:tableView];
    tableView.backgroundColor  = [UIColor groupTableViewBackgroundColor];
    tableView.tableFooterView  = [UIView new];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TABLEVIEW"];
    if (!cell) {
        cell              = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TABLEVIEW"];
    }
    cell.textLabel.text   = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self mapScroller];
}

- (void)mapScroller{
    
    SystemMapViewScroller *mapView = [[SystemMapViewScroller alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [mapView show];
    
    
    
//    [PopoutClass leeAleartCustomVIew:mapView customW:SCREEN_WIDTH customH:SCREEN_HEIGHT alearAlpha:0.4 positionType:(LEECustomViewPositionTypeCenter) openAnimationStyle:LEEAnimationStyleOrientationBottom | LEEAnimationStyleFade closeAnimationStyle:LEEAnimationStyleOrientationBottom | LEEAnimationStyleFade openAnimDuration:0.3 closeAnimDuration:0.3 clickBackgroundClose:YES];
    
}

@end
