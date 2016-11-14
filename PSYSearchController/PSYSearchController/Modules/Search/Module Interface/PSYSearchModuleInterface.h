//
//  PSYSearchModuleInterface.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PSYCategory;

@protocol PSYSearchModuleInterface <NSObject>

- (void)updateView;
- (void)updateViewWithPredicate:(NSPredicate *)predicate category:(PSYCategory *)givenCategory sortProperty:(NSString *)sortProperty;
- (void)addPlace;

@end
