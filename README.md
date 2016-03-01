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

# 上传 附件
```object
            [[CRHttpClient instance] post:[NSString stringWithFormat:@"doctor/%@",[self urls][CNDUserActionTypeFeedrtf]] params:dic formData:^(id<AFMultipartFormData> formData) {
                
                [medias enumerateObjectsUsingBlock:^(CRDAttachment * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    switch (obj.type) {
                        case CRDAttachmentTypeImage: {
                            UIImage *ori = obj.originalImage;
                            CGFloat aspc = 0.f;
                            if (ori.size.width>2000) {
                                aspc = 0.4;
                            }else if(ori.size.width>1000 && ori.size.width < 2000){
                                aspc = 0.6;
                            }else {
                                aspc = 1;
                            }
                            NSData *imageData = UIImageJPEGRepresentation(ori, 1);
                            NSString *mimeType = [NSData sd_contentTypeForImageData:imageData];
                            NSString *sub = [[mimeType componentsSeparatedByString:@"/"] lastObject];
                            
                            /**
                             *   禁用 gif 图片
                             */
                            if ([sub isEqualToString:@"gif"]) {
                                sub = @"jpeg";
                                mimeType = [mimeType stringByReplacingOccurrencesOfString:@"gif" withString:@"jpeg"];
                            }
                            
                            [formData appendPartWithFileData:UIImageJPEGRepresentation([ori resizedImageByWidth:ori.size.width * aspc], 1) name:@"att[]" fileName:[NSString stringWithFormat:@"file_%0.0fx%0.0f.%@",ori.size.width,ori.size.height, sub] mimeType:mimeType];
                            break;
                        }
                        case CRDAttachmentTypeVoice: {
                            
                            [formData appendPartWithFileData:[NSData dataWithContentsOfURL:[NSURL URLWithString:obj.realUrl]] name:@"att[]" fileName:@"file.mp3" mimeType:@"audio/mp3"];
                            break;
                        }
                        case CRDAttachmentTypeVideo: {
                            [formData appendPartWithFileData:[NSData dataWithContentsOfURL:[NSURL URLWithString:obj.realUrl]] name:@"att[]" fileName:@"file.mp4" mimeType:@"video/mp4"];
                            break;
                        }
                    }
                    
                }];
            } complete:^(id object, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(object, error);
                });
            }];

```
