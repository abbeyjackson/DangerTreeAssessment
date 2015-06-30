//
//  TreeReviewViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeReviewViewController.h"
#import "SiteReviewViewController.h"
#import "Tree.h"
#import "Site.h"
#import "TreeInfoViewController.h"
#import "Site.h"
#import "SiteInfoViewController.h"
#import "UIColor+CustomColours.h"

@interface TreeReviewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UIScrollView *scrollView;

//all trees
@property (nonatomic) IBOutlet UILabel *latitudeLabel;
@property (nonatomic) IBOutlet UILabel *longitudeLabel;
@property (nonatomic) IBOutlet UILabel *speciesLabel;
@property (nonatomic) IBOutlet UILabel *treeClassLabel;
@property (nonatomic) IBOutlet UILabel *wildlifeValueLabel;

//LOD1 trees:
@property (nonatomic) IBOutlet UILabel *insecureLabel;
@property (nonatomic) IBOutlet UILabel *unstableLabel;
@property (nonatomic) IBOutlet UILabel *leaningLabel;

//LOD23 trees:
@property (nonatomic) IBOutlet UILabel *hazardousTopLabel;
@property (nonatomic) IBOutlet UILabel *deadLimbsLabel;
@property (nonatomic) IBOutlet UILabel *witchesBroomLabel;
@property (nonatomic) IBOutlet UILabel *splitTrunkLabel;
@property (nonatomic) IBOutlet UILabel *stemDamageLabel;
@property (nonatomic) IBOutlet UILabel *sloughingBarkLabel;
@property (nonatomic) IBOutlet UILabel *cankersLabel;
@property (nonatomic) IBOutlet UILabel *conksMushroomsLabel;
@property (nonatomic) IBOutlet UILabel *treeLeanLabel;
@property (nonatomic) IBOutlet UILabel *rootInspectionLabel;

//LOD4 trees:
@property (nonatomic) IBOutlet UILabel *ratingLabel;

//Management (all trees)
@property (nonatomic) IBOutlet UILabel *isDangerousLabel;
@property (nonatomic) IBOutlet UILabel *managementLabel;
@property (nonatomic) IBOutlet UILabel *commentsLabel;

@property (nonatomic) IBOutlet UILabel *isDangerousPlaceholder;
@property (nonatomic) IBOutlet UILabel *managementPlaceholder;
@property (nonatomic) IBOutlet UILabel *commentsPlaceholder;

@property (nonatomic) IBOutlet UILabel *latitudePlaceholder;


@end

@implementation TreeReviewViewController{
    NSMutableArray *treeReviewObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submitTreeReport:(id)sender {
    [self saveTree];
//    [self closeTreeIsOpen];
    [self submitReportAlert];
}

//-(void)closeTreeIsOpen{
//    UINavigationController *reviewNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
//    SiteReviewViewController *siteReview = (SiteReviewViewController *)[reviewNavController.viewControllers firstObject];
//    [siteReview setTreeStarted:NO];
//    
//    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
//    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
//    [siteInfo setTreeStarted:NO];
//}

//-(void)clearTreeFromTreeInfoViewController{
//    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
//    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
//    [siteInfo setTreeStarted:NO];
//}

-(void)saveTree{
    RLMRealm *realm = self.site.realm;
    
    [realm beginWriteTransaction];
    [realm addObject:self.tree];
    self.tree.isComplete = YES;
    [self.site.trees addObject:self.tree];
    [realm commitWriteTransaction];
    
    [self tellSiteTreeIsClosed];
}

-(void)tellSiteTreeIsClosed{
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo setIsNewTree:NO];
    
    UINavigationController *reviewNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
    SiteReviewViewController *siteReview = (SiteReviewViewController *)[reviewNavController.viewControllers firstObject];
    [siteReview setTreeOpen:NO];
}


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
        [self.navigationController popToRootViewControllerAnimated:NO];    }

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showSiteReview"]) {
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return treeReviewObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    return cell;
}

@end
