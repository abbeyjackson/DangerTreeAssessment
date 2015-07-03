//
//  TreeSpeciesCollectionViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeSpeciesCollectionViewController.h"

#import "Constants.h"

#import "TreeSpecies.h"
#import "TreeSpeciesCollectionViewCell.h"

#import <QuartzCore/QuartzCore.h>


@interface TreeSpeciesCollectionViewController ()


@property (strong, nonatomic) NSArray *array;


@end


@implementation TreeSpeciesCollectionViewController


static NSString * const reuseIdentifier = @"Cell";


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSArray alloc]initWithArray:[self makeArray]];
}


#pragma mark - Setup

-(NSArray*)makeArray{
    TreeSpecies *fd = [[TreeSpecies alloc] initWithAbbreviation:@"Fd" andName:@"Douglas-Fir"];
    TreeSpecies *lw = [[TreeSpecies alloc] initWithAbbreviation:@"Lw" andName:@"Western larch"];
    TreeSpecies *pl = [[TreeSpecies alloc] initWithAbbreviation:@"Pl" andName:@"Lodgepole pine"];
    TreeSpecies *py = [[TreeSpecies alloc] initWithAbbreviation:@"Py" andName:@"Ponderosoas pine"];
    TreeSpecies *pw = [[TreeSpecies alloc] initWithAbbreviation:@"Pw" andName:@"Western white pine"];
    TreeSpecies *sw = [[TreeSpecies alloc] initWithAbbreviation:@"Sw" andName:@"White spruce"];
    TreeSpecies *se = [[TreeSpecies alloc] initWithAbbreviation:@"Se" andName:@"Engelmann spruce"];
    TreeSpecies *ss = [[TreeSpecies alloc] initWithAbbreviation:@"Ss" andName:@"Sitka spruce"];
    TreeSpecies *bl = [[TreeSpecies alloc] initWithAbbreviation:@"Bl" andName:@"Subalpine fir"];
    TreeSpecies *ba = [[TreeSpecies alloc] initWithAbbreviation:@"Ba" andName:@"Amabillis fir"];
    TreeSpecies *bg = [[TreeSpecies alloc] initWithAbbreviation:@"Bg" andName:@"Grand fir"];
    TreeSpecies *hw = [[TreeSpecies alloc] initWithAbbreviation:@"Hw" andName:@"Western hemlock"];
    TreeSpecies *cw = [[TreeSpecies alloc] initWithAbbreviation:@"Cw" andName:@"Western redcedar"];
    TreeSpecies *cy = [[TreeSpecies alloc] initWithAbbreviation:@"Cy" andName:@"Yellow cedar"];
    TreeSpecies *ac = [[TreeSpecies alloc] initWithAbbreviation:@"Ac" andName:@"Black cottonwood"];
    TreeSpecies *at = [[TreeSpecies alloc] initWithAbbreviation:@"At" andName:@"Trembling Aspen"];
    TreeSpecies *ep = [[TreeSpecies alloc] initWithAbbreviation:@"Ep" andName:@"Paper birch"];
    TreeSpecies *dr = [[TreeSpecies alloc] initWithAbbreviation:@"Dr" andName:@"Red alder"];
    TreeSpecies *mb = [[TreeSpecies alloc] initWithAbbreviation:@"Mb" andName:@"Maple"];
    
    NSArray *array = [[NSArray alloc]initWithObjects:fd, lw, pl, py, pw, sw, se, ss, bl, ba, bg, hw, cw, cy, ac, at, ep, dr, mb, nil];
    
    return array;
}


#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TreeSpeciesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.object = self.array[indexPath.item];
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TreeSpecies *species = self.array[indexPath.item];
    [self.delegate selectSpecies:species];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
