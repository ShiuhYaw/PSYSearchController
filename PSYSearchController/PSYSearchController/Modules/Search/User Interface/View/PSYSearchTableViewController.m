//
//  PSYSearchTableViewController.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYSearchTableViewController.h"
#import "PSYPlaceTableViewCell.h"


@interface PSYSearchTableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@property (nonatomic, strong) RLMResults    *places;
@property (nonatomic, strong) UITableView   *strongTableView;
@end

@implementation PSYSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strongTableView = self.tableView;
    [self configureView];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.strongTableView.tableHeaderView = self.searchController.searchBar;
    self.strongTableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
//    self.definesPresentationContext = YES;

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
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

- (void)configureView {
    
    self.navigationItem.title = @"Places";
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rows = 0;
    if (self.places.count > 0) {
        rows = self.places.count;
    }
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200.0;
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
    
    
    NSString *searchText = searchController.searchBar.text;
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    for (NSString *searchString in searchItems) {
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        // name field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"name"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        // yearIntroduced field matching
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterNoStyle;
        NSNumber *targetNumber = [numberFormatter numberFromString:searchString];
        if (targetNumber != nil) {
            // rate field matching
            lhs = [NSExpression expressionForKeyPath:@"rate"];
            rhs = [NSExpression expressionForConstantValue:targetNumber];
            finalPredicate = [NSComparisonPredicate
                              predicateWithLeftExpression:lhs
                              rightExpression:rhs
                              modifier:NSDirectPredicateModifier
                              type:NSEqualToPredicateOperatorType
                              options:NSCaseInsensitivePredicateOption];
            [searchItemsPredicate addObject:finalPredicate];
        }
        
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    [self.eventHandler updateViewWithPredicate:finalCompoundPredicate
                                      category:nil
                                  sortProperty:nil];
}

#pragma mark - UIStateRestoration
NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}


#pragma mark - PSYSearchViewInterface
- (void)showNoContentMessage {

    self.view = self.noContentView;
}

- (void)showPlacesData:(RLMResults *)results {
    
    self.view = self.strongTableView;
    self.places = results;
    [self reloadPlaces];
}

- (void)reloadPlaces {

    [self.strongTableView reloadData];
}

@end
