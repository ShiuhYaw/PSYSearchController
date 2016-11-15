//
//  PSYPlace.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PSYCategory;

@interface PSYPlace : RLMObject
@property NSInteger      placeId;
@property NSString      *name;
@property NSString      *picture;
@property NSNumber<RLMInt> *rate;
@property NSDate        *updatedDate;
@property NSNumber<RLMFloat> *longitude;
@property NSNumber<RLMFloat> *latitude;
@property NSNumber<RLMFloat> *distance;
@property PSYCategory   *category;
@end
RLM_ARRAY_TYPE(PSYPlace)
