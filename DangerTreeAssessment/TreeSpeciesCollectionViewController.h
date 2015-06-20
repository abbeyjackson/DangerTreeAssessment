//
//  TreeSpeciesCollectionViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeSpecies.h"

@protocol SpeciesDelegate <NSObject>

-(void)selectSpecies:(TreeSpecies*)species;

@end

@interface TreeSpeciesCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<SpeciesDelegate> delegate;

@end
