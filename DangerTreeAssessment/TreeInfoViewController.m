//
//  TreeInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeInfoViewController.h"
#import "TreeLOD1ViewController.h"
#import "TreeLOD23ViewController.h"
#import "TreeLOD4ViewController.h"
#import "TreeClass.h"
#import "TreeSpecies.h"
#import "Tree.h"
#import "Site.h"
#import "SiteInfoViewController.h"
#import "UIColor+CustomColours.h"
#import "DataTableViewController.h"

@interface TreeInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;
@property (weak, nonatomic) IBOutlet UITextField *speciesField;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UITextField *wildlifeValueField;

@end

@implementation TreeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextFields];
    [self resetTree];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self checkIfNewTree];
    self.navigationItem.hidesBackButton = YES;
    
}

-(void)resetTree{
    
    self.tree = [[Tree alloc]init];
    
}

-(void)checkIfNewTree{
    
    if (self.site == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Must start a site first" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Start New Site", nil];

        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UINavigationController *navigationController = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:0];
        [self.tabBarController setSelectedIndex:0];
    }
    if (buttonIndex == 1) {
        UINavigationController *navigationController = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:0];
        SiteInfoViewController *destination = [navigationController.viewControllers firstObject];
        [destination performSegueWithIdentifier:@"addSite" sender:self];
        [self.tabBarController setSelectedIndex:0];
    }
    
}
    
    
-(NSString*)setTreeNum{
    RLMResults *results = [Tree allObjects];
    Tree *tree = [results lastObject];
    NSString *newTreeNum = @"001";
    if (results.count > 0) {
        if ([tree.site.siteID isEqualToString:self.site.siteID]) {
            int newTreeNumber = [[tree.treeID substringFromIndex:[tree.treeID length] -3] intValue] + 1;
            newTreeNum = [NSString stringWithFormat:@"%03d", newTreeNumber];
        }
        // else newTreeID should be 001
    }
    return newTreeNum;
}

-(Tree*)createTree{
    
    self.tree.site = self.site;
    self.tree.lat = self.latitudeField.text;
    self.tree.lon = self.longitudeField.text;
    self.tree.species = [self.speciesField.text substringToIndex:3];
    self.tree.treeClass = [self.classField.text substringToIndex:3];
    self.tree.wildLifeValue = self.wildlifeValueField.text;
    self.tree.treeNumber = [self setTreeNum];
    self.tree.treeID = [NSString stringWithFormat:@"%@-%@", self.site.siteID,self.tree.treeNumber];

    return self.tree;
}

-(void)configureTextFields{
    
    self.latitudeField.text = nil;
    self.longitudeField.text = nil;
    self.speciesField.text = nil;
    self.classField.text = nil;
    self.wildlifeValueField.text = nil;
    
    [self textFieldShouldBeginEditing:self.speciesField];
    [self textFieldShouldBeginEditing:self.classField];
    [self textFieldShouldBeginEditing:self.wildlifeValueField];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}


- (IBAction)wildlifeValueActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Wildlife Value"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:kH, kM, kL, nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.wildlifeValueField.text = kH;
    }
    if (buttonIndex == 1) {
        self.wildlifeValueField.text = kM;
    }
    if (buttonIndex == 2) {
        self.wildlifeValueField.text = kL;
    }
}

-(void)selectClass:(TreeClass *)class{
    self.classField.text = class.numAndInfo;
}

-(void)selectSpecies:(TreeSpecies *)species{
    self.speciesField.text = [NSString stringWithFormat:@"%@ - %@", species.abbreviation, species.name];
}


- (IBAction)saveNewTreeButton:(id)sender {
    self.tree = [self createTree];
    if ([self.site.lod isEqualToString: kLODType1]) {
        TreeLOD1ViewController *destination = [self.storyboard instantiateViewControllerWithIdentifier:@"TreeLOD1"];
        [destination setTree:self.tree];
        [destination setSite:self.site];
        [self.navigationController pushViewController:destination animated:YES];
    }
    if ([self.site.lod isEqualToString: kLODType23]) {
        TreeLOD23ViewController *destination =  [self.storyboard instantiateViewControllerWithIdentifier:@"TreeLOD23"];
        [destination setTree:self.tree];
        [destination setSite:self.site];
        [self.navigationController pushViewController:destination animated:YES];
    }
    if ([self.site.lod isEqualToString: kLODType4]) {
        TreeLOD4ViewController *destination = [self.storyboard instantiateViewControllerWithIdentifier:@"TreeLOD4"];
        [destination setTree:self.tree];
        [destination setSite:self.site];
        [self.navigationController pushViewController:destination animated:YES];
    }
    
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showSpecies"]) {
        [[segue destinationViewController] setDelegate:self];
    }
    if ([[segue identifier] isEqualToString:@"showClass"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}



- (IBAction)unwindToTreeInfo:(UIStoryboardSegue*)sender{
}

@end
