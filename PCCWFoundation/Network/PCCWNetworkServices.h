//
//  PCCWNetworkServices.h
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

@import AFNetworking;
#import "PCCWWebServiceReponseSerializer.h"
#import "PCCWWebServiceRequestSerializer.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, PCCWNetworkServicesType) {
    PCCWNetworkServicesTypeJSON,
    PCCWNetworkServicesTypeWebServices,
};

@interface PCCWSOAPMethod : NSObject

@property (nonatomic, copy) NSString *requestMethodName;

@property (nonatomic, copy) NSString *responseMethodName;

@property (nonatomic, copy) NSString *SOAPFilePath;

@end

@interface PCCWNetworkServices : AFHTTPSessionManager

@property (nonatomic, assign, readonly) PCCWNetworkServicesType servicesType;

+ (void)configServicesWithBaseURL:(NSString *)baseURL
                         errorKey:(NSString *)errorKey
                  errorMessageKey:(NSString *)errorMessageKey
                        resultKey:(NSString *)resultKey
                       successKey:(NSString *)successKey
                       failureKey:(NSString *)failureKey;

+ (instancetype)defaultServices;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             SOAPMethod:(PCCWSOAPMethod *)SOAPMethod
                             identifier:(NSString *)identifier
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
