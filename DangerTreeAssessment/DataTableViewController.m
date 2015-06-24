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
#import "UIColor+CustomColours.h"
#import "SiteInfoViewController.h"

@interface DataTableViewController ()

@end

@implementation DataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeSitesArray];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

-(void)makeSitesArray{
//    self.sitesArray = [Site allObjects];
    self.sitesArray = [[Site allObjects] sortedResultsUsingProperty:@"numberForArray" ascending:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.sitesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.object = self.sitesArray[indexPath.row];
    if (!cell.object.isReportComplete) {
        cell.reportNotCompleteStar.text = @"★";
    }
    else cell.reportNotCompleteStar.text = @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UINavigationController *navController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:2];

    SiteReviewViewController *destination = (SiteReviewViewController *)[navController.viewControllers firstObject];
    
    Site *site = self.sitesArray[indexPath.row];
    destination.site = site;
    
    [self.tabBarController setSelectedIndex:3];
}

@end
