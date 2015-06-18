//
//  TreeSpeciesCollectionViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeSpeciesCollectionViewController.h"
#import "TreeSpecies.h"
#import "TreeSpeciesCollectionViewCell.h"


@interface TreeSpeciesCollectionViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation TreeSpeciesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [[NSArray alloc]initWithArray:[self makeArray]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TreeSpeciesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.object = self.array[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 15, 15, 5);
}


/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
