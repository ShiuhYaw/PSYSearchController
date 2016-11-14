//
//  PSYRootWireframe.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSYSearchModuleInterface.h"

@class PSYSearchTableViewController;

@interface PSYRootWireframe : NSObject

- (void)showRootViewController:(UIViewController *)viewController
                      inWindow:(UIWindow *)window;

@end
