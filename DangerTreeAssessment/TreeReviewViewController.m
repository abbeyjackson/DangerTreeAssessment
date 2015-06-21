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
    
    self.latitudeLabel.text = tree.lat;
    self.longitudeLabel.text = tree.lon;
    self.speciesLabel.text = tree.species;
    self.treeClassLabel.text = tree.treeClass;
    self.wildlifeValueLabel.text = tree.wildLifeValue;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showSiteReview"]) {
        
        [[segue destinationViewController] setTree:self.tree];
    }
}

@end
