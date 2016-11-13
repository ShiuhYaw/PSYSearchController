//
//  PSYCategory.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 13/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "PSYPlace.h"

@interface PSYCategory : RLMObject
@property NSString      *name;
@property RLMArray<PSYPlace *><PSYPlace> *places;
@end

