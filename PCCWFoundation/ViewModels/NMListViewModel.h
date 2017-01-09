//
//  HMListViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "NMViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class NMSectionItem;
@class NMSection;
@class NMSectionIndex;

@protocol NMListViewModelProtocol <NSObject>

@property (nonatomic, strong, nullable) NSMutableArray<NMSection *> *dataSource;

@end

@interface NMSection : NSObject

@property (nonatomic, strong, nullable) id info;

@property (nonatomic, strong, nullable) NSMutableArray<NMSectionItem *> *items;

+ (NMSection *)sectionWithInfo:(nullable id)info
                         items:(nullable NSMutableArray<NMSectionItem *> *)items;

- (nullable NMSectionIndex *)sectionIndex;

@end

@interface NMSectionIndex : NSObject

@property (nonatomic, copy) NSString *firstLetter;

@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithFirstLetter:(NSString *)firstLetter sectionIndex:(NSInteger)sectionIndex;

+ (instancetype)indexWithFirstLetter:(NSString *)firstLetter sectionIndex:(NSInteger)sectionIndex;

@end

@interface NMSectionItem : NSObject

@property (nonatomic, strong, nullable) id info;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

+ (NMSectionItem *)itemWithInfo:(nullable id)info selected:(BOOL)selected;
@end

@interface NMListViewModel : NMViewModel<NMListViewModelProtocol>

@property (nonatomic, weak) id<NMListViewModelProtocol> delegate;

- (NSMutableArray<NMSection *> *)indexedSectionsWithObjects:(id)objects
                                                  filter:(NSPredicate * (^)(NSString *letter))filter;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSUInteger)sectionIndex;

- (NMSection *)sectionAt:(NSUInteger)section;

- (NSMutableArray <NMSectionItem *> *)sectionItemsAtSection:(NSUInteger)sectionIndex;

- (NMSectionItem *)sectionItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathOfItem:(id)item;

- (void)deleteSelectedItemsAtSection:(NSInteger)section;

- (NSMutableArray <NMSectionItem *> *)sectionItemsWithObjects:(NSArray<id> *)objects;

@end

NS_ASSUME_NONNULL_END
