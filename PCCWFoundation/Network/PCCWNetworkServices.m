
//
//  PCCWNetworkServices.m
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWNetworkServices.h"
static NSString * PCCWNetworkServicesBaseURL = @"http://www.webxml.com.cn";

static NSString * kError = @"";

static NSString * kErrorMessage = @"";

static NSString * kSuccess = @"";

static NSString * kFailure = @"";

static NSString * kResult = @"";

@implementation PCCWSOAPMethod


@end

@interface PCCWNetworkServices ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *dataTaskIdentifiers;

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
        self.dataTaskIdentifiers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)cancelDataTasksWithPredicate:(NSPredicate *)predicate{
    NSArray *keys = [self.dataTaskIdentifiers.allKeys filteredArrayUsingPredicate:predicate];
    
    NSMutableArray *values = [NSMutableArray array];
    
    for (NSString *key in keys) {
        NSNumber *taskIdentifier = self.dataTaskIdentifiers[key];
        [values addObject:taskIdentifier];
    }
    NSArray *dataTasks = [[self dataTasks] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.taskIdentifier IN %@", values]];
    
    [dataTasks makeObjectsPerformSelector:@selector(cancel)];
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             SOAPMethod:(PCCWSOAPMethod *)SOAPMethod
                             identifier:(NSString *)identifier
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
            
    NSURLSessionDataTask *dataTask = [super POST:URLString
                                      parameters:parameters
                                        progress:uploadProgress
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             self.dataTaskIdentifiers[identifier] = nil;
                                             NSError *error = nil;
                                             id result = [self handleErrorWithReponseObject:responseObject error:&error];
                                             if(error) {failure(task, error); return ;};
                                             success(task, result);
                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             self.dataTaskIdentifiers[identifier] = nil;
                                             NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                                             NSError *err = errorWithCode(error.code, description);
                                             if(error.code != NSURLErrorCancelled) failure(task, err);
                                         }];
    self.dataTaskIdentifiers[identifier] = @(dataTask.taskIdentifier);
    return dataTask;
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             identifier:(NSString *)identifier
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    
    NSURLSessionDataTask *dataTask = [super POST:URLString
                                      parameters:parameters
                                        progress:uploadProgress
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             self.dataTaskIdentifiers[identifier] = nil;
                                             NSError *error = nil;
                                             id result = [self handleErrorWithReponseObject:responseObject error:&error];
                                             if(error) {failure(task, error); return ;};
                                             success(task, result);
                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             self.dataTaskIdentifiers[identifier] = nil;
                                             NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                                             NSError *err = errorWithCode(error.code, description);
                                             if(error.code != NSURLErrorCancelled) failure(task, err);
                                         }];
    self.dataTaskIdentifiers[identifier] = @(dataTask.taskIdentifier);
    return dataTask;
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
