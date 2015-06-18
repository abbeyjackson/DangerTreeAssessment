//
//  FuelCollectionViewCell.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "FuelCollectionViewCell.h"
#import "Fuel.h"

@interface FuelCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *abbreviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation FuelCollectionViewCell

- (void)setObject:(Fuel*)object {
    _object = object;
    
    [self configureCells];
}

-(void)configureCells{
    self.abbreviationLabel.text = self.object.abbreviation;
    self.infoLabel.text = self.object.name;
    
}

@end
