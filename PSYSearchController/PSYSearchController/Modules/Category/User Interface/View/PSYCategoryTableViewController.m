//
//  PSYCategoryTableViewController.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 15/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYCategoryTableViewController.h"
#import "PSYCategory.h"

@interface PSYCategoryTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *dismissBarButtonItem;
@property (nonatomic, strong) RLMResults *catogories;
@property (nonatomic, strong) PSYCategory * currentCategory;
@end

@implementation PSYCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catogories = [PSYCategory allObjects];
    self.currentCategory = [PSYCategory objectForPrimaryKey:@(1)];
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.catogories.count < 1) {
        return 0;
    }
    return self.catogories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSYCategory * category = self.catogories[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSYCategoryTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = category.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentCategory = [self.catogories objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self dismissBarButtonItemDidTapped:self.dismissBarButtonItem];
}

- (IBAction)dismissBarButtonItemDidTapped:(UIBarButtonItem *)sender {
    
    if (self.category) {
        self.category(self.currentCategory);
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
