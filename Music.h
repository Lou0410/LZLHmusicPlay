//
//  music.h
//  project_2
//
//  Created by lizhi on 2022/7/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Music : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *singer;
@property (nonatomic,copy) NSString *musicId;
//@property (nonatomic,assign) bool isLike;
-(instancetype) initWithName:(NSString *)name andSinger:(NSString *)singer andMusicId:(NSString*) musicId;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
