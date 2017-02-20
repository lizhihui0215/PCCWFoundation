//
//  PCCWListViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWListViewModel.h"
#import <UIKit/UIKit.h>


@implementation PCCWListViewModel
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

- (BOOL)isSelectedAtIndexPath:(NSIndexPath *)indexPath{
    return [self sectionItemAtIndexPath:indexPath].isSelected;
}

- (void)setSelected:(BOOL)selected atIndexPath:(NSIndexPath *)indexPath{
    [self sectionItemAtIndexPath:indexPath].selected = selected;;
}

- (NSMutableArray<PCCWSection *> *)indexedSectionsWithObjects:(NSArray<id> *)objects
                                                     filter:(NSPredicate * (^)(NSString *letter))filter{
    
    if (![objects lastObject]) return self.dataSource;
    
    NSMutableArray<PCCWSection *> *sections = [NSMutableArray array];
    
    NSArray *indexs = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", @"#"];
    
    NSInteger sectionIndex = 0;
    
    for (NSString *letter in indexs) {
        NSPredicate *predicate = filter(letter);
        
        NSMutableArray *filteredSection = [[objects filteredArrayUsingPredicate:predicate] mutableCopy];
        
        if ([filteredSection count]) {
            PCCWSection *section = [self indexedSectionWithLetter:letter
                                                   sectionIndex:sectionIndex
                                                          items:filteredSection];
            [sections addObject:section];
            sectionIndex ++;
        }
    }
    
    return sections;
}

- (PCCWSection *)indexedSectionWithLetter:(NSString *)letter
                           sectionIndex:(NSInteger)sectionIndex
                                  items:(NSArray<id> *)objects{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.sectionIndex.firstLetter = %@",letter];
    PCCWSection *section = [[self.dataSource filteredArrayUsingPredicate:predicate] firstObject];
    NSMutableArray <PCCWSectionItem *> *items = [self sectionItemsWithObjects:objects];
    
    if (!section) section =  [PCCWSection sectionWithInfo:nil
                                                  items:[NSMutableArray array]];
    
    section.info = [PCCWSectionIndex indexWithFirstLetter:letter
                                           sectionIndex:sectionIndex];
    
    [section.items addObjectsFromArray:items];
    
    return section;
}

- (NSMutableArray <PCCWSectionItem *> *)sectionItemsWithObjects:(NSArray<id> *)objects{
    NSMutableArray <PCCWSectionItem *> *sectionItems = [NSMutableArray array];
    for (id object in objects) {
        PCCWSectionItem *sectionItem = [PCCWSectionItem itemWithInfo:object selected:NO];
        [sectionItems addObject:sectionItem];
    }
    
    return sectionItems;
}

- (NSInteger)numberOfSections{
    return [self.delegate.dataSource count];
}

- (NSInteger)numberOfRowsInSection:(NSUInteger)sectionIndex{
    PCCWSection *section = self.delegate.dataSource[sectionIndex];
    return [section.items count];
}

- (PCCWSection *)sectionAt:(NSUInteger)section{
    return self.delegate.dataSource[section];
}

- (NSMutableArray <PCCWSectionItem *> *)sectionItemsAtSection:(NSUInteger)sectionIndex{
   return [self sectionAt:sectionIndex].items;
}

- (NSArray <PCCWSectionItem *> *)sectionItemsWithSelectedStatus:(BOOL)selectedStatus
                                                      atSection:(NSInteger)sectionIndex{
    PCCWSection *section = [self sectionAt:sectionIndex];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.isSelected == %@", @(selectedStatus)];
    return [section.items filteredArrayUsingPredicate:predicate];
}

- (void)deleteSelectedItemsAtSection:(NSInteger)sectionIndex{
    PCCWSection *section = [self sectionAt:sectionIndex];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.isSelected == YES"];
    
    NSArray *selectedItems = [section.items filteredArrayUsingPredicate:predicate];
    
    [section.items removeObjectsInArray:selectedItems];
}

- (PCCWSectionItem *)sectionItemAtIndexPath:(NSIndexPath *)indexPath{
    PCCWSection *section = [self sectionAt:indexPath.section];
    return section.items[indexPath.row];
}

- (NSIndexPath *)indexPathOfItem:(id)item{
    
    NSIndexPath *indexPath = nil;
    
    PCCWSectionItem *sectionItem = [PCCWSectionItem itemWithInfo:item selected:NO];
    
    for (PCCWSection *section in self.delegate.dataSource) {
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

@implementation PCCWSectionIndex

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

@implementation PCCWSection

+ (PCCWSection *)sectionWithInfo:(id)info items:(NSMutableArray<PCCWSectionItem *> *)items {
    return [[self alloc] initWithInfo:info items:items];
}

- (instancetype)initWithInfo:(id)info items:(NSMutableArray<PCCWSectionItem *> *)items
{
    self = [super init];
    if (self) {
        self.info = info;
        self.items = items;
    }
    return self;
}

- (nullable PCCWSectionIndex *)sectionIndex{
    return self.info;
}

- (BOOL)isEqual:(PCCWSection *)object{
    if (![object isMemberOfClass:[self class]]) return NO;
    
    if (self.items) return [self.items isEqualToArray:object.items];
    
    //default isEqual implementation
    return [super isEqual:object];
}


@end

@implementation PCCWSectionItem

+ (PCCWSectionItem *)itemWithInfo:(id)info selected:(BOOL)selected {
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

- (BOOL)isEqual:(PCCWSectionItem *)object{
    if (![object isMemberOfClass:[self class]]) return NO;
    
    if (self.info) return [self.info isEqual:object.info];
    
    //default isEqual implementation
    return [super isEqual:object];
}

- (NSComparisonResult)compare:(PCCWSectionItem *)other
{
    return [self.info compare:other.info];
}

@end
