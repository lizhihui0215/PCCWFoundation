//
//  NMViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NMViewModelCompleteHandler)(NSError * _Nullable error);

@interface NMViewModel : NSObject

@end

NS_ASSUME_NONNULL_END
