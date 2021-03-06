//
//  PSYSearchInteractor.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSYSearchInteractorIO.h"

@class PSYPlaceDataManager;

@interface PSYSearchInteractor : NSObject <PSYSearchInteractorInput>

@property (nonatomic, weak) id<PSYSearchInteractorOutput> output;

- (instancetype)initDataManager:(PSYPlaceDataManager *)dataManager;

@end
