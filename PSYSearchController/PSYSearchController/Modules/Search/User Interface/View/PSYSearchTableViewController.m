//
//  PSYSearchTableViewController.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYSearchTableViewController.h"
#import "PSYPlaceTableViewCell.h"
#import "PSYCategoryTableViewController.h"
#import "PSYSortTableViewController.h"

#pragma mark - UIStateRestoration
NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";
NSInteger const PSYNumberOfSection = 1;
CGFloat const PSYTableCellViewHeight = 200.0;

@interface PSYSearchTableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@property (nonatomic, strong) RLMResults    *places;
@property (nonatomic, strong) UITableView   *strongTableView;
@property (nonatomic, strong) PSYCategoryTableViewController   *categoryTableViewController;
@property (nonatomic, strong) PSYSortTableViewController   *sortTableViewController;
@property (nonatomic, strong) NSCompoundPredicate *finalCompoundPredicate;
@property (nonatomic, assign) BOOL isLaunched;
@end

@implementation PSYSearchTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLaunched = false;
    self.strongTableView = self.tableView;
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.strongTableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    self.searchController.dimsBackgroundDuringPresentation = false;
    self.searchController.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = true;
    self.tableView.tableHeaderView = self.sortFilterView;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (!self.isLaunched) {
        [self.eventHandler updateView];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return PSYNumberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rows = 0;
    if (self.places.count > 0) {
        rows = self.places.count;
    }
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return PSYTableCellViewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSYPlaceTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    PSYPlace *place = (PSYPlace *)[self.places objectAtIndex:indexPath.row];
    [self configureCell:cell forPlace:place];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:false];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - UISearchControllerDelegate
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
    self.navigationController.navigationBar.translucent = YES;
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    [self.eventHandler searchWithString:searchController.searchBar.text];
}

#pragma mark - UIStateRestoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    UISearchController *searchController = self.searchController;
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}


#pragma mark - PSYSearchViewInterface
- (void)showNoContentMessage {
    
    self.view = self.strongTableView;
    
}

- (void)showPlacesData:(RLMResults *)results {
    
    self.view = self.strongTableView;
    self.places = results;
    [self reloadPlaces];
}

- (void)reloadPlaces {
    
    [self.strongTableView reloadData];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.isLaunched = true;
    NSString *segueIdentifier = segue.identifier;
    if ([segueIdentifier isEqualToString:@"categorySegueIdentifier"]) {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = segue.destinationViewController;
            if ([navigationController.topViewController isKindOfClass:[PSYCategoryTableViewController class]]) {
                self.categoryTableViewController = (PSYCategoryTableViewController *)navigationController.topViewController;
            }
            else {
                return;
            }
            __weak typeof(self) welf = self;
            self.categoryTableViewController.category = ^(PSYCategory *category) {
                [welf.eventHandler updateViewWithPredicate:welf.finalCompoundPredicate category:category sortProperty:nil];
            };
        }
    }
    if ([segueIdentifier isEqualToString:@"sortSegueIdentifier"]) {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = segue.destinationViewController;
            if ([navigationController.topViewController isKindOfClass:[PSYSortTableViewController class]]) {
                self.sortTableViewController = (PSYSortTableViewController *)navigationController.topViewController;
            }
            else {
                return;
            }
            __weak typeof(self) welf = self;
            self.sortTableViewController.sortProperty = ^(NSString * sortProperty) {
                [welf.eventHandler updateViewWithSortProperty:sortProperty];
            };
        }
    }
}

@end
