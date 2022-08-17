//
//  KVOTest.h
//  project_2
//
//  Created by lizhi on 2022/8/1.
//

#import <Foundation/Foundation.h>
typedef int (^blockTest)(int num);
NS_ASSUME_NONNULL_BEGIN

@interface KVOTest : NSObject
@property (nonatomic,assign) int num;
-(void) changeNum:(blockTest) block1;
@end

NS_ASSUME_NONNULL_END
