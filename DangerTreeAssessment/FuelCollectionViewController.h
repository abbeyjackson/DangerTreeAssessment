//
//  FuelCollectionViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fuel;

@protocol FuelDelegate <NSObject>

-(void)selectFuelType:(Fuel*)fuel;

@end

@interface FuelCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<FuelDelegate> delegate;



@end
