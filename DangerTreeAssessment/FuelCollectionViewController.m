//
//  FuelCollectionViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "FuelCollectionViewController.h"

#import "Constants.h"

#import "Fuel.h"
#import "FuelCollectionViewCell.h"

#import <QuartzCore/QuartzCore.h>


@interface FuelCollectionViewController ()

@property (strong, nonatomic) NSArray *array;

@end


@implementation FuelCollectionViewController


static NSString * const reuseIdentifier = @"Cell";


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSArray alloc]initWithArray:[self makeArray]];
}


#pragma mark - Setup

-(NSArray*)makeArray{
    Fuel *c1 = [[Fuel alloc] initWithAbbreviation:@"C-1" andName:@"Spruce-lichen woodland"];
    Fuel *c2 = [[Fuel alloc] initWithAbbreviation:@"C-2" andName:@"Boreal spruce"];
    Fuel *c3 = [[Fuel alloc] initWithAbbreviation:@"C-3" andName:@"Mature jack or loodgepole pine"];
    Fuel *c4 = [[Fuel alloc] initWithAbbreviation:@"C-4" andName:@"Immature jack lodgepole pine"];
    Fuel *c5 = [[Fuel alloc] initWithAbbreviation:@"C-5" andName:@"Red & white pine"];
    Fuel *c6 = [[Fuel alloc] initWithAbbreviation:@"C-6" andName:@"Conifer plantation"];
    Fuel *c7 = [[Fuel alloc] initWithAbbreviation:@"C-7" andName:@"Ponderosa pine - Douglas fir"];
    Fuel *d1 = [[Fuel alloc] initWithAbbreviation:@"D-1" andName:@"Deciduous - Leafless aspen"];
    Fuel *m1 = [[Fuel alloc] initWithAbbreviation:@"M-1" andName:@"Leafless - Boreal mixedwood"];
    Fuel *m2 = [[Fuel alloc] initWithAbbreviation:@"M-2" andName:@"Green - Boreal mixedwood"];
    Fuel *m3 = [[Fuel alloc] initWithAbbreviation:@"M-3" andName:@"Leafless - Dead balsam fir"];
    Fuel *m4 = [[Fuel alloc] initWithAbbreviation:@"M-4" andName:@"Green - Dead balsam fir"];
    Fuel *s1 = [[Fuel alloc] initWithAbbreviation:@"S-1" andName:@"Jack or lodgepole pine slash"];
    Fuel *s2 = [[Fuel alloc] initWithAbbreviation:@"S-2" andName:@"White spruce/balsam slash"];
    Fuel *s3 = [[Fuel alloc] initWithAbbreviation:@"S-3" andName:@"Coastal cedar/hemlock/Douglas fir slash"];
    Fuel *o1a = [[Fuel alloc] initWithAbbreviation:@"O-1a" andName:@"Matted grass"];
    Fuel *o1b = [[Fuel alloc] initWithAbbreviation:@"O-1b" andName:@"Standing grass"];
    
    NSArray *array = [[NSArray alloc]initWithObjects:c1, c2, c3, c4, c5, c6, c7, d1, m1, m2, m3, m4, s1, s2, s3, o1a, o1b, nil];
    
    return array;
}


#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FuelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.object = self.array[indexPath.item];
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Fuel *fuel = self.array[indexPath.item];
    [self.delegate selectFuelType:fuel];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
