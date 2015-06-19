//
//  TreeClassCollectionViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeClassCollectionViewController.h"
#import "TreeClass.h"
#import "TreeClassCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface TreeClassCollectionViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation TreeClassCollectionViewController

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
    
    TreeClass *c1 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer1.png"] numAndInfo:@"1 - Live" andDetails:@"Healthy: no decay or structural damage"];
    TreeClass *c2 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer2.png"] numAndInfo:@"2 - Live" andDetails:@"Unhealthy: internal decay or growth deformities or other structural damage; dying tree"];
    TreeClass *c3 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer3.png"] numAndInfo:@"3 - Dead - Hard" andDetails:@"Recently dead, needles or fine twigs present"];
    TreeClass *c4 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer4.png"] numAndInfo:@"4 - Dead - Hard" andDetails:@"No needles / twigs; 50% of branches lost; only larger limbs remain, often loose bark."];
    TreeClass *c5 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer5.png"] numAndInfo:@"5 - Dead - Hard" andDetails:@"Most branches / bark absent, some internal decay"];
    TreeClass *c6 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer6.png"] numAndInfo:@"6 - Dead - Spongy" andDetails:@"Very little branches or bark, sapwood/heartwood may be sloughing from upper bole, decay more advanced, lateral roots of larger trees usually softening"];
    TreeClass *c7 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer7.png"] numAndInfo:@"7 - Dead - Soft" andDetails:@"Extensive internal decay, outer shell may be hard, lateral roots usually completely decomposed, hollow or nearly hollow shells"];
    TreeClass *c8 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer8.png"] numAndInfo:@"8 - Dead - Soft" andDetails:@"Extensive internal decay, outer shell may be hard, lateral roots usually completely decomposed, hollow or nearly hollow shells"];
    TreeClass *c9 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer9.png"] numAndInfo:@"9 - Dead Fallen" andDetails:@"Downed trees or stumps"];
    TreeClass *h1 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood1.png"] numAndInfo:@"1 - Live" andDetails:nil];
    TreeClass *h2 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood2.png"] numAndInfo:@"2 - Live" andDetails:nil];
    TreeClass *h3 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood3.png"] numAndInfo:@"3 - Dead" andDetails:nil];
    TreeClass *h4 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood4.png"] numAndInfo:@"4 - Dead" andDetails:nil];
    TreeClass *h5 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood5.png"] numAndInfo:@"5 - Dead" andDetails:nil];
    TreeClass *h6 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood6.png"] numAndInfo:@"6 - Dead Fallen" andDetails:nil];
    
    NSArray *array = [[NSArray alloc]initWithObjects:c1, c2, c3, c4, c5, c6, c7, c8, c9, h1, h2, h3, h4, h5, h6, nil];
    
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
    TreeClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
     
    cell.object = self.array[indexPath.item];
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor darkGrayColor].CGColor;
    
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
