//
//  HMListViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PCCWSectionItem;
@class PCCWSection;
@class PCCWSectionIndex;

@protocol PCCWListViewModelProtocol <NSObject>

@property (nonatomic, strong, nullable) NSMutableArray<PCCWSection *> *dataSource;

@end

@interface PCCWSection : NSObject

@property (nonatomic, strong, nullable) id info;

@property (nonatomic, strong, nullable) NSMutableArray<PCCWSectionItem *> *items;

+ (PCCWSection *)sectionWithInfo:(nullable id)info
                         items:(nullable NSMutableArray<PCCWSectionItem *> *)items;

- (nullable PCCWSectionIndex *)sectionIndex;

@end

@interface PCCWSectionIndex : NSObject

@property (nonatomic, copy) NSString *firstLetter;

@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithFirstLetter:(NSString *)firstLetter sectionIndex:(NSInteger)sectionIndex;

+ (instancetype)indexWithFirstLetter:(NSString *)firstLetter sectionIndex:(NSInteger)sectionIndex;

@end

@interface PCCWSectionItem : NSObject

@property (nonatomic, strong, nullable) id info;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

+ (PCCWSectionItem *)itemWithInfo:(nullable id)info selected:(BOOL)selected;
@end

@interface PCCWListViewModel : PCCWViewModel<PCCWListViewModelProtocol>

@property (nonatomic, weak) id<PCCWListViewModelProtocol> delegate;

- (NSMutableArray<PCCWSection *> *)indexedSectionsWithObjects:(id)objects
                                                  filter:(NSPredicate * (^)(NSString *letter))filter;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSUInteger)sectionIndex;

- (PCCWSection *)sectionAt:(NSUInteger)section;

- (NSMutableArray <PCCWSectionItem *> *)sectionItemsAtSection:(NSUInteger)sectionIndex;

- (PCCWSectionItem *)sectionItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathOfItem:(id)item;

- (void)deleteSelectedItemsAtSection:(NSInteger)section;

- (NSMutableArray <PCCWSectionItem *> *)sectionItemsWithObjects:(NSArray<id> *)objects;

@end

NS_ASSUME_NONNULL_END
