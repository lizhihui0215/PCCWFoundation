//
//  PCCWMenuViewModel.h
//  NM
//
//  Created by 李智慧 on 23/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PCCWMenuViewModelProtocol <NSObject>

- (NSDictionary <NSNumber *, NSString *> *)segueIdentifiers;

- (NSDictionary<NSNumber *, UIImage *> *)itemImages;

- (NSArray<NSNumber *> *)items;

- (NSDictionary <NSNumber *, NSString *> *)itemNames;

@end

@interface PCCWMenuItem : NSObject

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *segueIdentifier;

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithImage:(UIImage *)image
                         name:(NSString *)name
              segueIdentifier:(NSString *)segueIdentifier;

@end


@interface PCCWMenuViewModel : PCCWListViewModel<PCCWMenuViewModelProtocol>

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)identifierAtIndexPath:(NSIndexPath *)indexPath;

- (PCCWMenuItem *)menuItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
