//
//  NMMenuViewModel.m
//  NM
//
//  Created by 李智慧 on 23/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "NMMenuViewModel.h"

@interface NMMenuViewModel ()
{
    NSMutableArray<NMSection *> *_dataSource;
}

@property (nonatomic, strong) id<NMMenuViewModelProtocol> menuDataSource;

@end

@implementation NMMenuItem

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

@implementation NMMenuViewModel

- (NSMutableArray<NMSection *> *)dataSource{
    return _dataSource;
}

- (void)setDataSource:(NSMutableArray<NMSection *> *)dataSource{
    _dataSource = dataSource;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuDataSource = self;
        NMSection *section = [NMSection sectionWithInfo:nil
                                                  items:[self makeSectionItems]];
        
        [self.dataSource addObject:section];
    }
    return self;
}

- (NSMutableArray<NMSectionItem *> *)makeSectionItems {
    NSMutableArray<NMSectionItem *> *items = [NSMutableArray array];
    
    for (NSNumber *itemType in [self.menuDataSource items]) {
        UIImage *image = [self.menuDataSource itemImages][itemType];
        NSString *identifier = [self.menuDataSource segueIdentifiers][itemType];
        NSString *name = [self itemNames][itemType];
        NMMenuItem *item = [[NMMenuItem alloc] initWithImage:image
                                                        name:name
                                             segueIdentifier:identifier];
        NMSectionItem *sectionItem = [NMSectionItem itemWithInfo:item selected:NO];
        [items addObject:sectionItem];
    }
    
    return items;
}


- (NMMenuItem *)menuItemAtIndexPath:(NSIndexPath *)indexPath{
    NMSectionItem *item = [self sectionItemAtIndexPath:indexPath];
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
