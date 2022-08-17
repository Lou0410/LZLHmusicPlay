//
//  myController.h
//  project_2
//
//  Created by lizhi on 2022/7/27.
//

#import <UIKit/UIKit.h>
#import "myView.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayView.h"
#import "LikeController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyController : UIViewController<CAAnimationDelegate,LikeControllerDelegate>
@property (nonatomic,strong) NSString* musicName;
@property (nonatomic,strong) NSString* musicSinger;
//-(NSString*) getMusicURL;
@end

NS_ASSUME_NONNULL_END
