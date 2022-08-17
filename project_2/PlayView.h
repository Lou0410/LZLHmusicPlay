//
//  PlayView.h
//  project_2
//
//  Created by lizhi on 2022/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayView : UIView
@property (nonatomic,strong) UIProgressView* progressView;
@property (nonatomic,strong) UIButton* preButton;
@property (nonatomic,strong) UIButton* nextButton;
@property (nonatomic,strong) UIButton* playBotton;
@property (nonatomic,strong) UIButton* pauseBotton;
@property (nonatomic,strong) UILabel* currentTime;
@property (nonatomic,strong) UILabel* totalTime;
@property (nonatomic,strong) UIButton* likeButton;
@end

NS_ASSUME_NONNULL_END
