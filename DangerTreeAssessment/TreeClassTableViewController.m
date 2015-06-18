//
//  TreeClassTableViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeClassTableViewController.h"
#import "TreeClass.h"
#import "TreeClassTableViewCell.h"

@interface TreeClassTableViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation TreeClassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSArray alloc]initWithArray:[self makeArray]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

-(NSArray*)makeArray{
    
    TreeClass *conifer1 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer1.png"] numAndInfo:@"1 - Live" andDetails:@"Healthy: no decay or structural damage"];
    TreeClass *conifer2 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer2.png"] numAndInfo:@"2 - Live" andDetails:@"Unhealthy: internal decay or growth deformities or other structural damage; dying tree"];
    TreeClass *conifer3 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer3.png"] numAndInfo:@"3 - Dead - Hard" andDetails:@"Recently dead, needles or fine twigs present"];
    TreeClass *conifer4 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer4.png"] numAndInfo:@"4 - Dead - Hard" andDetails:@"No needles / twigs; 50% of branches lost; only larger limbs remain, often loose bark."];
    TreeClass *conifer5 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer5.png"] numAndInfo:@"5 - Dead - Hard" andDetails:@"Most branches / bark absent, some internal decay"];
    TreeClass *conifer6 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer6.png"] numAndInfo:@"6 - Dead - Spongy" andDetails:@"Very little branches or bark, sapwood/heartwood may be sloughing from upper bole, decay more advanced, lateral roots of larger trees usually softening"];
    TreeClass *conifer7 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer7.png"] numAndInfo:@"7 - Dead - Soft" andDetails:@"Extensive internal decay, outer shell may be hard, lateral roots usually completely decomposed, hollow or nearly hollow shells"];
    TreeClass *conifer8 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer8.png"] numAndInfo:@"8 - Dead - Soft" andDetails:@"Extensive internal decay, outer shell may be hard, lateral roots usually completely decomposed, hollow or nearly hollow shells"];
    TreeClass *conifer9 = [[TreeClass alloc] initWithImage:[UIImage imageNamed:@"conifer9.png"] numAndInfo:@"9 - Dead Fallen" andDetails:@"Downed trees or stumps"];
    
    NSArray *array = [[NSArray alloc]initWithObjects:conifer1, conifer2, conifer3, conifer4, conifer5, conifer6, conifer7, conifer8, conifer9, nil];
    
    return array;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.object = self.array[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
