//
//  KVOTest.m
//  project_2
//
//  Created by lizhi on 2022/8/1.
//

#import "KVOTest.h"

@implementation KVOTest
-(void)changeNum:(blockTest)block1{
    self.num = block1(self.num);
}
@end
