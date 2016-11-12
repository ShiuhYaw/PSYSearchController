//
//  PSYSearchWireframe.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PSYSearchPresenter;
@class PSYSearchTableViewController;
@class PSYRootWireframe;

@interface PSYSearchWireframe : NSObject

@property (nonatomic, strong) PSYSearchPresenter *searchPresenter;
@property (nonatomic, strong) PSYRootWireframe *rootWireframe;

- (void)presentSearchInterfaceFromWindow:(UIWindow *)window;

@end
