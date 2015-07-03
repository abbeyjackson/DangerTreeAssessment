//
//  TreeReviewViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeReviewViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "ReportLabel.h"
#import "Site.h"
#import "SiteInfoViewController.h"
#import "SiteReviewViewController.h"
#import "Tree.h"
#import "TreeInfoViewController.h"


@interface TreeReviewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *treeReviewObjects;
    
@end


@implementation TreeReviewViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView setContentInset:UIEdgeInsetsMake(25,0,0,0)];
    [self createTreeReportLabelArray];
    [self.tableView reloadData];
}


#pragma mark - Setup

-(void)createTreeReportLabelArray{
    ReportLabel *lat = [[ReportLabel alloc] initWithLabel:@"Latitude" andDetail:self.tree.lat];
    ReportLabel *lon = [[ReportLabel alloc] initWithLabel:@"Longitude" andDetail:self.tree.lon];
    ReportLabel *species = [[ReportLabel alloc] initWithLabel:@"Species" andDetail:self.tree.species];
    ReportLabel *treeClass = [[ReportLabel alloc] initWithLabel:@"Class" andDetail:self.tree.treeClass];
    ReportLabel *wildLifeValue = [[ReportLabel alloc] initWithLabel:@"Wildlife Value" andDetail:self.tree.wildLifeValue];
    
    // LOD 1
    ReportLabel *insecure = [[ReportLabel alloc] initWithLabel:@"Insecure" andDetail:self.tree.insecure];
    ReportLabel *unstable = [[ReportLabel alloc] initWithLabel:@"Unstable" andDetail:self.tree.unstable];
    ReportLabel *leaning = [[ReportLabel alloc] initWithLabel:@"Leaning" andDetail:self.tree.leaning];
    
    // LOD 2
    ReportLabel *hazardousTop = [[ReportLabel alloc] initWithLabel:@"Hazardous Top" andDetail:self.tree.hazardousTop];
    ReportLabel *deadLimbs = [[ReportLabel alloc] initWithLabel:@"Dead Limbs" andDetail:self.tree.deadLimbs];
    ReportLabel *witchesBroom = [[ReportLabel alloc] initWithLabel:@"Witches Broom" andDetail:self.tree.witchesBroom];
    ReportLabel *splitTrunk = [[ReportLabel alloc] initWithLabel:@"Split Trunk" andDetail:self.tree.splitTrunk];
    ReportLabel *stemDamage = [[ReportLabel alloc] initWithLabel:@"Stem Damage" andDetail:self.tree.stemDamage];
    ReportLabel *sloughingBark = [[ReportLabel alloc] initWithLabel:@"Sloughing Bark" andDetail:self.tree.sloughingBark];
    ReportLabel *cankers = [[ReportLabel alloc] initWithLabel:@"Cankers" andDetail:self.tree.cankers];
    ReportLabel *conksMushrooms = [[ReportLabel alloc] initWithLabel:@"Conks Mushrooms" andDetail:self.tree.conksMushrooms];
    ReportLabel *treeLean = [[ReportLabel alloc] initWithLabel:@"Tree Lean" andDetail:self.tree.treeLean];
    ReportLabel *rootInspection = [[ReportLabel alloc] initWithLabel:@"Root Inspection" andDetail:self.tree.rootInspection];
    
    // LOD 4
    ReportLabel *rating = [[ReportLabel alloc] initWithLabel:@"Rating" andDetail:self.tree.rating];
    
    // Handling the bool
    NSString *boolValue;
    if (self.tree.isDangerous == 1){
        boolValue = @"YES";
    }else if (self.tree.isDangerous == 0){
        boolValue = @"NO";
    }
    
    // Management
    ReportLabel *isDangerous = [[ReportLabel alloc] initWithLabel:@"Dangerous" andDetail:boolValue];
    ReportLabel *management = [[ReportLabel alloc] initWithLabel:@"Management" andDetail:self.tree.management];
    ReportLabel *comments = [[ReportLabel alloc] initWithLabel:@"Comments" andDetail:self.tree.comments];
    
    if ([self.tree.site.lod isEqualToString:kLODType1]){
        self.treeReviewObjects = [[NSArray alloc] initWithObjects:lat, lon, species, treeClass, wildLifeValue, insecure, unstable, leaning, isDangerous, management, comments, nil];
    }
    else if ([self.tree.site.lod isEqualToString:kLODType23]){
        self.treeReviewObjects = [[NSArray alloc] initWithObjects:lat, lon, species, treeClass, wildLifeValue, hazardousTop, deadLimbs, witchesBroom, splitTrunk, stemDamage, sloughingBark, cankers, conksMushrooms, treeLean, rootInspection, isDangerous, management, comments, nil];
    }
    else if ([self.tree.site.lod isEqualToString:kLODType4]){
        self.treeReviewObjects = [[NSArray alloc] initWithObjects:lat, lon, species, treeClass, wildLifeValue, rating, isDangerous, management, comments, nil];
    }
}


#pragma mark - Alerts

-(void)submitReportAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tree Report Complete" message:@"What would you like to do next?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"New Tree", @"Submit Report", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // dismiss alert
    }
    if (buttonIndex == 1) {
        UINavigationController *vc = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:2];
        TreeInfoViewController *destination = vc.viewControllers.firstObject;
        [destination setSite:self.site];
        [self.tabBarController setSelectedIndex:2];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    if (buttonIndex == 2) {
        UINavigationController *vc = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:3];
        SiteReviewViewController *destination = vc.viewControllers.firstObject;
        [destination setSite:self.site];
        [self.tabBarController setSelectedIndex:3];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}


#pragma mark - IBActions

- (IBAction)submitTreeReport:(id)sender {
    [self saveTree];
    [self submitReportAlert];
}


#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.treeReviewObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ReportLabel *reportLabel = self.treeReviewObjects[indexPath.row];
    cell.textLabel.text = reportLabel.label;
    cell.detailTextLabel.text = reportLabel.detail;
    return cell;
}


#pragma mark - Save Data

-(void)saveTree{
    RLMRealm *realm = self.site.realm;
    
    [realm beginWriteTransaction];
    [realm addObject:self.tree];
    self.tree.isComplete = YES;
    [self.site.trees addObject:self.tree];
    [realm commitWriteTransaction];
    
    [self tellSiteTreeIsClosed];
}


#pragma mark - Pass Data

-(void)tellSiteTreeIsClosed{
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo setIsNewTree:NO];
    
    UINavigationController *reviewNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
    SiteReviewViewController *siteReview = (SiteReviewViewController *)[reviewNavController.viewControllers firstObject];
    [siteReview setIsTreeOpen:NO];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showSiteReview"]) {
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}


@end
