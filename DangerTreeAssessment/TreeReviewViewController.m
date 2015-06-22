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

@property (nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) IBOutlet UILabel *latitudeLabel;
@property (nonatomic) IBOutlet UILabel *longitudeLabel;
@property (nonatomic) IBOutlet UILabel *speciesLabel;
@property (nonatomic) IBOutlet UILabel *treeClassLabel;
@property (nonatomic) IBOutlet UILabel *wildlifeValueLabel;
@property (nonatomic) IBOutlet UILabel *commentsLabel;


@end

@implementation TreeReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
    
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToSiteReview:(id)sender {
    [self performSegueWithIdentifier:@"showSiteReview" sender:self];
}

-(void)createScrollView{
        self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.scrollView.showsVerticalScrollIndicator=YES;
        self.scrollView.scrollEnabled=YES;
        self.scrollView.userInteractionEnabled=YES;
        [self.view addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
}

-(void)updateLabels{
    
    RLMResults *results = [Tree allObjects];
    Tree *tree = [results lastObject];
    
    // all trees:
    
    self.latitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 120, 200, 50)];
    self.latitudeLabel.text = tree.lat;
    [self.view addSubview:self.latitudeLabel];
    
    self.longitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 150, 200, 50)];
    self.longitudeLabel.text = tree.lon;
    [self.view addSubview:self.longitudeLabel];
    
    self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 180, 200, 50)];
    self.speciesLabel.text = tree.species;
    [self.view addSubview:self.speciesLabel];

    self.treeClassLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 210, 200, 50)];
    self.treeClassLabel.text = tree.treeClass;
    [self.view addSubview:self.treeClassLabel];
    
    self.wildlifeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 240, 200, 50)];
    self.wildlifeValueLabel.text = tree.wildLifeValue;
    [self.view addSubview:self.wildlifeValueLabel];


    if ([tree.site.lod isEqualToString:kLODType1]){
        NSLog(@"LOD is 1");
    }else if ([tree.site.lod isEqualToString:kLODType23]){
        NSLog(@"LOD is 23");
    }else if ([tree.site.lod isEqualToString:kLODType4]){
        NSLog(@"LOD is 4");
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
