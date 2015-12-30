# HttpDemo
封装常用的接口请求

## 配置
```object
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
```
