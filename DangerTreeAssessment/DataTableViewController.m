//
//  DataTableViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "DataTableViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "DataListCell.h"
#import "SiteInfoViewController.h"
#import "SiteReviewViewController.h"


@implementation DataTableViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeSitesArray];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}


#pragma mark - Setup

-(void)makeSitesArray{
    self.sitesArray = [[Site allObjects] sortedResultsUsingProperty:@"numberForArray" ascending:NO];
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sitesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.object = self.sitesArray[indexPath.row];
    
    if (!cell.object.isReportComplete) {
        cell.reportNotCompleteStar.text = @"★";
    }
    else {
        cell.reportNotCompleteStar.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
    SiteReviewViewController *destination = (SiteReviewViewController *)[navController.viewControllers firstObject];
    Site *site = self.sitesArray[indexPath.row];
    [destination setSite:site];
    [self.tabBarController setSelectedIndex:3];
}


@end
