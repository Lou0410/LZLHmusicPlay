//
//  myView.m
//  project_2
//
//  Created by lizhi on 2022/7/26.
//

#import "myView.h"

@implementation MyView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self createUI];
    }
    return  self;
}
-(void)createUI{
    //UIImage *img = [UIImage imageNamed:@"播放.jpeg"];
    _leftImg = [[UIImageView alloc]init];
    _leftImg.contentMode = UIViewContentModeScaleAspectFit;
    _leftImg.frame = CGRectMake(15, 5, 25, 25);
    [self addSubview:_leftImg];
    _lb1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 100,30)];
    //_lb1.text=@"播放所有歌曲";
    _lb1.font = [UIFont fontWithName:@"Heiti SC" size:14];
    //_lb1.textAlignment =
    
    // _lb1.backgroundColor = [UIColor redColor];
    [self addSubview:_lb1];
    _lb2 = [[UILabel alloc]init];
    [self addSubview:_lb2];
    _rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-40, 5, 25, 25)];
    _rightImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_rightImg];
}
@end
