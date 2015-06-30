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
#import "ReportLabel.h"

@interface TreeReviewViewController () <UITableViewDataSource, UITableViewDelegate>

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
    NSArray *treeReviewObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTreeReportLabelArray];

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
    
    // Management
    ReportLabel *isDangerous = [[ReportLabel alloc] initWithLabel:@"Dangerous" andDetail:[[NSNumber numberWithBool:self.tree.isDangerous] stringValue]];
    ReportLabel *management = [[ReportLabel alloc] initWithLabel:@"Management" andDetail:self.tree.management];
    ReportLabel *comments = [[ReportLabel alloc] initWithLabel:@"Comments" andDetail:self.tree.comments];
    
    if ([self.tree.site.lod isEqualToString:kLODType1]){
            treeReviewObjects = [[NSArray alloc] initWithObjects:lat, lon, species, treeClass, wildLifeValue, insecure, unstable, leaning, isDangerous, management, comments, nil];
    }else if ([self.tree.site.lod isEqualToString:kLODType23]){
            treeReviewObjects = [[NSArray alloc] initWithObjects:lat, lon, species, treeClass, wildLifeValue, hazardousTop, deadLimbs, witchesBroom, splitTrunk, stemDamage, sloughingBark, cankers, conksMushrooms, treeLean, rootInspection, isDangerous, management, comments, nil];
    }else if ([self.tree.site.lod isEqualToString:kLODType4]){
            treeReviewObjects = [[NSArray alloc] initWithObjects:lat, lon, species, treeClass, wildLifeValue, rating, isDangerous, management, comments, nil];
    }
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return treeReviewObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ReportLabel *reportLabel = treeReviewObjects[indexPath.row];
    
    cell.textLabel.text = reportLabel.label;
    cell.detailTextLabel.text = reportLabel.detail;
    
    
    return cell;
}

@end
