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
}

- (IBAction)goToSiteReview:(id)sender {
    [self saveTree];
    [self submitReportAlert];
}

-(void)saveTree{
    RLMRealm *realm = self.site.realm;
    
    [realm beginWriteTransaction];
    [realm addObject:self.tree];
    [self.site.trees addObject:self.tree];
    [realm commitWriteTransaction];
}


-(void)submitReportAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tree Report Complete" message:@"What would you like to do next?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"New Tree", @"Submit Report", nil];
    // optional - add more buttons:
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // dismiss alert
    }
    if (buttonIndex == 1) {
        UIStoryboard *assessment = [UIStoryboard storyboardWithName:@"Assessment" bundle:nil];
        TreeInfoViewController *destination = [assessment instantiateViewControllerWithIdentifier:@"TreeInformation"];
        [destination setSite:self.site];
        [self showViewController:destination sender:self];
    }
    if (buttonIndex == 2) {
        [self performSegueWithIdentifier:@"showSiteReview" sender:self];
    }

}

-(void)createScrollView{
        self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.scrollView.showsVerticalScrollIndicator=YES;
        self.scrollView.scrollEnabled=YES;
        self.scrollView.userInteractionEnabled=YES;
        [self.view addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
}

-(void)updateLabels{
    
    RLMResults *results = [Tree allObjects];
    Tree *tree = [results lastObject];
    
    // all trees:
    
    UILabel *latitudePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 120, 200, 20)];
    latitudePlaceholder.text = @"Latitude";
    latitudePlaceholder.font = [UIFont systemFontOfSize:10];
    [self.scrollView addSubview:latitudePlaceholder];
    
    self.latitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 120, 200, 50)];
    self.latitudeLabel.text = tree.lat;
    self.latitudeLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.latitudeLabel];
    
    UILabel *longitudePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 150, 200, 20)];
    longitudePlaceholder.text = @"Longitude";
    longitudePlaceholder.font = [UIFont systemFontOfSize:10];
    [self.scrollView addSubview:longitudePlaceholder];
    
    self.longitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 150, 200, 50)];
    self.longitudeLabel.text = tree.lon;
    self.longitudeLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.longitudeLabel];
    
    UILabel *speciesPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 180, 200, 20)];
    speciesPlaceholder.text = @"Species";
    speciesPlaceholder.font = [UIFont systemFontOfSize:10];
    [self.scrollView addSubview:speciesPlaceholder];
    
    self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 180, 200, 50)];
    self.speciesLabel.text = tree.species;
    self.speciesLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.speciesLabel];
    
    UILabel *treeClassPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 210, 200, 20)];
    treeClassPlaceholder.text = @"Tree Class";
    treeClassPlaceholder.font = [UIFont systemFontOfSize:10];
    [self.scrollView addSubview:treeClassPlaceholder];

    self.treeClassLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 210, 200, 50)];
    self.treeClassLabel.text = tree.treeClass;
    self.treeClassLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.treeClassLabel];
    
    UILabel *wildLifePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 240, 200, 20)];
    wildLifePlaceholder.text = @"Wildlife Value";
    wildLifePlaceholder.font = [UIFont systemFontOfSize:10];
    [self.scrollView addSubview:wildLifePlaceholder];
    
    self.wildlifeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 240, 200, 50)];
    self.wildlifeValueLabel.text = tree.wildLifeValue;
    self.wildlifeValueLabel.font = [UIFont systemFontOfSize:20];
    [self.scrollView addSubview:self.wildlifeValueLabel];


    if ([tree.site.lod isEqualToString:kLODType1]){
        
        UILabel *insecurePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 20)];
        insecurePlaceholder.text = @"Insecure";
        insecurePlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:insecurePlaceholder];
        
        self.insecureLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 50)];
        self.insecureLabel.text = tree.insecure;
        self.insecureLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.insecureLabel];
        
        UILabel *unstablePlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 300, 200, 20)];
        unstablePlaceholder.text = @"Unstable";
        unstablePlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:unstablePlaceholder];
        
        self.unstableLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 300, 200, 50)];
        self.unstableLabel.text = tree.unstable;
        self.unstableLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.unstableLabel];
        
        UILabel *leaningPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 330, 200, 20)];
        leaningPlaceholder.text = @"Leaning";
        leaningPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:leaningPlaceholder];
        
        self.leaningLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 330, 200, 50)];
        self.leaningLabel.text = tree.leaning;
        self.leaningLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.leaningLabel];
        
        
    }else if ([tree.site.lod isEqualToString:kLODType23]){
        
        UILabel *hazardousPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 20)];
        hazardousPlaceholder.text = @"Hazardous Top";
        hazardousPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:hazardousPlaceholder];

        self.hazardousTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 50)];
        self.hazardousTopLabel.text = tree.hazardousTop;
        self.hazardousTopLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.hazardousTopLabel];
        
        UILabel *deadLimbsPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 300, 200, 20)];
        deadLimbsPlaceholder.text = @"Dead Limbs";
        deadLimbsPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:deadLimbsPlaceholder];
        
        self.deadLimbsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 300, 200, 50)];
        self.deadLimbsLabel.text = tree.deadLimbs;
        self.deadLimbsLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.deadLimbsLabel];
        
        UILabel *witchesPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 330, 200, 20)];
        witchesPlaceholder.text = @"Witches Broom";
        witchesPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:witchesPlaceholder];
        
        self.witchesBroomLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 330, 200, 50)];
        self.witchesBroomLabel.text = tree.witchesBroom;
        self.witchesBroomLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.witchesBroomLabel];
        
        UILabel *splitPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 360, 200, 20)];
        splitPlaceholder.text = @"Split Trunk";
        splitPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:splitPlaceholder];
        
        self.splitTrunkLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 360, 200, 50)];
        self.splitTrunkLabel.text = tree.splitTrunk;
        self.splitTrunkLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.splitTrunkLabel];
        
        UILabel *stemPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 390, 200, 20)];
        stemPlaceholder.text = @"Stem Damage";
        stemPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:stemPlaceholder];
        
        self.stemDamageLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 390, 200, 50)];
        self.stemDamageLabel.text = tree.stemDamage;
        self.stemDamageLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.stemDamageLabel];
        
        UILabel *sloughingPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 420, 200, 20)];
        sloughingPlaceholder.text = @"Sloughing Bark";
        sloughingPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:sloughingPlaceholder];
        
        self.sloughingBarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 420, 200, 50)];
        self.sloughingBarkLabel.text = tree.sloughingBark;
        self.sloughingBarkLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.sloughingBarkLabel];
        
        UILabel *cankersPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 450, 200, 20)];
        cankersPlaceholder.text = @"Cankers";
        cankersPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:cankersPlaceholder];
        
        self.cankersLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 450, 200, 50)];
        self.cankersLabel.text = tree.cankers;
        self.cankersLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.cankersLabel];
        
        UILabel *conksPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 480, 200, 20)];
        conksPlaceholder.text = @"Conks Mushrooms";
        conksPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:conksPlaceholder];
        
        self.conksMushroomsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 480, 200, 50)];
        self.conksMushroomsLabel.text = tree.conksMushrooms;
        self.conksMushroomsLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.conksMushroomsLabel];
        
        UILabel *treeLeanPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 510, 200, 20)];
        treeLeanPlaceholder.text = @"Tree Lean";
        treeLeanPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:treeLeanPlaceholder];
        
        self.treeLeanLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 510, 200, 50)];
        self.treeLeanLabel.text = tree.treeLean;
        self.treeLeanLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.treeLeanLabel];
        
        UILabel *rootPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 540, 200, 20)];
        rootPlaceholder.text = @"Root Inspection";
        rootPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:rootPlaceholder];
        
        self.rootInspectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 540, 200, 50)];
        self.rootInspectionLabel.text = tree.rootInspection;
        self.rootInspectionLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.rootInspectionLabel];

        
    }else if ([tree.site.lod isEqualToString:kLODType4]){
        
        UILabel *ratingPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 20)];
        ratingPlaceholder.text = @"Rating";
        ratingPlaceholder.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:ratingPlaceholder];
        
        self.ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 50)];
        self.ratingLabel.text = tree.rating;
        self.ratingLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:self.ratingLabel];
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
