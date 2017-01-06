//
//  NMSearchTableViewCell.h
//  NM
//
//  Created by 李智慧 on 04/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "NMTableViewCell.h"

@interface NMSearchTableViewCell : NMTableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *iconView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *subNameLabel;

@end
