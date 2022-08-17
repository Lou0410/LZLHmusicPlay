//
//  myTableViewCell.h
//  project_2
//
//  Created by lizhi on 2022/7/25.
//

#import <UIKit/UIKit.h>
@class Music;
@class MyTableViewCell;

NS_ASSUME_NONNULL_BEGIN
@protocol MyCellDelegate<NSObject>

-(void)myCellBtnClick:(UIButton*)btn incell:(MyTableViewCell*) cell;

@end

@interface MyTableViewCell : UITableViewCell
@property (nonatomic,strong) UIButton* btnType;
@property (weak, nonatomic) id<MyCellDelegate> delegate;
-(void)btnClick:(UIButton *) btn ;

@property (nonatomic, strong) Music *music;
@end

NS_ASSUME_NONNULL_END
