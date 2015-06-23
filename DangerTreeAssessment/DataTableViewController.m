//
//  DataTableViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "DataTableViewController.h"
#import "SitePractice.h"
#import "DataListCell.h"
#import "SiteReviewViewController.h"

@interface DataTableViewController ()

@end

@implementation DataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeSitesArray];
}
#pragma mark - Table view data source

-(void)makeSitesArray{
    self.sitesArray = [Site allObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.sitesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.object = self.sitesArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SiteReviewViewController *srvc = [[UIStoryboard storyboardWithName:@"Review" bundle:nil] instantiateViewControllerWithIdentifier:@"SiteReview"];
    Site *site = self.sitesArray[indexPath.row];
    srvc.site = site;
    [self showViewController:srvc sender:self];
}

@end
