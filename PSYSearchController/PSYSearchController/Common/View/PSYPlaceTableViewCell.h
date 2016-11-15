//
//  PSYPlaceTableViewCell.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 14/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HCSStarRatingView/HCSStarRatingView.h>

@class PSYGradientView;
@class PSYTopGradientView;

@interface PSYPlaceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet PSYTopGradientView *topGradientView;
@property (weak, nonatomic) IBOutlet PSYGradientView *gredientView;
@property (weak, nonatomic) IBOutlet UIView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIView *placeDetailTopView;
@property (weak, nonatomic) IBOutlet UIView *placeDetailBottomView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRateView;

@end
