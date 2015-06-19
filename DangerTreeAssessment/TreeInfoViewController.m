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

@interface TreeInfoViewController ()<UIActionSheetDelegate>

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

-(void)setDetailItem:(id)detailItem{
    
    
}

-(Tree*)createTree{
    
    Tree *tree = [[Tree alloc]init];
    tree.site = self.site;
    tree.lat = [self.latitudeField.text doubleValue];
    tree.lon = [self.longitudeField.text doubleValue];
//    tree.species = self.speciesField.text; ENUM
//    tree.class = self.classField.text; ENUM
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:tree];
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
                                                    otherButtonTitles:@"HIGH", @"MEDIUM", @"LOW", nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.wildlifeValueField.text = @"HIGH";
    }
    if (buttonIndex == 1) {
        self.wildlifeValueField.text = @"MEDIUM";
    }
    if (buttonIndex == 2) {
        self.wildlifeValueField.text = @"LOW";
    }
}

- (IBAction)saveNewTreeButton:(id)sender {
    
    if (self.site.lod == kLODType1) {
        [self performSegueWithIdentifier:@"showTreeLOD1" sender: self];
    }
    if (self.site.lod == kLODType23) {
        [self performSegueWithIdentifier:@"showTreeLOD23" sender: self];
    }
    if (self.site.lod == kLODType4) {
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
}


- (IBAction)unwindToTreeInfo:(UIStoryboardSegue*)sender{
}

@end
