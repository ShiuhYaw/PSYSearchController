//
//  PSYSearchWireframe.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSYRootWireframe;
@class PSYSearchPresenter;
@class PSYSearchTableViewController;

@interface PSYSearchWireframe : NSObject

@property (nonatomic, strong) PSYSearchPresenter *searchPresenter;
@property (nonatomic, strong) PSYRootWireframe *rootWireframe;

- (void)presentSearchInterfaceFromWindow:(UIWindow *)window;

@end
