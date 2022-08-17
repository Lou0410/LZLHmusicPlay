//
//  ViewController.m
//  project_2
//
//  Created by lizhi on 2022/7/21.
//

#import "ViewController.h"


@interface ViewController ()

@property(nonatomic,strong) MyController* myController1;
@property (nonatomic,strong) MyView *head;
@property (nonatomic,strong) UITableView *myTabileView;
@property (nonatomic,strong) NSMutableArray *myData;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,strong) MyView *afterHead;
@property (nonatomic,strong) MyView *bottom;
@property (nonatomic,strong) UIAlertController *myAlert;
@property (nonatomic,assign) int width;
@property (nonatomic,assign) int height;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSLog(@"%@/n%@",dic,jsonString);
    //初始化
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",NSStringFromCGRect([[UIScreen mainScreen]bounds]));
    self.width= UIScreen.mainScreen.bounds.size.width;
    self.height = UIScreen.mainScreen.bounds.size.height;
    
    //导航栏
    //self.title = @"大标题";
    /*self.navigationItem.title = @"标题";
     self.navigationController.navigationBar.translucent = YES;
     [[UINavigationBar appearance]setBarStyle:UIBarStyleDefault];
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     self.navigationController.navigationBar.barTintColor = [UIColor redColor];*/
    
    [self initData];
    //懒加载
    [self setupSubviews];
    //NSLog(@"%@",self.myTabileView.layer.description);
    //height部分
    /*
     label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
     label1.text=@"我的歌单";
     label1.font = [UIFont fontWithName:@"Heiti SC" size:20];
     label1.textColor = [UIColor whiteColor];
     label1.backgroundColor = [UIColor redColor];
     label1.textAlignment = NSTextAlignmentCenter;
     [self.view addSubview:label1];*/
    // Do any additional setup after loading the view.
    /* //stackview部分
     myStackView = [[UIStackView alloc]initWithFrame:CGRectMake(0, 90, 320, 30)];
     UIImage *img = [UIImage imageNamed:@"播放.jpeg"];
     UIImageView *imgv= [[UIImageView alloc]initWithImage:img];
     imgv.contentMode = UIViewContentModeScaleAspectFit;
     imgv.frame=CGRectMake(0, 0, 25, 25);
     UILabel *la1=[[UILabel alloc]init];
     la1.text=@"播放音乐";
     myStackView.axis = UILayoutConstraintAxisHorizontal;
     myStackView.alignment = UIStackViewAlignmentLeading;
     myStackView.distribution = UIStackViewDistributionEqualCentering;
     [myStackView addArrangedSubview:imgv];
     [myStackView addArrangedSubview:la1];
     [self.view addSubview:myStackView];*/
    //    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(_width/2-50, _height/2-50, 100, 100)];
    //        redView.backgroundColor=[UIColor redColor];
    //        [self.view addSubview:redView];
    //        
    //        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //        animation.keyPath = @"position";
    //        CGMutablePathRef path=CGPathCreateMutable();
    //        CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 100, 100));
    //        animation.path=path;
    //        CGPathRelease(path);
    //        animation.repeatCount=MAXFLOAT;
    //        animation.removedOnCompletion = NO;
    //        animation.fillMode = kCAFillModeForwards;
    //        animation.duration = 4.0f;
    //        animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //        animation.delegate=self;
    //        [redView.layer addAnimation:animation forKey:nil];
    
    
    
}

-(void)setupSubviews {
    [self.view addSubview: self.head];
    //self.bottom.frame =
    // [self.view addSubview: self.afterHead];
    [self.view addSubview: self.myTabileView];
    [self.view addSubview: self.bottom];
}

#pragma mark 加载数据
-(void)initData{
    //NSString *s1=@"歌曲";
    //NSString *s2=@"歌手";
    //json解析
    NSString *url = [[NSBundle mainBundle]pathForResource:@"music" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:url];
    //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    // NSString *jsonString =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSData *jsData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //NSLog(@"%d",[[dict objectForKey:@"music"] isKindOfClass:[NSArray class]]);
    //载入数据
    _myData = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"music"]];
    _tableData = [[NSMutableArray alloc]init];
    for(int i=0; i < [_myData count];i++){
        Music *m = [[Music alloc]initWithName:[_myData[i] objectForKey:@"name"] andSinger:[_myData[i] objectForKey:@"author"] andMusicId:[_myData[i] objectForKey:@"id"]];
        [_tableData addObject:m];
    }
    //NSLog(@"%@",_myData);
    /*for(int i=0;i<20;i++){
     Music* m = [[Music alloc]initWithName:[NSString stringWithFormat:@"歌曲%d",i] andSinger:[NSString stringWithFormat:@"歌手%d",i]];
     [_myData addObject:m];
     }*/
    
    
    
}
#pragma  mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [_myData count];
}
-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%@",indexPath.description);
    tableView.visibleCells[indexPath.row].textLabel.textColor = [UIColor blueColor];
    
}
#pragma mark - 返回每行的单元格
-(MyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    //首先根据标识去缓存池取
    //重用实现
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:cellIdentifier];
    }
    //[cell.btnType setTitle:@"点击" forState:UIControlStateNormal];
    Music * m1 = _tableData[indexPath.row];
    [cell setMusic: m1];
    //cell.textLabel.text=[m1 name];
    //cell.detailTextLabel.text=[m1 singer];
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.delegate = self;
    cell.tag = indexPath.row;
    //NSLog(@"--------------");
    return  cell;
}
#pragma mark 按钮响应事件
- (void)myCellBtnClick:(UIButton *)button incell:( MyTableViewCell *)cell
{
    _myAlert = [UIAlertController alertControllerWithTitle:@"确认播放" message:@"是否播放当前歌曲" preferredStyle:UIAlertControllerStyleAlert];
    [_myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"取消and%d",cell.tag);
    }]];
    __weak typeof(self) weakSelf = self;
    [_myAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action ) {
        NSLog(@"确定");
        
        if(!weakSelf.myController1){
            weakSelf.myController1 = [[MyController alloc]init];
        }
        //        else{
        //            [weakSelf.myController1 viewDidLoad];
        //        }
        [weakSelf.myController1 setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        weakSelf.myController1.modalPresentationStyle = UIModalPresentationFullScreen;
        if(![weakSelf.myController1.musicName isEqualToString:cell.music.name] ){
            weakSelf.myController1.musicSinger = cell.music.singer;
            weakSelf.myController1.musicName = cell.music.name;
            
            
        }
        
        //[self presentViewController:mycontroller1 animated:YES completion:nil];
        [weakSelf.navigationController pushViewController:weakSelf.myController1 animated:YES];
        cell.textLabel.textColor = [UIColor redColor];
        weakSelf.bottom.lb1.text = cell.music.name;
        weakSelf.bottom.lb2.text = cell.music.singer;
    }]];
    
    [self presentViewController:_myAlert animated:YES completion:nil];
    
}
#pragma mark 懒加载
- (MyView*)head{
    if(!_head){
        _head = [[MyView alloc]initWithFrame:CGRectMake(0, 30, self.width, 60)];
        UIImage *img1 = [UIImage imageNamed:@"return"];
        _head.leftImg.image = img1;
        _head.lb1.text = @"本地音乐";
        _head.leftImg.frame = CGRectMake(15,10, 40, 40);
        _head.lb1.frame = CGRectMake(60, 0, 200, 60);
        //head.lb1.backgroundColor = [UIColor blueColor];
        _head.lb1.font = [UIFont fontWithName:@"Heiti SC" size:24];
        _head.lb1.textColor = [UIColor whiteColor];
        _head.backgroundColor = [UIColor redColor];
        //[self.view addSubview: _head];
    }
    return _head;
}
- (MyView*)afterHead{
    //afterHead
    if(!_afterHead){
        _afterHead = [[MyView alloc]initWithFrame:CGRectMake(0,90,self.width,30)];
        UIImage *img = [UIImage imageNamed:@"play"];
        _afterHead.leftImg.image = img;
        UIImage *img11 = [UIImage imageNamed:@"refresh"];
        _afterHead.rightImg.image = img11;
        //[[myview imgv]setImage: img];
        _afterHead.lb1.text=@"播放全部歌曲";
        //[self.view addSubview: _afterHead];
    }
    return _afterHead;
}
- (UITableView*)myTabileView{
    //tableview部分
    if(!_myTabileView){
        _myTabileView=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, self.width, self.height-148) style:UITableViewStyleGrouped];
        _myTabileView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.1)];
        _myTabileView.dataSource = self;
        _myTabileView.delegate = self;
        [self.view addSubview: _myTabileView];
    }
    return _myTabileView;
}
- (MyView*)bottom{
    //bottom
    if(!_bottom){
        _bottom = [[MyView alloc]initWithFrame:CGRectMake(0, self.height-58,self.width, 58)];
        UIImage *img_fm = [UIImage imageNamed:@"cover"];
        _bottom.leftImg.image = img_fm;
        _bottom.lb1.text = @"不要说话";
        UIImage *img = [UIImage imageNamed:@"play"];
        _bottom.rightImg.image= img;
        _bottom.leftImg.frame = CGRectMake(15, 5, 50, 50);
        _bottom.backgroundColor = [UIColor whiteColor];
        _bottom.lb1.frame = CGRectMake(75, 10, 100,15);
        _bottom.lb2.frame = CGRectMake(75, 30, 100,15);
        _bottom.lb2.text = @"陈奕迅";
        _bottom.lb2.font = [UIFont fontWithName:@"Heiti SC" size:12];
        _bottom.layer.borderWidth = 1;
        _bottom.layer.borderColor = [UIColor grayColor].CGColor;
        _bottom.rightImg.frame = CGRectMake(self.width-40, 30, 25, 25);
        [self.view addSubview: _bottom];
    }
    return _bottom;
}

@end
