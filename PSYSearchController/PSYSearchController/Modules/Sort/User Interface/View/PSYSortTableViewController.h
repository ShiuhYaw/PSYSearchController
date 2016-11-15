//
//  PSYSortTableViewController.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 15/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PSYSortCompletionBlock)(NSString *results);

@interface PSYSortTableViewController : UITableViewController

@property (nonatomic, strong) PSYSortCompletionBlock sortProperty;
@end
