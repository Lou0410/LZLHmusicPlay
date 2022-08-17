//
//  PlayView.m
//  project_2
//
//  Created by lizhi on 2022/8/3.
//

#import "PlayView.h"

@implementation PlayView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self createUI];
    }
    return self;
}

-(void)createUI{
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(30, 50, 300, 20)];
    [self addSubview:_progressView];
    _preButton = [[UIButton alloc]initWithFrame:CGRectMake(70, 80, 30, 30)];
    UIImage *preImg = [UIImage imageNamed:@"pre"];
    //UIImageView *preImgView = [[UIImageView alloc]initWithImage:preImg];
    //preImg.resizingMode =
    [_preButton setImage:preImg forState:UIControlStateNormal];
    [self addSubview:_preButton];
    UIImage *playImg = [UIImage imageNamed:@"musicPlay"];
    _playBotton = [[UIButton alloc]init];
    [_playBotton setImage:playImg forState:UIControlStateNormal];
    [self addSubview:_playBotton];
    UIImage *pauseImg = [UIImage imageNamed:@"pause"];
    _pauseBotton = [[UIButton alloc]init];
    [_pauseBotton setImage:pauseImg forState:UIControlStateNormal];
    [self addSubview:_pauseBotton];
    UIImage *nextImg = [UIImage imageNamed:@"next"];
    _nextButton = [[UIButton alloc]init];
    [_nextButton setImage:nextImg forState:UIControlStateNormal];
    [self addSubview:_nextButton];
    _currentTime = [[UILabel alloc]init];
    _totalTime = [[UILabel alloc]init];
    [self addSubview:_currentTime];
    [self addSubview:_totalTime];
    _likeButton = [[UIButton alloc]init];
    UIImage *unlikeImg = [UIImage imageNamed:@"unlike"];
    UIImage *likeImg = [UIImage imageNamed:@"like"];
    [_likeButton setImage:unlikeImg forState: UIControlStateNormal];
    [_likeButton setImage:likeImg forState:UIControlStateSelected];
    [self addSubview:_likeButton];
    
}
@end
