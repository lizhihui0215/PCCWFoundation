//
//  NMSearchTableViewController.h
//  NM
//
//  Created by 李智慧 on 04/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "NMTableViewController.h"
#import "NMSearchViewModel.h"

@class NMSearchTableViewController;

@protocol NMSearchTableViewControllerProtocol <NSObject>

- (void)searchTableViewController:(NMSearchTableViewController *)tableView
                     didEndSearch:(id)result;

@end

@interface NMSearchTableViewController : NMTableViewController

@property (nonatomic ,strong)  NMSearchViewModel *viewModel;

@property (nonatomic, weak) id<NMSearchTableViewControllerProtocol> searchDelegate;

@end
