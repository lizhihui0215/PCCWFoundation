//
//  PCCWMenuViewModel.m
//  NM
//
//  Created by 李智慧 on 23/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWMenuViewModel.h"

@interface PCCWMenuViewModel ()
{
    NSMutableArray<PCCWSection *> *_dataSource;
}

@property (nonatomic, strong) id<PCCWMenuViewModelProtocol> menuDataSource;

@end

@implementation PCCWMenuItem

- (instancetype)initWithImage:(UIImage *)image
                         name:(NSString *)name
              segueIdentifier:(NSString *)segueIdentifier{
    self = [super init];
    if (self) {
        self.image = image;
        self.name = name;
        self.segueIdentifier = segueIdentifier;
    }
    return self;
}

@end

@implementation PCCWMenuViewModel

- (NSMutableArray<PCCWSection *> *)dataSource{
    return _dataSource;
}

- (void)setDataSource:(NSMutableArray<PCCWSection *> *)dataSource{
    _dataSource = dataSource;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuDataSource = self;
        PCCWSection *section = [PCCWSection sectionWithInfo:nil
                                                  items:[self makeSectionItems]];
        
        [self.dataSource addObject:section];
    }
    return self;
}

- (void)reloadMenuItems{
    [self sectionAt:0].items = [self makeSectionItems];
}


- (NSMutableArray<PCCWSectionItem *> *)makeSectionItems {
    NSMutableArray<PCCWSectionItem *> *items = [NSMutableArray array];
    
    for (NSNumber *itemType in [self.menuDataSource items]) {
        UIImage *image = [self.menuDataSource itemImages][itemType];
        NSString *identifier = [self.menuDataSource segueIdentifiers][itemType];
        NSString *name = [self itemNames][itemType];
        PCCWMenuItem *item = [[PCCWMenuItem alloc] initWithImage:image
                                                        name:name
                                             segueIdentifier:identifier];
        PCCWSectionItem *sectionItem = [PCCWSectionItem itemWithInfo:item selected:NO];
        [items addObject:sectionItem];
    }
    
    return items;
}


- (PCCWMenuItem *)menuItemAtIndexPath:(NSIndexPath *)indexPath{
    PCCWSectionItem *item = [self sectionItemAtIndexPath:indexPath];
    return item.info;
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    return [self menuItemAtIndexPath:indexPath].image;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath {
    return [self menuItemAtIndexPath:indexPath].name;
}

- (NSString *)identifierAtIndexPath:(NSIndexPath *)indexPath {
    return [self menuItemAtIndexPath:indexPath].segueIdentifier;
}

- (NSDictionary <NSNumber *, NSString *> *)segueIdentifiers { return nil; }

- (NSDictionary<NSNumber *, UIImage *> *)itemImages { return nil; }

- (NSArray<NSNumber *> *)items { return nil; }

- (NSDictionary <NSNumber *, NSString *> *)itemNames { return nil; }

@end
