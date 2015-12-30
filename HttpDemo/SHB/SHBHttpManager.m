//
//  SHBHttpManager.m
//  HttpDemo
//
//  Created by 沈红榜 on 15/12/29.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "SHBHttpManager.h"

static NSString *baseUrl = @"http://192.168.1.1";

@interface SHBHttpManager ()

@property (nonatomic, strong) NSArray      *urls;

@end

@implementation SHBHttpManager {
    AFHTTPSessionManager    *_manager;
}

+ (SHBHttpManager *)sharedmanager {
    static SHBHttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SHBHttpManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 30;
        config.timeoutIntervalForResource = 30;
        
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:config];
        
        
        /*
        //  api 版本号
         [_manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"api_version"];
        //  添加https 证书
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        policy.allowInvalidCertificates = true;
        policy.validatesDomainName = true;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ssl_pro" ofType:@"cer"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        policy.pinnedCertificates = [NSSet setWithObject:data];
        _manager.securityPolicy = policy;
        */
        
        
    }
    return self;
}

- (void)post:(NSString *)path params:(NSDictionary *)dic complete:(Complete)complete {
    
    [_manager POST:path parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil, error);
    }];
    
}

- (void)action:(SHBHttpType)action params:(id)params start:(dispatch_block_t)start complete:(Complete)complete {
    start();
    [self post:self.urls[action] params:params complete:^(id object, NSError *error) {
        complete(object, error);
    }];
    
}


- (NSArray *)urls {
    return @[
             @"login",
             @"home",
             @"page",
             
             ];
}


@end
