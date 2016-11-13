//
//  PSYPlace.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@class PSYCategory;
@class PSYArea;

@interface PSYPlace : RLMObject
@property NSString      *name;
@property NSData        *picture;
@property NSNumber      *rate;
@property NSDate        *updatedDate;
@property PSYCategory   *category;
@property PSYArea       *area;
@end
RLM_ARRAY_TYPE(PSYPlace)
