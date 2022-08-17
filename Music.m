//
//  music.m
//  project_2
//
//  Created by lizhi on 2022/7/25.
//

#import "Music.h"

@implementation Music

-(instancetype)initWithName:(NSString *)name andSinger:(NSString *)singer andMusicId:(NSString*) musicId{
    if(self =[super init]){
        self.name = name;
        self.singer = singer;
        self.musicId = musicId;
    }
    return  self;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

@end
