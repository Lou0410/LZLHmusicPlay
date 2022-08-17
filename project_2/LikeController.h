//
//  LikeController.h
//  project_2
//
//  Created by lizhi on 2022/8/5.
//

#import <UIKit/UIKit.h>
#import "myView.h"
#import "myTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol LikeControllerDelegate <NSObject>

-(void)transformData:(NSMutableArray*)array;

@end
@interface LikeController : UIViewController<UITableViewDataSource,UITableViewDelegate,MyCellDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) MyView* bottom;
@property (nonatomic,strong) NSMutableArray* likeMusicList;
@property (nonatomic,weak) id<LikeControllerDelegate> delegate;
@property (nonatomic,strong) NSString* musicName;
@property (nonatomic,strong) NSString* musicSinger;
-(void)refresh;
@end

NS_ASSUME_NONNULL_END
