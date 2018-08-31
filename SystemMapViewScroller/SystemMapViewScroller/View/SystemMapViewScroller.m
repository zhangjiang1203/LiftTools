//
//  SystemMapViewScroller.m
//  Case
//
//  Created by 栗子 on 2018/3/26.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import "SystemMapViewScroller.h"

@interface SystemMapViewScroller()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView      *TopBgView;
@property (nonatomic, strong) UIView      *topView;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation SystemMapViewScroller

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        
    }
    return self;
    
}

-(void)createUI{
    
    self.TopBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-250)];
    [self addSubview:self.TopBgView];
    self.TopBgView.backgroundColor = [UIColor clearColor];
    
    self.topView = [[UIView alloc]init];
    [self.TopBgView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-1);
        make.height.mas_offset(50);
    }];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.topView layoutIfNeeded];
    [ToolClass viewBeizerRect:self.topView.bounds view:self.topView corner:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(10, 10)];
    
    UIView *line = [[UIView alloc]init];
    [self.TopBgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *nameLB = [[UILabel alloc]init];
    [self.topView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(16);
        make.centerY.equalTo(self.topView.mas_centerY).offset(0);
    }];
    nameLB.text = @"仿苹果系统地图";
    nameLB.textAlignment = NSTextAlignmentCenter;
    
    self.tableView = [[UITableView alloc]init];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.top.equalTo(self.TopBgView.mas_bottom).offset(0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 100;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TABLEVIEW"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TABLEVIEW"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismiss];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag ==self.tableView.tag) {
        static float newY = 0;
        newY = scrollView.contentOffset.y;
        NSLog(@"滚动距离--%f",newY);
        float height = self.TopBgView.frame.size.height;
        height -= newY;
        NSLog(@"滚动距离--%f======%f",newY,height);
        if (height < 100) {
            self.TopBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        }else if (height>SCREEN_HEIGHT-250){
            self.TopBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-250);
        }else{
            self.TopBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < 100){
        self.TopBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    }else if (point.y>SCREEN_HEIGHT-250){
//        self.TopBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, point.y);
        [self dismiss];
        
    }else{
        self.TopBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, point.y);
    }
    NSLog(@"开始点击==%f",point.y);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"结束触摸==%@",touches);
}


@end
