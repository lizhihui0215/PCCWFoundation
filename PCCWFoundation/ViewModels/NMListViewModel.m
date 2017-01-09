//
//  NMListViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "NMListViewModel.h"
#import <UIKit/UIKit.h>


@implementation NMListViewModel
@dynamic dataSource;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (NSMutableArray<NMSection *> *)indexedSectionsWithObjects:(NSArray<id> *)objects
                                                     filter:(NSPredicate * (^)(NSString *letter))filter{
    
    if (![objects lastObject]) return self.dataSource;
    
    NSMutableArray<NMSection *> *sections = [NSMutableArray array];
    
    NSArray *indexs = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", @"#"];
    
    NSInteger sectionIndex = 0;
    
    for (NSString *letter in indexs) {
        NSPredicate *predicate = filter(letter);
        
        NSMutableArray *filteredSection = [[objects filteredArrayUsingPredicate:predicate] mutableCopy];
        
        if ([filteredSection count]) {
            NMSection *section = [self indexedSectionWithLetter:letter
                                                   sectionIndex:sectionIndex
                                                          items:filteredSection];
            [sections addObject:section];
            sectionIndex ++;
        }
    }
    
    return sections;
}

- (NMSection *)indexedSectionWithLetter:(NSString *)letter
                           sectionIndex:(NSInteger)sectionIndex
                                  items:(NSArray<id> *)objects{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.sectionIndex.firstLetter = %@",letter];
    NMSection *section = [[self.dataSource filteredArrayUsingPredicate:predicate] firstObject];
    NSMutableArray <NMSectionItem *> *items = [self sectionItemsWithObjects:objects];
    
    if (!section) section =  [NMSection sectionWithInfo:nil
                                                  items:[NSMutableArray array]];
    
    section.info = [NMSectionIndex indexWithFirstLetter:letter
                                           sectionIndex:sectionIndex];
    
    [section.items addObjectsFromArray:items];
    
    return section;
}

- (NSMutableArray <NMSectionItem *> *)sectionItemsWithObjects:(NSArray<id> *)objects{
    NSMutableArray <NMSectionItem *> *sectionItems = [NSMutableArray array];
    for (id object in objects) {
        NMSectionItem *sectionItem = [NMSectionItem itemWithInfo:object selected:NO];
        [sectionItems addObject:sectionItem];
    }
    
    return sectionItems;
}

- (NSInteger)numberOfSections{
    return [self.delegate.dataSource count];
}

- (NSInteger)numberOfRowsInSection:(NSUInteger)sectionIndex{
    NMSection *section = self.delegate.dataSource[sectionIndex];
    return [section.items count];
}

- (NMSection *)sectionAt:(NSUInteger)section{
    return self.delegate.dataSource[section];
}

- (NSMutableArray <NMSectionItem *> *)sectionItemsAtSection:(NSUInteger)sectionIndex{
   return [self sectionAt:sectionIndex].items;
}

- (void)deleteSelectedItemsAtSection:(NSInteger)sectionIndex{
    NMSection *section = [self sectionAt:sectionIndex];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.isSelected == YES"];
    
    NSArray *selectedItems = [section.items filteredArrayUsingPredicate:predicate];
    
    [section.items removeObjectsInArray:selectedItems];
}

- (NMSectionItem *)sectionItemAtIndexPath:(NSIndexPath *)indexPath{
    NMSection *section = [self sectionAt:indexPath.section];
    return section.items[indexPath.row];
}

- (NSIndexPath *)indexPathOfItem:(id)item{
    
    NSIndexPath *indexPath = nil;
    
    NMSectionItem *sectionItem = [NMSectionItem itemWithInfo:item selected:NO];
    
    for (NMSection *section in self.delegate.dataSource) {
        NSInteger index = [section.items indexOfObject:sectionItem];
        if(index != NSNotFound){
            NSInteger sectionIndex = [self.delegate.dataSource indexOfObject:section];
            indexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
            break;
        }
    }
    
    return indexPath;
}

@end

@implementation NMSectionIndex

- (instancetype)initWithFirstLetter:(NSString *)firstLetter sectionIndex:(NSInteger)sectionIndex {
    self = [super init];
    if (self) {
        self.firstLetter = firstLetter;
        self.index = sectionIndex;
    }

    return self;
}

+ (instancetype)indexWithFirstLetter:(NSString *)firstLetter sectionIndex:(NSInteger)sectionIndex {
    return [[self alloc] initWithFirstLetter:firstLetter sectionIndex:sectionIndex];
}


@end

@implementation NMSection

+ (NMSection *)sectionWithInfo:(id)info items:(NSMutableArray<NMSectionItem *> *)items {
    return [[self alloc] initWithInfo:info items:items];
}

- (instancetype)initWithInfo:(id)info items:(NSMutableArray<NMSectionItem *> *)items
{
    self = [super init];
    if (self) {
        self.info = info;
        self.items = items;
    }
    return self;
}

- (nullable NMSectionIndex *)sectionIndex{
    return self.info;
}

- (BOOL)isEqual:(NMSection *)object{
    if (![object isMemberOfClass:[self class]]) return NO;
    
    if (self.items) return [self.items isEqualToArray:object.items];
    
    //default isEqual implementation
    return [super isEqual:object];
}


@end

@implementation NMSectionItem

+ (NMSectionItem *)itemWithInfo:(id)info selected:(BOOL)selected {
    return [[self alloc] initWithInfo:info selected:selected];
}

- (instancetype)initWithInfo:(id)info selected:(BOOL)selected
{
    self = [super init];
    if (self) {
        self.info = info;
        self.selected = selected;
    }
    return self;
}

- (BOOL)isEqual:(NMSectionItem *)object{
    if (![object isMemberOfClass:[self class]]) return NO;
    
    if (self.info) return [self.info isEqual:object.info];
    
    //default isEqual implementation
    return [super isEqual:object];
}

@end
