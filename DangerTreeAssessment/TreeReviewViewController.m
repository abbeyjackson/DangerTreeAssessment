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
#import "SiteInfoViewController.h"

@interface TreeReviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *treeClassLabel;
@property (weak, nonatomic) IBOutlet UILabel *wildlifeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;


@end

@implementation TreeReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToSiteReview:(id)sender {
    [self performSegueWithIdentifier:@"showSiteReview" sender:self];
}

-(void)updateLabels{
    
    RLMResults *results = [Tree allObjects];
    Tree *tree = [results lastObject];
    
    // all trees:
    
    self.latitudeLabel.text = tree.lat;
    self.longitudeLabel.text = tree.lon;
    self.speciesLabel.text = tree.species;
    self.treeClassLabel.text = tree.treeClass;
    self.wildlifeValueLabel.text = tree.wildLifeValue;
    
    if ([tree.site.lod isEqualToString:kLODType1]){
        NSLog(@"It works");
    }
    
}
    
//    // LOD1 trees:
//    
//    tree.insecure;
//    tree.unstable;
//    tree.leaning;
//    
//    // tree properties for LOD23 trees:
//    tree.hazardousTop;
//    tree.deadLimbs;
//    tree.witchesBroom;
//    tree.splitTrunk;
//    tree.stemDamage;
//    tree.sloughingBark;
//    tree.cankers;
//    tree.conksMushrooms;
//    tree.treeLean;
//    tree.rootInspection;
//    
//    // tree properties for LOD4 trees:
//    tree.rating;
//    
//    // all trees:
//    tree.isDangerous;
//    tree.management;
//    tree.comments;
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showSiteReview"]) {
        
        [[segue destinationViewController] setTree:self.tree];
    }
}

@end
