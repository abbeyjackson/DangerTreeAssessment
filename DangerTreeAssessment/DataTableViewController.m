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
@property (weak, nonatomic) IBOutlet UIImageView *tableHeader;

@end

@implementation DataTableViewController

static const int kTableHeaderHeight = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeSitesArray];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [self.navigationController setNavigationBarHidden: YES animated:YES];
    
//    [self updateHeaderView];
    
}
//
//
//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self updateHeaderView];
//}
//
//-(void)updateHeaderView{
//    
//    self.tableView.tableHeaderView = nil;
//    [self.tableView addSubview:self.tableHeader];
//    
//    NSLog(@"%f",self.tableView.contentOffset.y);
//    
//    [self.tableView setContentInset:UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0)];
//    CGRect frame = self.tableHeader.frame;
//    frame.origin.y = self.tableView.contentOffset.y;
//    self.tableHeader.frame = frame;
//    
//    if (self.tableView.contentOffset.y < 0) {
//        CGRect frame = self.tableHeader.frame;
//        frame.origin.y = self.tableView.contentOffset.y;
//        frame.size.height = 0 - self.tableView.contentOffset.y;
//        self.tableHeader.frame = frame;
//    }
//}


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
