//
//  PSYSearchWireframe.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYSearchWireframe.h"
#import "PSYSearchPresenter.h"
#import "PSYSearchTableViewController.h"
#import "PSYRootWireframe.h"

static NSString *PSYSearchTableViewControllerIdentifier = @"PSYSearchTableViewController";

@interface PSYSearchWireframe()

@property (nonatomic, strong) PSYSearchTableViewController *searchTableViewController;
@end

@implementation PSYSearchWireframe


- (void)presentSearchInterfaceFromWindow:(UIWindow *)window {
    
    PSYSearchTableViewController *searchTableViewController = [self searchViewControllerFromStoryboard];
    searchTableViewController.eventHandler = self.searchPresenter;
    self.searchPresenter.userInterface = searchTableViewController;
    self.searchTableViewController = searchTableViewController;
    [self.rootWireframe showRootViewController:searchTableViewController inWindow:window];
}

- (PSYSearchTableViewController *)searchViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    PSYSearchTableViewController *viewController = (PSYSearchTableViewController *)[storyboard instantiateViewControllerWithIdentifier:PSYSearchTableViewControllerIdentifier];
    return viewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

@end
