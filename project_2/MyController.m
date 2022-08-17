//
//  myController.m
//  project_2
//
//  Created by lizhi on 2022/7/27.
//

#import "MyController.h"
#import "KVOTest.h"

@interface MyController ()
@property (nonatomic,strong) UIButton* returnButton;
@property (nonatomic,strong) MyView* head;
@property (nonatomic,strong) UIView* circleView;
@property (nonatomic,assign) int width;
@property (nonatomic,assign) int height;
@property (nonatomic,strong) UIButton* toLikeButton;
@property (nonatomic,strong) PlayView* playView;
//@property UIButton * button1;
@property (nonatomic,strong) UILabel* musicLable;
//@property (nonatomic,strong) UIButton* KVObutton;
//@property (nonatomic,strong) KVOTest* KVOdata;
@property (nonatomic,strong) NSURL* playUrl;
@property (nonatomic,strong) AVPlayer* player;
@property (nonatomic,strong) AVPlayerItem* songItem;
@property (nonatomic,strong) id timeObserve;
@property (nonatomic,assign) bool isPause;
@property (nonatomic,strong) NSMutableArray* likeMusicList;
@property (nonatomic,strong) LikeController* likeController;
@property (nonatomic,strong) NSMutableArray* testList;
@end

@implementation MyController
dispatch_semaphore_t sig ;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"页面大小%@",NSStringFromCGRect(self.view.frame));
    self.navigationController.navigationBarHidden = YES;
    self.width = UIScreen.mainScreen.bounds.size.width;
    self.height = UIScreen.mainScreen.bounds.size.height;
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString* fileName = [path stringByAppendingPathComponent:@"likeMusic.plist"];
    self.likeMusicList = [NSMutableArray arrayWithContentsOfFile:fileName];
    _testList = [NSMutableArray new];
    [self setupSubViews];
    __weak typeof(self) weakSelf = self;
    [_likeMusicList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([[obj objectForKey:@"likeMusicName"] isEqualToString:_musicName]){
            *stop = YES;
            weakSelf.playView.likeButton.selected = YES;
        }
    }];
    NSLog(@"------------主线程是：%@",[NSThread currentThread]);
    
    [self getMusicURL];
    [self addObserver:self forKeyPath:@"musicName" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"~~~~~~~~~~~~~~%@~~~~~~~~~~~",[AVAudioSession sharedInstance].category);
    dispatch_queue_t queue = dispatch_queue_create("firstqueue", DISPATCH_QUEUE_CONCURRENT);
    sig = dispatch_semaphore_create(0);
    for(int i = 0;i < 10;i++){
    dispatch_async(queue, ^{
        NSLog(@"0000%d-testThread:%@0000",i,[NSThread currentThread]);
            //dispatch_semaphore_wait(sig, DISPATCH_TIME_FOREVER);
            [weakSelf testUrl];
        
    });
    };
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(sig, DISPATCH_TIME_FOREVER);
        for(int i = 0;i < 10;i++){

            NSLog(@"%@",weakSelf.testList[i]);
            if(i!=9)
            dispatch_semaphore_wait(sig, DISPATCH_TIME_FOREVER);
        }

    });
    NSLog(@"------------主线程是：%@~~~~~~~~~~~~~",[NSThread currentThread]);
    
    //    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //            animation.keyPath = @"position";
    //            CGMutablePathRef path=CGPathCreateMutable();
    //            CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 100, 100));
    //            animation.path=path;
    //            CGPathRelease(path);
    //            animation.repeatCount=MAXFLOAT;
    //            animation.removedOnCompletion = NO;
    //            animation.fillMode = kCAFillModeForwards;
    //            animation.duration = 4.0f;
    //            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //            animation.delegate=self;
    //    [_circleView.layer addAnimation:animation forKey:nil];
    /*self.navigationItem.title = @"新页面";
     self.navigationController.navigationBar.translucent = YES;
     [[UINavigationBar appearance]setBarStyle:UIBarStyleDefault];
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     self.navigationController.navigationBar.barTintColor = [UIColor redColor];*/
    // Do any additional setup after loading the view.
    
    
    //    self.KVOdata = [[KVOTest alloc]init];
    //    [self.KVOdata addObserver:self
    //                  forKeyPath:@"num"
    //                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
    //                      context:nil];
    
    //    _KVObutton = [[UIButton alloc]initWithFrame:CGRectMake(_width/2-20, _height-30, 40, 20)];
    //    [_KVObutton setTitle:@"点击" forState:UIControlStateNormal];
    //    [_KVObutton addTarget:self action:@selector(changeNum:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:_KVObutton];
    
    
    //    while(![self.playUrl isEqual:nil]){
    //        NSLog(@"playURL=%@",_playUrl);
    //        [self audioPlay];
    //        break;;
    //    }
    
}


#pragma mark - 懒加载
-(void)setupSubViews{
    [self head];
    [self returnButton];
    [self circleView];
    [self playView];
    [self musicLable];
    [self toLikeButton];
}
-(MyView*)head{
    if(!_head){
        _head = [[MyView alloc]initWithFrame:CGRectMake(0, 40, _width, 50)];
        //_head.backgroundColor = [UIColor whiteColor];
        _head.lb1.text = self.musicName;
        _head.lb1.frame = CGRectMake(_width/4, 0, _width/2, 20);
        _head.lb1.textAlignment = NSTextAlignmentCenter;
        _head.lb1.font = [UIFont systemFontOfSize:18];
        _head.lb1.textColor = [UIColor whiteColor];
        _head.lb2.text = self.musicSinger;
        _head.lb2.frame = CGRectMake(_width/4, 25, _width/2, 15);
        _head.lb2.textAlignment = NSTextAlignmentCenter;
        _head.lb2.font = [UIFont systemFontOfSize:14];
        _head.lb2.textColor = [UIColor whiteColor];
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
        [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //_button1.backgroundColor = [UIColor whiteColor];
        [_returnButton addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_returnButton];
    }
    return  _returnButton;
}
-(UIButton*)toLikeButton{
    if(!_toLikeButton){
        _toLikeButton = [[UIButton alloc]initWithFrame:CGRectMake(_width-90, 55, 80, 20)];
        [_toLikeButton setTitle:@"我的" forState:UIControlStateNormal];
        [_toLikeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //_button1.backgroundColor = [UIColor whiteColor];
        [_toLikeButton addTarget:self action:@selector(toLikeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_toLikeButton];
    }
    return  _toLikeButton;
}
-(UIView*)circleView{
    if(!_circleView){
        _circleView = [[UIView alloc]initWithFrame:CGRectMake(40, 150, _width-80, _width-80)];
        _circleView.backgroundColor = [UIColor blackColor];
        UIImage *postImage =[UIImage imageNamed:@"cover"];
        UIImageView *circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 60, 200, 200)];
        circleImage.image = postImage;
        circleImage.layer.cornerRadius = circleImage.bounds.size.width/2;
        circleImage.layer.masksToBounds = YES;
        circleImage.center = CGPointMake(_circleView.bounds.size.width/2, _circleView.bounds.size.height/2);
        //    UIView *test= [[UIView alloc]initWithFrame:CGRectMake(60, 20, 20, 20)];
        //    test.backgroundColor = [UIColor whiteColor];
        //    [_circleView addSubview:test];
        [_circleView addSubview:circleImage];
        _circleView.layer.cornerRadius = _circleView.bounds.size.width/2;
        [self.view addSubview:_circleView];
    }
    return _circleView;
}
-(UILabel*)musicLable{
    if(!_musicLable){
        _musicLable = [[UILabel alloc]initWithFrame:CGRectMake(10, _height-300, _width-20, 30)];
        _musicLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_musicLable];
        //self.playUrl = [[NSURL alloc]init];
        //[self.view addSubview:_player];
        _musicLable.text = @"歌曲正在准备………………";
    }
    return _musicLable;
}
-(PlayView*)playView{
    if(!_playView){
        _playView = [[PlayView alloc]initWithFrame:CGRectMake(0, _height-180,_width , 150)];
        //进度条
        _playView.progressView.frame = CGRectMake(50, 50, _width-100, 20);
        _playView.progressView.progressTintColor = [UIColor whiteColor];
        //
        _playView.likeButton.frame = CGRectMake(_width/2-20, 5, 40, 40);
        [_playView.likeButton addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _playView.preButton.frame = CGRectMake(_width/6, 80, 40, 40);
        _playView.playBotton.frame = CGRectMake(_width/2-25, 70, 60, 60);
        _playView.pauseBotton.frame = CGRectMake(_width/2-25, 70, 60, 60);
        _playView.playBotton.hidden = YES;
        [_playView.pauseBotton setHidden:NO];
        [_playView.pauseBotton addTarget:self action:@selector(musicPause:) forControlEvents:UIControlEventTouchUpInside];
        [_playView.playBotton addTarget:self action:@selector(musicPause:) forControlEvents:UIControlEventTouchUpInside];
        _playView.nextButton.frame = CGRectMake(_width/6*5-40, 80, 40, 40);
        [_playView.nextButton addTarget:self action:@selector(musicNext:) forControlEvents:UIControlEventTouchUpInside];
        [_playView.preButton addTarget:self action:@selector(musicNext:) forControlEvents:UIControlEventTouchUpInside];
        _playView.currentTime.frame = CGRectMake(10, 40, 35, 20);
        _playView.currentTime.text = @"00:00";
        _playView.currentTime.font = [UIFont systemFontOfSize:12];
        _playView.currentTime.textAlignment = NSTextAlignmentCenter;
        _playView.currentTime.textColor = [UIColor whiteColor];
        _playView.totalTime.frame = CGRectMake(_width-45, 40, 35, 20);
        _playView.totalTime.text = @"00:00";
        _playView.totalTime.font = [UIFont systemFontOfSize:12];
        _playView.totalTime.textAlignment = NSTextAlignmentCenter;
        _playView.totalTime.textColor = [UIColor whiteColor];
        [self.view addSubview:_playView];
    }
    return _playView;
}
#pragma mark - 按钮事件
-(void)btn_click:(UIButton*) button{
    NSLog(@"按钮点击");
    NSLog(@"music = %@,singer = %@",_musicName,_musicSinger);
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)musicPause:(UIButton*)sender{
    //    [self.KVOdata changeNum:^int(int num) {
    //        return num*2+1;
    //    }];
    //播放转到暂停
    if(self.isPause == 0){
        [self.player pause];
        [self stopAnimation];
        [self.playView.pauseBotton setHidden:YES];
        [self.playView.playBotton setHidden:NO];
        //        UIImage *playImg = [UIImage imageNamed:@"musicPlay"];
        //        [self.playView.playBotton setImage:playImg forState:UIControlStateNormal];
        self.isPause = 1;
    }
    else{
        //暂停转向播放
        [self.player play];
        [self startAnimation];
        
        [self.playView.pauseBotton setHidden:NO];
        [self.playView.playBotton setHidden:YES];
        //        UIImage *playImg = [UIImage imageNamed:@"pause"];
        //        [self.playView.playBotton setImage:playImg forState:UIControlStateNormal];
        self.isPause = 0;
    }
    //    self.playView.playBotton.hidden = 0;
    //    self.playView.pauseBotton.hidden = !self.playView.pauseBotton.isHidden;
    NSLog(@"play = %d  pause = %d",self.playView.playBotton.isHidden,self.playView.pauseBotton.isHidden);
}
-(IBAction)musicNext:(UIButton*)sender{
    [self getMusicURL];
    [self startAnimation];
}
-(IBAction)likeBtnClick:(UIButton*)sender{
    self.playView.likeButton.selected = !self.playView.likeButton.isSelected;
    //    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).class);
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString* fileName = [path stringByAppendingPathComponent:@"likeMusic.plist"];
    
    if(self.playView.likeButton.selected){
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_musicName,@"likeMusicName",_musicSinger,@"likeMusicSinger", nil];
        
        [_likeMusicList addObject:dict];
        //NSLog(@"list:%@",_likeMusicList);
    }
    else{
        [_likeMusicList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([[obj objectForKey:@"likeMusicName"] isEqualToString:_musicName]){
                *stop = YES;
                [_likeMusicList removeObject:obj];
            }
        }];
        
    }
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if([fileManeger isWritableFileAtPath:fileName]){
        NSLog(@"filepath:%@---------isSelect:%u",fileName,self.playView.likeButton.isSelected);
        NSLog(@"可以写入");
    }
    if([_likeMusicList writeToFile:fileName atomically:YES]){
        NSLog(@"写入成功！！！");
    }
    NSLog(@"------------------------------------------------------");
    
}
-(IBAction)toLikeButtonClick:(UIButton*)sender{
    if(!_likeController){
        _likeController = [[LikeController alloc]init];
        _likeController.delegate = self;
        [self.likeController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        self.likeController.modalPresentationStyle = UIModalPresentationFullScreen;
        _likeController.musicName = _musicName;
        _likeController.musicSinger = _musicSinger;
    }
    else{
        _likeController.musicName = _musicName;
        _likeController.musicSinger = _musicSinger;
        [_likeController refresh];
    }
    
    
    [self.navigationController pushViewController:_likeController animated:YES];
}

#pragma mark - 代理实现
-(void)transformData:(NSMutableArray *)array{
    [self.likeMusicList removeAllObjects];
    [self.likeMusicList addObjectsFromArray:array];
    __weak typeof(self) weakSelf = self;
    weakSelf.playView.likeButton.selected = NO;
    [_likeMusicList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([[obj objectForKey:@"likeMusicName"] isEqualToString:_musicName]){
            *stop = YES;
            weakSelf.playView.likeButton.selected = YES;
        }
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - 动画
-(void)addAnimation{
    if(![self.circleView.layer animationForKey:@"rotation"]){
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        rotation.duration = 10;
        rotation.repeatCount = MAXFLOAT;
        rotation.autoreverses = NO;
        rotation.fromValue = [NSNumber numberWithFloat:0.f];
        rotation.toValue = [NSNumber numberWithFloat: M_PI*2];
        rotation.removedOnCompletion = NO;
        rotation.fillMode = kCAFillModeForwards;
        rotation.delegate = self;
        [_circleView.layer addAnimation:rotation forKey:@"rotationKey"];
        //NSLog(@"add方法又来啦～～～～～～～～～～～～");
    }
    //[self startAnimation];
}
-(void)startAnimation{
    // if([self.circleView.layer animationForKey:@"rotationKey"]){
    
    if(_circleView.layer.speed == 1){
        return;
    }
    NSLog(@"start!!!!!!!!!!!!!!!!!!!");
    _circleView.layer.speed = 1;
    _circleView.layer.beginTime = 0;
    CFTimeInterval pauseTime = _circleView.layer.timeOffset;
    _circleView.layer.timeOffset = 0;
    _circleView.layer.beginTime = [_circleView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    
    //    }else{
    //        NSLog(@"start = %@",[self.circleView.layer animationForKey:@"rotationKey"]);
    //        [self addAnimation];
    //    }
}
-(void)stopAnimation{
    if(_circleView.layer.speed == 0){
        return;
    }
    CFTimeInterval pauseTime = [_circleView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _circleView.layer.speed = 0;
    _circleView.layer.timeOffset = pauseTime;
}
#pragma mark - KVO尝试
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //    if([keyPath isEqualToString:@"num"] && object == self.KVOdata){
    //        NSLog(@"观察方法启动");
    //        self.KVOlabel1.text = [NSString stringWithFormat:@"num的旧值为：%@，num的新值为：%@",[change valueForKey:@"old"],[change valueForKey:@"new"]];
    //    }
    if([keyPath isEqualToString:@"status"] ){
        NSLog(@"观察方法启动");
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if(status == AVPlayerStatusReadyToPlay){
            self.musicLable.text = @"开始播放！";
            [self addAnimation];
            [self.player play];
            float total = CMTimeGetSeconds(self.songItem.duration);
            int min = total / 60;
            int sec = (int)total % 60;
            NSString* secStr;
            if(sec < 10){
                secStr = [NSString stringWithFormat:@"0%d",sec];
            }
            else{
                secStr = [NSString stringWithFormat:@"%d",sec];
            }
            self.playView.totalTime.text = [NSString stringWithFormat:@"0%d:%@",min,secStr];
            self.isPause = 0;
        }
        //        else if (status == AVPlayerStatusUnknown){
        //            self.musicLable.text = @"歌曲加载中…………";
        //        }
        
    }
    else if([keyPath isEqualToString:@"musicName"]){
        self.head.lb1.text = [change valueForKey:@"new"];
        self.head.lb2.text = self.musicSinger;
        __weak typeof(self) weakSelf = self;
        weakSelf.playView.likeButton.selected = NO;
        [_likeMusicList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([[obj objectForKey:@"likeMusicName"] isEqualToString:_musicName]){
                *stop = YES;
                weakSelf.playView.likeButton.selected = YES;
            }
        }];
        [self getMusicURL];
    }
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if(
//}

-(void)dealloc{
    
    //[self.KVOdata removeObserver:self forKeyPath:@"num" context:nil];
    [self.songItem removeObserver:self forKeyPath:@"status"];
    [self.player removeTimeObserver:_timeObserve];
    // NSLog(@"已删除");
    
}


#pragma mark - 网络
-(void)testUrl{
    NSURL *url = [NSURL URLWithString:@"https://anime-music.jijidown.com/api/v2/music"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"thisTread:%@",[NSThread currentThread]);
        [weakSelf.testList addObject: [[dict objectForKey:@"res"]objectForKey:@"play_url"]];
        dispatch_semaphore_signal(sig);
    }];
    [task resume];
}
-(void) getMusicURL{
    
    NSURL *url = [NSURL URLWithString:@"https://anime-music.jijidown.com/api/v2/music"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    //dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"请求失败");
        }
        else{
            NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
            NSLog(@"%ld",res.statusCode);
            
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",dict);
        NSLog(@"%@",[[dict objectForKey:@"res"] objectForKey:@"play_url"]);
        weakSelf.playUrl = [NSURL URLWithString:[[dict objectForKey:@"res"] objectForKey:@"play_url"]];
        NSLog(@"url=%@",self.playUrl);
        NSLog(@"------------task任务线程是：%@",[NSThread currentThread]);
        //dispatch_semaphore_signal(semaphore);
        [weakSelf audioPlay];
        NSLog(@"URL完成-----------------------");
    }];
    NSLog(@"------------URL函数线程是：%@",[NSThread currentThread]);
    [task resume];
    //    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //    [self audioPlay];
    self.musicLable.text = @"歌曲正在准备………………";
    
    
    //    [self.player play];
    //
}

#pragma mark - 音乐播放
-(void)audioPlay{
    //_playUrl = [NSURL URLWithString:@"https://anime-music-files.jijidown.com/5b84e57cb02de20882687989_128.mp3?t=1659445648&sign=B118428A4C41260F5A13C7411B60E61E"];
    _songItem = [[AVPlayerItem alloc]initWithURL:self.playUrl];
    _player = [[AVPlayer alloc]initWithPlayerItem:_songItem];
    [_songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"audioPlay方法启动");
    __weak typeof(self) weakSelf = self;
    _timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds(weakSelf.songItem.duration);
        int min = current / 60;
        int sec =(int) current % 60;
        NSString* secStr;
        if(sec < 10){
            secStr = [NSString stringWithFormat:@"0%d",sec];
        }
        else{
            secStr = [NSString stringWithFormat:@"%d",sec];
        }
        if(current){
            weakSelf.playView.progressView.progress = current/total;
            weakSelf.playView.currentTime.text = [NSString stringWithFormat:@"0%d:%@",min,secStr];
        }
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
-(void)playFinished:(NSNotification*)notification{
    self.musicLable.text = @"播放完毕";
    [self stopAnimation];
}
@end
