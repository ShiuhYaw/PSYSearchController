//
//  PSYCategoryTableViewController.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 15/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSYCategory;

typedef void(^PSYCategoryCompletionBlock)(PSYCategory *results);


@interface PSYCategoryTableViewController : UITableViewController

@property (nonatomic, strong) PSYCategoryCompletionBlock category;
@end
