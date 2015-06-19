//

//  TreeLOD23ViewController.m

//  DangerTreeAssessment

//

//  Created by Abegael Jackson on 2015-06-16.

//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.

//



#import "TreeLOD23ViewController.h"



@interface TreeLOD23ViewController ()



@property (weak, nonatomic) IBOutlet UISegmentedControl *hazardousTopControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *deadLimbsControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *witchesBroomControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *splitTrunkControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *stemDamageControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sloughingBarkControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *cankersControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *conksMushroomsControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *treeLeanControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *rootInspectionControl;



@end



@implementation TreeLOD23ViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSegmentedControls];
    
}



-(void)setupSegmentedControls{
    
    self.hazardousTopControl.selectedSegmentIndex = 1;
    
    self.deadLimbsControl.selectedSegmentIndex = 1;
    
    self.witchesBroomControl.selectedSegmentIndex = 1;
    
    self.splitTrunkControl.selectedSegmentIndex = 1;
    
    self.stemDamageControl.selectedSegmentIndex = 1;
    
    self.sloughingBarkControl.selectedSegmentIndex = 1;
    
    self.cankersControl.selectedSegmentIndex = 1;
    
    self.conksMushroomsControl.selectedSegmentIndex = 1;
    
    self.treeLeanControl.selectedSegmentIndex = 1;
    
    self.rootInspectionControl.selectedSegmentIndex = 1;
    
    
    
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



-(IBAction)segmentControlValueChanged:(id)sender {
    
    UISegmentedControl* control = (UISegmentedControl*)sender;
    
    NSString *result;
    
    if(control.selectedSegmentIndex == 0){
        
        result = @"Safe";
        
    }
    
    else if(control.selectedSegmentIndex == 1){
        
        result = nil;
        
    }
    
    else if(control.selectedSegmentIndex == 2){
        
        result = @"Dangerous";
        
    }
    
    else {
        
        result = nil;
        
    }
    
    
    
    [self setResult:result forSegmentControl:control];
    
}



-(void)setResult:(NSString*)result forSegmentControl:(UISegmentedControl*)control {
    
    if (control == self.hazardousTopControl) {
        
        self.tree.hazardousTop = result;
        
    }
    
    else if (control == self.deadLimbsControl){
        
        self.tree.deadLimbs = result;
        
    }
    
    else if (control == self.witchesBroomControl){
        
        self.tree.witchesBroom = result;
        
    }
    
    else if (control == self.splitTrunkControl){
        
        self.tree.splitTrunk = result;
        
    }
    
    else if (control == self.stemDamageControl){
        
        self.tree.stemDamage = result;
        
    }
    
    else if (control == self.sloughingBarkControl){
        
        self.tree.sloughingBark = result;
        
    }
    
    else if (control == self.cankersControl){
        
        self.tree.cankers = result;
        
    }
    
    else if (control == self.conksMushroomsControl){
        
        self.tree.conksMushrooms = result;
        
    }
    
    else if (control == self.treeLeanControl){
        
        self.tree.treeLean = result;
        
    }
    
    else if (control == self.rootInspectionControl){
        
        self.tree.rootInspection = result;
        
    }
    
}





- (IBAction)saveTreeAssessmentButton:(id)sender {
    
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];    
    
}



#pragma mark - Navigation



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        
        [[segue destinationViewController] setTree:self.tree];
        
    }
    
}



@end

