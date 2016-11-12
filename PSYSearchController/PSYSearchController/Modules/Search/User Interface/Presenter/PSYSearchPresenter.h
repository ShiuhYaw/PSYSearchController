//
//  PSYSearchPresenter.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSYSearchModuleInterface.h"
#import "PSYSearchInteractorIO.h"
#import "PSYSearchWireframe.h"

@interface PSYSearchPresenter : NSObject <PSYSearchInteractorOutput, PSYSearchModuleInterface>

@property (nonatomic, strong) id<PSYSearchInteractorInput> searchInteractor;
@property (nonatomic, strong) PSYSearchWireframe *searchWireframe;

@end
