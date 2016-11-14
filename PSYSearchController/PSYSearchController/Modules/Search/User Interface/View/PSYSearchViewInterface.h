//
//  PSYSearchViewInterface.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSYSearchViewInterface <NSObject>

- (void)showNoContentMessage;
- (void)showPlacesData:(RLMResults *)results;
- (void)reloadPlaces;

@end
