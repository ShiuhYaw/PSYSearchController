//
//  PSYSearchTableViewController.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYBaseTableViewController.h"
#import "PSYSearchViewInterface.h"
#import "PSYSearchModuleInterface.h"

@interface PSYSearchTableViewController : PSYBaseTableViewController <PSYSearchViewInterface>

@property (nonatomic, strong) IBOutlet UIView *noContentView;
@property (nonatomic, strong) id<PSYSearchModuleInterface> eventHandler;
@property (strong, nonatomic) IBOutlet UIView *sortFilterView;

@end
