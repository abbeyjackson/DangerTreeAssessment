//
//  TreeInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeInfoViewController.h"
#import "Tree.h"
#import "TreeLOD1ViewController.h"
#import "TreeLOD23ViewController.h"
#import "TreeLOD4ViewController.h"
#import "TreeClass.h"
#import "TreeSpecies.h"

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
    
    
}


-(Tree*)createTree{
    Tree *tree = [[Tree alloc]init];
    tree.site = self.site;
    tree.lat = [self.latitudeField.text doubleValue];
    tree.lon = [self.longitudeField.text doubleValue];
    tree.species = [self.speciesField.text substringToIndex:3];
    tree.treeClass = [self.classField.text substringToIndex:3];
    tree.wildLifeValue = self.wildlifeValueField.text;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:tree];
    [self.site.trees insertObject:tree atIndex:0];
    [realm commitWriteTransaction];
    
    return tree;
}

-(void)configureTextFields{
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
    
    if ([self.site.lod isEqualToString: kLODType1]) {
        [self performSegueWithIdentifier:@"showTreeLOD1" sender: self];
    }
    if ([self.site.lod isEqualToString: kLODType23]) {
        [self performSegueWithIdentifier:@"showTreeLOD23" sender: self];
    }
    if ([self.site.lod isEqualToString: kLODType4]) {
        [self performSegueWithIdentifier:@"showTreeLOD4" sender: self];
    }
    
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTreeLOD1"]) {
        self.tree = [self createTree];
        [[segue destinationViewController] setTree:self.tree];
    }
    if ([[segue identifier] isEqualToString:@"showTreeLOD23"]) {
        self.tree = [self createTree];
        [[segue destinationViewController] setTree:self.tree];
    }
    if ([[segue identifier] isEqualToString:@"showTreeLOD4"]) {
        self.tree = [self createTree];
        [[segue destinationViewController] setTree:self.tree];
    }
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
