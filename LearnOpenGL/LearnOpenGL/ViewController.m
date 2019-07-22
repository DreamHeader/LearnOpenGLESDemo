//
//  ViewController.m
//  LearnOpenGL
//
//  Created by MacHD on 2019/7/22.
//  Copyright © 2019 FDK. All rights reserved.
//

#import "ViewController.h"
#import "MyGLKViewController.h"
#define SCREEN_Width  [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray  * listArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"学习OpenGL";
    self.listArray = [[NSMutableArray alloc]initWithArray:@[@"OpenGl画纹理"]];
    [self configView];
    // Do any additional setup after loading the view.
}
-(void)configView{
    [self.view   addSubview:self.myTableView];
}
#pragma mark - Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    if (self.listArray.count>indexPath.row) {
        cell.textLabel.text = self.listArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listArray.count > indexPath.row) {
        switch (indexPath.row) {
            case 0:{
                MyGLKViewController * glkVC = [[MyGLKViewController alloc]init];
                [self.navigationController pushViewController:glkVC animated:YES];
             }
                break;
                
            default:
                break;
        }
    }
}
#pragma mark - Lazy load
-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_Width, SCREEN_Height - 50) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _myTableView;
}

@end
