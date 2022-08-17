//
//  myTableViewCell.m
//  project_2
//
//  Created by lizhi on 2022/7/25.
//

#import "myTableViewCell.h"
#import "Music.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)btnClick:(UIButton *) btn {
    NSLog(@"触发代理时间");
    if ([_delegate respondsToSelector:@selector(myCellBtnClick: incell:)]){
        btn.tag=self.tag;
        [_delegate myCellBtnClick:btn incell:self];
    }
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //int i= self.frame.size.height;
    if(self){
        //self.backgroundColor = [UIColor redColor];
        _btnType = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width-70, 0, 50, 55)];
        //btn.backgroundColor =[UIColor blueColor];
        //NSLog(@"cell宽度：%f",self.contentView.bounds.size.width-70);
        //        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_btnType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_btnType setTitle:@"点击" forState:UIControlStateNormal];
        [_btnType addTarget:self action:@selector(btnClick: ) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_btnType];
    }
    return  self;
}

- (void)setMusic:(Music *)music {
    _music = music;
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
}

@end
