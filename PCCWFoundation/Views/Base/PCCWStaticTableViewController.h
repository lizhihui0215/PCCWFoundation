//
//  PCCWStaticTableViewController.h
//  PCCWFoundation
//
//  Created by 李智慧 on 09/10/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCCWLocalizedProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface PCCWStaticTableViewController : UITableViewController<PCCWLocalizedProtocol>

- (void)removeFooterView;
@end

NS_ASSUME_NONNULL_END
