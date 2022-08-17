//
//  LikeController.m
//  project_2
//
//  Created by lizhi on 2022/8/5.
//

#import "LikeController.h"

@interface LikeController ()
@property (nonatomic,strong) UIButton* returnButton;
@property (nonatomic,assign) int width;
@property (nonatomic,assign) int height;
@property (nonatomic,strong) MyView* head;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) UIAlertController* deleteAlert;
@end

@implementation LikeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.width= UIScreen.mainScreen.bounds.size.width;
    self.height = UIScreen.mainScreen.bounds.size.height;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}
-(void)setupSubViews{
    [self dataLoad];
    [self tableView];
    [self head];
    [self bottom];
    [self returnButton];
}
-(void)refresh{
    _bottom.lb1.text = _musicName;
    _bottom.lb2.text = _musicSinger;
    [self dataLoad];
    [[self tableView]reloadData];
}
-(void)dataLoad {
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString* fileName = [path stringByAppendingPathComponent: @"likeMusic.plist"];
    NSLog(@"%@",fileName);
    _likeMusicList = [NSMutableArray arrayWithContentsOfFile:fileName];
    NSLog(@"%@",_likeMusicList);
    
}
#pragma mark - 懒加载
-(MyView*)head{
    if(!_head){
        _head = [[MyView alloc]initWithFrame:CGRectMake(0, 40, _width, 50)];
        //_head.backgroundColor = [UIColor whiteColor];
        _head.lb1.text = @"我的歌单";
        _head.lb1.frame = CGRectMake(_width/4, 15, _width/2, 20);
        _head.lb1.textAlignment = NSTextAlignmentCenter;
        _head.lb1.font = [UIFont systemFontOfSize:20];
        _head.lb1.textColor = [UIColor blackColor];
        //    _head.lb2.text = self.musicSinger;
        //    _head.lb2.frame = CGRectMake(_width/4, 25, _width/2, 15);
        //    _head.lb2.textAlignment = NSTextAlignmentCenter;
        //    _head.lb2.font = [UIFont systemFontOfSize:14];
        //    _head.lb2.textColor = [UIColor whiteColor];
        [self.view addSubview:_head];
        //[_head addSubview:_button1];
        //[_head ]
    }
    return _head;
}
-(UIButton*)returnButton{
    if(!_returnButton){
        _returnButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
        [_returnButton setTitle:@"返回" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //_button1.backgroundColor = [UIColor whiteColor];
        [_returnButton addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_returnButton];
    }
    return  _returnButton;
}
-(UITableView*)tableView{
    if(!_tableView){
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, self.width, self.height-148) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.1)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview: _tableView];
    }
    return _tableView;
}
- (MyView*)bottom{
    //bottom
    if(!_bottom){
        _bottom = [[MyView alloc]initWithFrame:CGRectMake(0, self.height-58,self.width, 58)];
        UIImage *img_fm = [UIImage imageNamed:@"cover"];
        _bottom.leftImg.image = img_fm;
        _bottom.lb1.text = _musicName;
        UIImage *img = [UIImage imageNamed:@"play"];
        _bottom.rightImg.image= img;
        _bottom.leftImg.frame = CGRectMake(15, 5, 50, 50);
        _bottom.backgroundColor = [UIColor whiteColor];
        _bottom.lb1.frame = CGRectMake(75, 10, 100,15);
        _bottom.lb2.frame = CGRectMake(75, 30, 100,15);
        _bottom.lb2.text = _musicSinger;
        _bottom.lb2.font = [UIFont fontWithName:@"Heiti SC" size:12];
        _bottom.layer.borderWidth = 1;
        _bottom.layer.borderColor = [UIColor grayColor].CGColor;
        _bottom.rightImg.frame = CGRectMake(self.width-40, 30, 25, 25);
        [self.view addSubview: _bottom];
    }
    return _bottom;
}
#pragma  mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [_likeMusicList count];
}
-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 70;
}
-(MyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    //首先根据标识去缓存池取
    //重用实现
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:cellIdentifier];
    }
    //    Music * m1 = _tableData[indexPath.row];
    //    [cell setMusic: m1];
    [cell.btnType setTitle:@"删除" forState:UIControlStateNormal];
    cell.textLabel.text = [_likeMusicList[indexPath.row] objectForKey:@"likeMusicName"];
    cell.detailTextLabel.text = [_likeMusicList[indexPath.row] objectForKey:@"likeMusicSinger"];
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.delegate = self;
    cell.tag = indexPath.row;
    //NSLog(@"--------------");
    return  cell;
}
#pragma mark - 按钮点击事件
-(void)btn_click:(UIButton*) button{
    NSLog(@"按钮点击");
    // NSLog(@"music = %@,singer = %@",_musicName,_musicSinger);
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if(self.delegate && [self.delegate respondsToSelector:@selector(transformData:)]){
        [self.delegate transformData:self.likeMusicList];
        NSLog(@"数据传递成功");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)myCellBtnClick:(UIButton *)button incell:( MyTableViewCell *)cell
{
    __weak typeof(self) weakSelf = self;
    _deleteAlert = [UIAlertController alertControllerWithTitle:@"确认删除" message:@"这首歌曲将被从我喜欢的歌曲中移除" preferredStyle:UIAlertControllerStyleAlert];
    [_deleteAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消删除");
    }]];
    [_deleteAlert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.likeMusicList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([[obj objectForKey:@"likeMusicName"] isEqualToString:cell.textLabel.text]){
                *stop = YES;
                [weakSelf.likeMusicList removeObject:obj];
            }
        }];
        NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString* fileName = [path stringByAppendingPathComponent: @"likeMusic.plist"];
        if([weakSelf.likeMusicList writeToFile:fileName atomically:YES]){
            NSLog(@"写入成功！！！");
        }
        [weakSelf refresh];
        NSLog(@"当前cell：%@",cell.textLabel.text);
    }]];
    [self presentViewController:_deleteAlert animated:YES completion:nil];
    //    _myAlert = [UIAlertController alertControllerWithTitle:@"确认播放" message:@"是否播放当前歌曲" preferredStyle:UIAlertControllerStyleAlert];
    //    [_myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //        //NSLog(@"取消and%d",cell.tag);
    //    }]];
    //    [_myAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action ) {
    //        NSLog(@"确定");
    //        __weak typeof(self) weakSelf = self;
    //        if(!weakSelf.myController1){
    //           weakSelf.myController1 = [[MyController alloc]init];
    //        }
    ////        else{
    ////            [weakSelf.myController1 viewDidLoad];
    ////        }
    //        [weakSelf.myController1 setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    //        weakSelf.myController1.modalPresentationStyle = UIModalPresentationFullScreen;
    //        if(![weakSelf.myController1.musicName isEqualToString:cell.music.name] ){
    //            weakSelf.myController1.musicName = cell.music.name;
    //            weakSelf.myController1.musicSinger = cell.music.singer;
    //
    //        }
    //
    //        //[self presentViewController:mycontroller1 animated:YES completion:nil];
    //        [self.navigationController pushViewController:weakSelf.myController1 animated:YES];
    //        cell.textLabel.textColor = [UIColor redColor];
    //        self.bottom.lb1.text = cell.music.name;
    //        self.bottom.lb2.text = cell.music.singer;
    //    }]];
    //
    //    [self presentViewController:_myAlert animated:YES completion:nil];
    
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
