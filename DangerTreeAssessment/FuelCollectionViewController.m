//
//  FuelCollectionViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-18.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "FuelCollectionViewController.h"
#import "Fuel.h"
#import "FuelCollectionViewCell.h"

@interface FuelCollectionViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation FuelCollectionViewController

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
    
    Fuel *c1 = [[Fuel alloc] initWithAbbreviation:@"C-1" andName:@"Coniferous - Spruce-lichen woodland"];
    Fuel *c2 = [[Fuel alloc] initWithAbbreviation:@"C-2" andName:@"Coniferous - Boreal spruce"];
    Fuel *c3 = [[Fuel alloc] initWithAbbreviation:@"C-3" andName:@"Coniferous - Mature jack or loodgepole pine"];
    Fuel *c4 = [[Fuel alloc] initWithAbbreviation:@"C-4" andName:@"Coniferous - Immature jack lodgepole pine"];
    Fuel *c5 = [[Fuel alloc] initWithAbbreviation:@"C-5" andName:@"Coniferous - Red & white pine"];
    Fuel *c6 = [[Fuel alloc] initWithAbbreviation:@"C-6" andName:@"Coniferous - Conifer plantation"];
    Fuel *c7 = [[Fuel alloc] initWithAbbreviation:@"C-7" andName:@"Coniferous - Ponderosa pine - Douglas fir"];
    Fuel *d1 = [[Fuel alloc] initWithAbbreviation:@"D-1" andName:@"Deciduous - Leafless aspen"];
    Fuel *m1 = [[Fuel alloc] initWithAbbreviation:@"M-1" andName:@"Mixedwood - Boreal mixedwood - leafless"];
    Fuel *m2 = [[Fuel alloc] initWithAbbreviation:@"M-2" andName:@"Mixedwood - Boreal mixedwood - green"];
    Fuel *m3 = [[Fuel alloc] initWithAbbreviation:@"M-3" andName:@"Mixedwood - Dead balsam fir mixedwood - leafless"];
    Fuel *m4 = [[Fuel alloc] initWithAbbreviation:@"M-4" andName:@"Mixedwood - Dead balsam fir mixedwood - green"];
    Fuel *s1 = [[Fuel alloc] initWithAbbreviation:@"S-1" andName:@"Slash - Jack or lodgepole pine slash"];
    Fuel *s2 = [[Fuel alloc] initWithAbbreviation:@"S-2" andName:@"Slash - White spruce/balsam slash"];
    Fuel *s3 = [[Fuel alloc] initWithAbbreviation:@"S-3" andName:@"Slash - Coastal cedar/hemlock/Douglas fir slash"];
    Fuel *o1a = [[Fuel alloc] initWithAbbreviation:@"O-1a" andName:@"Open - Matted grass"];
    Fuel *o1b = [[Fuel alloc] initWithAbbreviation:@"O-1b" andName:@"Open - Standing grass"];
    
    NSArray *array = [[NSArray alloc]initWithObjects:c1, c2, c3, c4, c5, c6, c7, d1, m1, m2, m3, m4, s1, s2, s3, o1a, o1b, nil];
    
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FuelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.object = self.array[indexPath.item];

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

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
