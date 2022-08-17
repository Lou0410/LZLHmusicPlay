//
//  SampleProtocol.h
//  project_2
//
//  Created by lizhi on 2022/7/21.
//


#import <Foundation/Foundation.h>

@class SampleProtocol;
@protocol SampleProtocolDelegate<NSObject>
@required
-(void) SampleProtocol:(SampleProtocol*) sample showDelegate:(NSString*) content;
@end


@interface SampleProtocol : NSObject
@property (nonatomic, weak) id<SampleProtocolDelegate> delegate;

@end
