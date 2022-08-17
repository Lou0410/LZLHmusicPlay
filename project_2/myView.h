//
//  myView.h
//  project_2
//
//  Created by lizhi on 2022/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UILabel *lb1;
@property (nonatomic,strong) UILabel *lb2;
@property (nonatomic,strong) UIImageView *rightImg;
-(void)createUI;
@end

NS_ASSUME_NONNULL_END
