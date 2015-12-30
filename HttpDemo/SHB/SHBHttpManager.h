//
//  SHBHttpManager.h
//  HttpDemo
//
//  Created by 沈红榜 on 15/12/29.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSUInteger, SHBHttpType) {
    SHBHttpTypeLogin,
    SHBHttpTypeHome,
    SHBHttpTypePage,
};

typedef void(^Complete)(id object, NSError *error);

@interface SHBHttpManager : NSObject

+ (SHBHttpManager *)sharedmanager;

- (void)action:(SHBHttpType)action params:(id)params start:(dispatch_block_t)start complete:(Complete)complete;


@end
