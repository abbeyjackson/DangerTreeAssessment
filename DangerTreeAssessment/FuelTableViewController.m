//
//  FuelTableViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "FuelTableViewController.h"

@interface FuelTableViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation FuelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureFuelTable];
}

-(void)configureFuelTable{
    self.array = [[NSArray alloc] initWithObjects:@"Coniferous - C1 - Spruce-lichen woodland",
                  @"Coniferous - C-2 - Boreal spruce",
                  @"Coniferous - C-3 - Mature jack or loodgepole pine",
                  @"Coniferous - C-4 - Immature jack lodgepole pine",
                  @"Coniferous - C-5 - Red & white pine",
                  @"Coniferous - C-6 - Conifer plantation",
                  @"Coniferous - C-7 - Ponderosa pine - Douglas fir",
                  @"Deciduous - D-1 - Leafless aspen",
                  @"Mixedwood - M-1 - Boreal mixedwood - leafless",
                  @"Mixedwood - M-2 - Boreal mixedwood - green",
                  @"Mixedwood - M-3 - Dead balsam fir mixedwood - leafless",
                  @"Mixedwood - M-4 - Dead balsam fir mixedwood - green",
                  @"Slash - S-1 - Jack or lodgepole pine slash",
                  @"Slash - S-2 - White spruce/balsam slash",
                  @"Slash - S-3 - Coastal cedar/hemlock/Douglas fir slash",
                  @"Open - O-1a - Matted grass",
                  @"Open - O-1b - Standing grass",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *fuel = self.array[indexPath.row];

    cell.textLabel.text = fuel;
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
