
//
//  PCCWNetworkServices.m
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWNetworkServices.h"
static NSString * PCCWNetworkServicesBaseURL = @"";

static NSString * kError = @"";

static NSString * kErrorMessage = @"";

static NSString * kSuccess = @"";

static NSString * kFailure = @"";

static NSString * kResult = @"";

@implementation PCCWSOAPMethod


@end

@interface PCCWNetworkServices ()

@end

@implementation PCCWNetworkServices

+ (void)configServicesWithBaseURL:(NSString *)baseURL
                         errorKey:(NSString *)errorKey
                  errorMessageKey:(NSString *)errorMessageKey
                        resultKey:(NSString *)resultKey
                       successKey:(NSString *)successKey
                       failureKey:(NSString *)failureKey{
    PCCWNetworkServicesBaseURL = baseURL;
    kError = errorKey;
    kResult = resultKey;
    kSuccess = successKey;
    kFailure = failureKey;
    kErrorMessage = errorMessageKey;
}

+ (instancetype)defaultServices{
    static PCCWNetworkServices *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:PCCWNetworkServicesBaseURL]];
    });
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
    }
    return self;
}



- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             SOAPMethod:(PCCWSOAPMethod *)SOAPMethod
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    
    NSURLSessionDataTask *dataTask = [super POST:URLString
                                      parameters:parameters
                                        progress:uploadProgress
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             NSError *error = nil;
                                             id result = [self handleErrorWithReponseObject:responseObject error:&error];
                                             if(error) {failure(task, error); return ;};
                                             success(task, result);
                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                                             NSError *err = errorWithCode(error.code, description);
                                             if(error.code != NSURLErrorCancelled) failure(task, err);
                                         }];
    return dataTask;
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    NSURLSessionDataTask *dataTask = [super POST:URLString
                                      parameters:parameters
                                        progress:uploadProgress
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             NSError *error = nil;
                                             id result = [self handleErrorWithReponseObject:responseObject error:&error];
                                             if(error) {failure(task, error); return ;};
                                             success(task, result);
                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                                             NSError *err = errorWithCode(error.code, description);
                                             if(error.code != NSURLErrorCancelled) failure(task, err);
                                         }];
    return dataTask;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters
                     progress:(void (^)(NSProgress *))downloadProgress
                      success:(void (^)(NSURLSessionDataTask *, id))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    return [super GET:URLString
           parameters:parameters
             progress:downloadProgress
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSError *error = nil;
                  id result = [self handleErrorWithReponseObject:responseObject error:&error];
                  if(error) {failure(task, error); return ;};
                  success(task, result);
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                  NSError *err = errorWithCode(error.code, description);
                  if(error.code != NSURLErrorCancelled) failure(task, err);
              }];
}


- (id)handleErrorWithReponseObject:(NSMutableDictionary *)reponseObject error:(NSError **)error{
    
    if([reponseObject[kError] isEqualToString:kFailure]){
        if (error) *error = errorWithCode(0,
                                          reponseObject[kErrorMessage]);;
        return  nil;
    }
    
    return reponseObject[kResult];
}


@end
