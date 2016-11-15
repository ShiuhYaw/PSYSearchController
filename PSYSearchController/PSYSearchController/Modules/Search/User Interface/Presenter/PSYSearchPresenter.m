//
//  PSYSearchPresenter.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYSearchPresenter.h"
#import "PSYSearchInteractor.h"
#import "PSYSearchViewInterface.h"
#import "PSYSearchWireframe.h"

@implementation PSYSearchPresenter

#pragma mark PSYSearchModuleInterface

- (void)updateView {
    
    [self.searchInteractor findPlaces];
}

- (void)updateViewWithPredicate:(NSPredicate *)predicate category:(PSYCategory *)givenCategory sortProperty:(NSString *)sortProperty {
    
    [self.searchInteractor findPlaceWithPredicate:predicate
                                         category:givenCategory
                                     sortProperty:sortProperty];
}

- (void)updateViewWithSortProperty:(NSString *)sortProperty {
    
    [self.searchInteractor findPlaceWithSortProperty:sortProperty];
}

- (void)searchWithString:(NSString *)searchText {
    
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    else {
        [self updateView];
        return;
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
        
        lhs = [NSExpression expressionForKeyPath:@"category.name"];
        rhs = [NSExpression expressionForConstantValue:searchString];
        finalPredicate = [NSComparisonPredicate
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
    [self updateViewWithPredicate:finalCompoundPredicate
                         category:nil
                     sortProperty:nil];

}

- (void)addPlace {
    
}

#pragma mark PSYSearchInteractorOutput

- (void)foundPlaces:(RLMResults *)places {
    
//    if (places.count > 0) {
//        [self.userInterface showPlacesData:places];
//    } else {
//        [self.userInterface showNoContentMessage];
//    }
    [self.userInterface showPlacesData:places];
}


@end
