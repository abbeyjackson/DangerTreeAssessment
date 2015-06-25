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

@interface TreeReviewViewController ()

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

@implementation TreeReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
    [self updateLabels];
    [self updateLabelContraints];
}

-(void)viewDidAppear:(BOOL)animated {
    //testing for the content size
    NSLog(@"Scoll view content size: (%f, %f)", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submitTreeReport:(id)sender {
    [self saveTree];
    [self closeTreeIsOpen];
    [self submitReportAlert];
}

-(void)closeTreeIsOpen{
    UINavigationController *reviewNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
    SiteReviewViewController *siteReview = (SiteReviewViewController *)[reviewNavController.viewControllers firstObject];
    [siteReview setTreeStarted:NO];
    
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo setTreeStarted:NO];
}

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
//        [destination initializeNewTree];
        [destination setSite:self.site];
        [self.tabBarController setSelectedIndex:2];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    if (buttonIndex == 2) {
        [self performSegueWithIdentifier:@"showSiteReview" sender:self];
        [self.tabBarController setSelectedIndex:3];
    }

}

#pragma mark - Scroll View

-(void)createScrollView{
        self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50, self.view.frame.size.height - 60)];
        self.scrollView.showsVerticalScrollIndicator= NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.scrollEnabled=YES;
        self.scrollView.alwaysBounceVertical=YES;
        self.scrollView.userInteractionEnabled=YES;
        [self.view addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
        [self.view sendSubviewToBack:self.scrollView];

}

#pragma mark - Update Labels

-(void)updateLabels{
    
    // all trees:
    
    self.latitudePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 120, 200, 20)];
    self.latitudePlaceholder.text = @"Latitude";
    self.latitudePlaceholder.font = [UIFont systemFontOfSize:10];
    self.latitudePlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:self.latitudePlaceholder];
    self.latitudePlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.latitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 35, 200, 50)];
    self.latitudeLabel.text = self.tree.lat;
    self.latitudeLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.latitudeLabel];
    
    UILabel *longitudePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 65, 200, 20)];
    longitudePlaceholder.text = @"Longitude";
    longitudePlaceholder.font = [UIFont systemFontOfSize:10];
    longitudePlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:longitudePlaceholder];
    
    self.longitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 65, 200, 50)];
    self.longitudeLabel.text = self.tree.lon;
    self.longitudeLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.longitudeLabel];
    
    UILabel *speciesPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 95, 200, 20)];
    speciesPlaceholder.text = @"Species";
    speciesPlaceholder.font = [UIFont systemFontOfSize:10];
    speciesPlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:speciesPlaceholder];
    
    self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 95, 200, 50)];
    self.speciesLabel.text = self.tree.species;
    self.speciesLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.speciesLabel];
    
    UILabel *treeClassPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 125, 200, 20)];
    treeClassPlaceholder.text = @"Tree Class";
    treeClassPlaceholder.font = [UIFont systemFontOfSize:10];
    treeClassPlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:treeClassPlaceholder];
    
    self.treeClassLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 125, 200, 50)];
    self.treeClassLabel.text = self.tree.treeClass;
    self.treeClassLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.treeClassLabel];
    
    UILabel *wildLifePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 155, 200, 20)];
    wildLifePlaceholder.text = @"Wildlife Value";
    wildLifePlaceholder.font = [UIFont systemFontOfSize:10];
    wildLifePlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:wildLifePlaceholder];
    
    self.wildlifeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 155, 200, 50)];
    self.wildlifeValueLabel.text = self.tree.wildLifeValue;
    self.wildlifeValueLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.wildlifeValueLabel];
    
    
    if ([self.tree.site.lod isEqualToString:kLODType1]){
        
        UILabel *insecurePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 185, 200, 20)];
        insecurePlaceholder.text = @"Insecure";
        insecurePlaceholder.font = [UIFont systemFontOfSize:10];
        insecurePlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:insecurePlaceholder];
        
        self.insecureLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 185, 200, 50)];
        self.insecureLabel.text = self.tree.insecure;
        self.insecureLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.insecureLabel];
        
        UILabel *unstablePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 215, 200, 20)];
        unstablePlaceholder.text = @"Unstable";
        unstablePlaceholder.font = [UIFont systemFontOfSize:10];
        unstablePlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:unstablePlaceholder];
        
        self.unstableLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 215, 200, 50)];
        self.unstableLabel.text = self.tree.unstable;
        self.unstableLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.unstableLabel];
        
        UILabel *leaningPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 245, 200, 20)];
        leaningPlaceholder.text = @"Leaning";
        leaningPlaceholder.font = [UIFont systemFontOfSize:10];
        leaningPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:leaningPlaceholder];
        
        self.leaningLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 245, 200, 50)];
        self.leaningLabel.text = self.tree.leaning;
        self.leaningLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.leaningLabel];
        
        
        
    }else if ([self.tree.site.lod isEqualToString:kLODType23]){
        
        UILabel *hazardousPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 185, 200, 20)];
        hazardousPlaceholder.text = @"Hazardous Top";
        hazardousPlaceholder.font = [UIFont systemFontOfSize:10];
        hazardousPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:hazardousPlaceholder];
        
        self.hazardousTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 185, 200, 50)];
        self.hazardousTopLabel.text = self.tree.hazardousTop;
        self.hazardousTopLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.hazardousTopLabel];
        
        UILabel *deadLimbsPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 215, 200, 20)];
        deadLimbsPlaceholder.text = @"Dead Limbs";
        deadLimbsPlaceholder.font = [UIFont systemFontOfSize:10];
        deadLimbsPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:deadLimbsPlaceholder];
        
        self.deadLimbsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 215, 200, 50)];
        self.deadLimbsLabel.text = self.tree.deadLimbs;
        self.deadLimbsLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.deadLimbsLabel];
        
        UILabel *witchesPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 245, 200, 20)];
        witchesPlaceholder.text = @"Witches Broom";
        witchesPlaceholder.font = [UIFont systemFontOfSize:10];
        witchesPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:witchesPlaceholder];
        
        self.witchesBroomLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 245, 200, 50)];
        self.witchesBroomLabel.text = self.tree.witchesBroom;
        self.witchesBroomLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.witchesBroomLabel];
        
        UILabel *splitPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 275, 200, 20)];
        splitPlaceholder.text = @"Split Trunk";
        splitPlaceholder.font = [UIFont systemFontOfSize:10];
        splitPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:splitPlaceholder];
        
        self.splitTrunkLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 275, 200, 50)];
        self.splitTrunkLabel.text = self.tree.splitTrunk;
        self.splitTrunkLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.splitTrunkLabel];
        
        UILabel *stemPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 305, 200, 20)];
        stemPlaceholder.text = @"Stem Damage";
        stemPlaceholder.font = [UIFont systemFontOfSize:10];
        stemPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:stemPlaceholder];
        
        self.stemDamageLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 305, 200, 50)];
        self.stemDamageLabel.text = self.tree.stemDamage;
        self.stemDamageLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.stemDamageLabel];
        
        UILabel *sloughingPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 335, 200, 20)];
        sloughingPlaceholder.text = @"Sloughing Bark";
        sloughingPlaceholder.font = [UIFont systemFontOfSize:10];
        sloughingPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:sloughingPlaceholder];
        
        self.sloughingBarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 335, 200, 50)];
        self.sloughingBarkLabel.text = self.tree.sloughingBark;
        self.sloughingBarkLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.sloughingBarkLabel];
        
        UILabel *cankersPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 365, 200, 20)];
        cankersPlaceholder.text = @"Cankers";
        cankersPlaceholder.font = [UIFont systemFontOfSize:10];
        cankersPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:cankersPlaceholder];
        
        self.cankersLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 365, 200, 50)];
        self.cankersLabel.text = self.tree.cankers;
        self.cankersLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.cankersLabel];
        
        UILabel *conksPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 395, 200, 20)];
        conksPlaceholder.text = @"Conks Mushrooms";
        conksPlaceholder.font = [UIFont systemFontOfSize:10];
        conksPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:conksPlaceholder];
        
        self.conksMushroomsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 395, 200, 50)];
        self.conksMushroomsLabel.text = self.tree.conksMushrooms;
        self.conksMushroomsLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.conksMushroomsLabel];
        
        UILabel *treeLeanPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 425, 200, 20)];
        treeLeanPlaceholder.text = @"Tree Lean";
        treeLeanPlaceholder.font = [UIFont systemFontOfSize:10];
        treeLeanPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:treeLeanPlaceholder];
        
        self.treeLeanLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 425, 200, 50)];
        self.treeLeanLabel.text = self.tree.treeLean;
        self.treeLeanLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.treeLeanLabel];
        
        UILabel *rootPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 455, 200, 20)];
        rootPlaceholder.text = @"Root Inspection";
        rootPlaceholder.font = [UIFont systemFontOfSize:10];
        rootPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:rootPlaceholder];
        
        self.rootInspectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 455, 200, 50)];
        self.rootInspectionLabel.text = self.tree.rootInspection;
        self.rootInspectionLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.rootInspectionLabel];
        
    }else if ([self.tree.site.lod isEqualToString:kLODType4]){
        
        UILabel *ratingPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 185, 200, 20)];
        ratingPlaceholder.text = @"Rating";
        ratingPlaceholder.font = [UIFont systemFontOfSize:10];
        ratingPlaceholder.textColor = [UIColor redColor];
        [self.scrollView addSubview:ratingPlaceholder];
        
        self.ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 185, 300, 50)];
        self.ratingLabel.text = self.tree.rating;
        self.ratingLabel.numberOfLines = 0;
        self.ratingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.ratingLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.ratingLabel];
    }
    
    
    self.isDangerousPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 570, 200, 20)];
    self.isDangerousPlaceholder.text = @"Is Dangerous";
    self.isDangerousPlaceholder.font = [UIFont systemFontOfSize:10];
    self.isDangerousPlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:self.isDangerousPlaceholder];
    self.isDangerousPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.isDangerousLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 570, 200, 50)];
    if (self.tree.isDangerous){
        self.isDangerousLabel.text = @"YES";
    } else if (!self.tree.isDangerous){
        self.isDangerousLabel.text = @"NO";
    }
    self.isDangerousLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.isDangerousLabel];
    self.isDangerousLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.managementPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 600, 200, 20)];
    self.managementPlaceholder.text = @"Management";
    self.managementPlaceholder.font = [UIFont systemFontOfSize:10];
    self.managementPlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:self.managementPlaceholder];
    self.managementPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.managementLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 600, 200, 50)];
    self.managementLabel.text = self.tree.management;
    self.managementLabel.font = [UIFont systemFontOfSize:20];
    self.managementLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.managementLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.managementLabel];
    self.managementLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.commentsPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 630, 200, 20)];
    self.commentsPlaceholder.text = @"Comments";
    self.commentsPlaceholder.font = [UIFont systemFontOfSize:10];
    self.commentsPlaceholder.textColor = [UIColor redColor];
    [self.scrollView addSubview:self.commentsPlaceholder];
    self.commentsPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 632, 300, 50)];
    self.commentsLabel.text = self.tree.comments;
    self.commentsLabel.numberOfLines = 0;
    self.commentsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.commentsLabel.font = [UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.commentsLabel];
    self.commentsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
}
#pragma mark - Constraints

-(void)updateLabelContraints{
    
    // scrollView constraints to allow contentSize accuracy (else contentsize height is zero)
    
    [self.scrollView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.latitudePlaceholder
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                    attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                    constant:37]];
    
    [self.scrollView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.latitudePlaceholder
                                    attribute:NSLayoutAttributeLeading
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                    attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                    constant:35]];
    
    if ([self.tree.site.lod isEqualToString:kLODType1]){
        
        // isDangerousPlaceholderLabel contraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.leaningLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-13]];
        // isDangerousLabel constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        // managementPlaceholder constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:0]];
        // managementLabel constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        // commentsPlaceholder constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.managementLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:0]];
        // commentsLabel constraints + extra constraint due to keep long comments on screen
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeTrailing
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeTrailing
                                        multiplier:1.0
                                        constant:-35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0
                                        constant:220]];
        // last item constraint
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:50]];
        
    }else if ([self.tree.site.lod isEqualToString:kLODType23]){
        
        // isDangerousPlaceholderLabel contraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.rootInspectionLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-13]];
        // isDangerousLabel constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        // managementPlaceholder constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:0]];
        // managementLabel constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        // commentsPlaceholder constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.managementLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:0]];
        // commentsLabel constraints + extra constraint due to keep long comments on screen
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeTrailing
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeTrailing
                                        multiplier:1.0
                                        constant:-35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0
                                        constant:220]];
        // last item constraint
        
        UILabel *placeholder = [[UILabel alloc] initWithFrame:CGRectMake(35, self.view.frame.size.height, 200, 200)];
        [self.scrollView addSubview:placeholder];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:placeholder
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:200]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:placeholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:placeholder
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0
                                        constant:50]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:placeholder
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0
                                        constant:200]];

        
        
    }else if ([self.tree.site.lod isEqualToString:kLODType4]){
        
        // isDangerousPlaceholderLabel contraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.ratingLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-13]];
        // isDangerousLabel constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.isDangerousPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        // managementPlaceholder constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.isDangerousLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:0]];
        // managementLabel constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.managementLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.managementPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        // commentsPlaceholder constraints
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.managementLabel
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:0]];
        // commentsLabel constraints + extra constraint due to keep long comments on screen
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                        constant:35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.commentsPlaceholder
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:-3]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeTrailing
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeTrailing
                                        multiplier:1.0
                                        constant:-35]];
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0
                                        constant:220]];
        
        // last item constraint
        
        [self.scrollView addConstraint:[NSLayoutConstraint
                                        constraintWithItem:self.commentsLabel
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.scrollView
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1.0
                                        constant:50]];
        
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showSiteReview"]) {
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}

@end
