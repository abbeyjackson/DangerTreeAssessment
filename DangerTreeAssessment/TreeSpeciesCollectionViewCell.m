//
//  TreeSpeciesCollectionViewCell.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeSpeciesCollectionViewCell.h"

#import "TreeSpecies.h"


@interface TreeSpeciesCollectionViewCell()


@property (weak, nonatomic) IBOutlet UILabel *abbreviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end


@implementation TreeSpeciesCollectionViewCell


#pragma mark - Custom Accessors

- (void)setObject:(TreeSpecies*)object {
    _object = object;
    [self configureCells];
}


#pragma mark - Setup

-(void)configureCells{
    self.abbreviationLabel.text = self.object.abbreviation;
    self.infoLabel.text = self.object.name;
}


@end
