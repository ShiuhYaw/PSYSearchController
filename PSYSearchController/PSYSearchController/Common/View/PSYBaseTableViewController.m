//
//  PSYBaseTableViewController.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYBaseTableViewController.h"
#import "PSYPlace.h"
#import "PSYCategory.h"
#import "PSYPlaceTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <MapKit/MapKit.h>

NSString *const kCellIdentifier = @"PSYPlaceTableViewCell";

@interface PSYBaseTableViewController ()
@property(nonatomic, strong) MKDistanceFormatter *df;

@end

@implementation PSYBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.df = [[MKDistanceFormatter alloc]init];
    self.df.unitStyle = MKDistanceFormatterUnitStyleAbbreviated;
    [self.tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(UITableViewCell *)cell forPlace:(PSYPlace *)place {
    
    PSYPlaceTableViewCell *currentCell = (PSYPlaceTableViewCell *)cell;
    currentCell.rateLabel.text = [place.rate stringValue];
    currentCell.titleLabel.text = place.name;
    currentCell.categoryLabel.text = place.category.name;
    NSString *prettyString = [self.df stringFromDistance:place.distance.floatValue];
    currentCell.distanceLabel.text = prettyString;
    NSURL *url = [NSURL URLWithString:place.picture];
    [currentCell.placeImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    currentCell.starRateView.value = place.rate.floatValue;
    currentCell.areaLabel.text = @"";
}

@end

