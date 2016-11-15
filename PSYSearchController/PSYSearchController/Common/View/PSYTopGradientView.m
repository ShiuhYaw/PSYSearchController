//
//  PSYTopGradientView.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 15/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYTopGradientView.h"

@implementation PSYTopGradientView


+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self configureGradientLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self configureGradientLayer];
    }
    return self;
}

// Make custom configuration of your gradient here
- (void)configureGradientLayer {
    CAGradientLayer *gLayer = (CAGradientLayer *)self.layer;
    gLayer.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor], (id)[[UIColor clearColor ] CGColor], nil];
}


@end
