//
//  ViewController.m
//  HttpDemo
//
//  Created by 沈红榜 on 15/12/29.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "ViewController.h"
#import "SHBHttpManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SHBHttpManager *manager = [SHBHttpManager sharedmanager];
    //登陆
    [manager action:SHBHttpTypeLogin params:@{@"username" : @"Jim", @"pwd" : @"12345"} start:^{
        //  请求开始
        //  可以弄个菊花在这转哪转
    } complete:^(id object, NSError *error) {
        //  如果有菊花，不能忘了在这停止
        if (error) {
            
        } else {
            
        }
    }];
    
    
    // 主页
    [manager action:SHBHttpTypeHome params:@{@"home" : @"hhhome"} start:^{
        
    } complete:^(id object, NSError *error) {
        
    }];
    
    //分页
    [manager action:SHBHttpTypePage params:@{@"page" : @0} start:^{
        
    } complete:^(id object, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
