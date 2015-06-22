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

//all trees
@property (nonatomic) IBOutlet UILabel *latitudeLabel;
@property (nonatomic) IBOutlet UILabel *longitudeLabel;
@property (nonatomic) IBOutlet UILabel *speciesLabel;
@property (nonatomic) IBOutlet UILabel *treeClassLabel;
@property (nonatomic) IBOutlet UILabel *wildlifeValueLabel;
@property (nonatomic) IBOutlet UILabel *commentsLabel;

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
@property (nonatomic) IBOutlet UILabel *management;
@property (nonatomic) IBOutlet UILabel *comments;


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
        
        self.insecureLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 50)];
        self.insecureLabel.text = tree.insecure;
        [self.view addSubview:self.insecureLabel];
        
        self.unstableLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 300, 200, 50)];
        self.unstableLabel.text = tree.unstable;
        [self.view addSubview:self.unstableLabel];
        
        self.leaningLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 330, 200, 50)];
        self.leaningLabel.text = tree.leaning;
        [self.view addSubview:self.leaningLabel];
        
        
    }else if ([tree.site.lod isEqualToString:kLODType23]){

        self.hazardousTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 50)];
        self.hazardousTopLabel.text = tree.hazardousTop;
        [self.view addSubview:self.hazardousTopLabel];
        
        self.deadLimbsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 300, 200, 50)];
        self.deadLimbsLabel.text = tree.deadLimbs;
        [self.view addSubview:self.deadLimbsLabel];
        
        self.witchesBroomLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 330, 200, 50)];
        self.witchesBroomLabel.text = tree.witchesBroom;
        [self.view addSubview:self.witchesBroomLabel];
        
        self.splitTrunkLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 360, 200, 50)];
        self.splitTrunkLabel.text = tree.splitTrunk;
        [self.view addSubview:self.splitTrunkLabel];
        
        self.stemDamageLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 390, 200, 50)];
        self.stemDamageLabel.text = tree.stemDamage;
        [self.view addSubview:self.stemDamageLabel];
        
        self.sloughingBarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 420, 200, 50)];
        self.sloughingBarkLabel.text = tree.sloughingBark;
        [self.view addSubview:self.sloughingBarkLabel];
        
        self.cankersLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 450, 200, 50)];
        self.cankersLabel.text = tree.cankers;
        [self.view addSubview:self.cankersLabel];
        
        self.conksMushroomsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 480, 200, 50)];
        self.conksMushroomsLabel.text = tree.conksMushrooms;
        [self.view addSubview:self.conksMushroomsLabel];
        
        self.treeLeanLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 510, 200, 50)];
        self.treeLeanLabel.text = tree.treeLean;
        [self.view addSubview:self.treeLeanLabel];
        
        self.rootInspectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 540, 200, 50)];
        self.rootInspectionLabel.text = tree.rootInspection;
        [self.view addSubview:self.rootInspectionLabel];

        
    }else if ([tree.site.lod isEqualToString:kLODType4]){
        self.ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 50)];
        self.ratingLabel.text = tree.rating;
        [self.view addSubview:self.ratingLabel];
    }
    
}




#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showSiteReview"]) {
        
        [[segue destinationViewController] setTree:self.tree];
    }
}

@end
