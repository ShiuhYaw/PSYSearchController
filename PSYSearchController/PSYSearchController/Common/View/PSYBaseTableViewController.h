//
//  PSYBaseTableViewController.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSYPlace;

extern NSString *const kCellIdentifier;


@interface PSYBaseTableViewController : UITableViewController

- (void)configureCell:(UITableViewCell *)cell forPlace:(PSYPlace *)place;

@end
