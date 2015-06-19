//
//  TreeClassCollectionViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeClassCollectionViewController.h"
#import "TreeClassCollectionViewCell.h"
#import "Tree.h"
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
    
    TreeClass *c1 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer1.png"] numAndInfo:@"C1 - Live"];
    TreeClass *c2 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer2.png"] numAndInfo:@"C2 - Live"];
    TreeClass *c3 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer3.png"] numAndInfo:@"C3 - Dead - Hard"];
    TreeClass *c4 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer4.png"] numAndInfo:@"C4 - Dead - Hard"];
    TreeClass *c5 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer5.png"] numAndInfo:@"C5 - Dead - Hard"];
    TreeClass *c6 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer6.png"] numAndInfo:@"C6 - Dead - Spongy"];
    TreeClass *c7 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer7.png"] numAndInfo:@"C7 - Dead - Soft"];
    TreeClass *c8 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer8.png"] numAndInfo:@"C8 - Dead - Soft"];
    TreeClass *c9 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer9.png"] numAndInfo:@"C9 - Dead Fallen"];
    TreeClass *h1 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood1.png"] numAndInfo:@"H1 - Live"];
    TreeClass *h2 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood2.png"] numAndInfo:@"H2 - Live"];
    TreeClass *h3 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood3.png"] numAndInfo:@"H3 - Dead"];
    TreeClass *h4 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood4.png"] numAndInfo:@"H4 - Dead"];
    TreeClass *h5 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood5.png"] numAndInfo:@"H5 - Dead"];
    TreeClass *h6 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"hardwood6.png"] numAndInfo:@"H6 - Dead Fallen"];
    
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TreeClass *class = self.array[indexPath.item];
    [self.delegate selectClass:class];
    [self.navigationController popViewControllerAnimated:YES];
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
