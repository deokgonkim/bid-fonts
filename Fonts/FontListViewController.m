//
//  FontListViewController.m
//  Fonts
//
//  Created by Deokgon Kim on 2018. 6. 2..
//  Copyright © 2018년 Deokgon Kim. All rights reserved.
//

#import "FontListViewController.h"

#import "FontSizesViewController.h"
#import "FontInfoViewController.h"

#import "FavoriteList.h"

@interface FontListViewController ()

@property (assign, nonatomic) CGFloat cellPointSize;

@end

@implementation FontListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle: UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
    
    if (self.showsFavorites) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.showsFavorites) {
        self.fontNames = [FavoriteList sharedInstance].favorites;
        [self.tableView reloadData];
    }
}

- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fontName = self.fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:self.cellPointSize];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fontNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FontName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.fontNames[indexPath.row];
    cell.detailTextLabel.text = self.fontNames[indexPath.row];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.showsFavorites;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSString *favorite = self.fontNames[indexPath.row];
        [[FavoriteList sharedInstance] removeFavorite:favorite];
        self.fontNames = [FavoriteList sharedInstance].favorites;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[FavoriteList sharedInstance] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
    self.fontNames = [FavoriteList sharedInstance].favorites;
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    [segue.destinationViewController navigationItem].title = font.fontName;
    
    if ([segue.identifier isEqualToString:@"ShowFontSizes"]) {
        FontSizesViewController *sizesVC = segue.destinationViewController;
        sizesVC.font = font;
    } else {
        FontInfoViewController *infoVC = segue.destinationViewController;
        infoVC.font = font;
        infoVC.favorite = [[FavoriteList sharedInstance].favorites containsObject:font.fontName];
    }
}


@end
