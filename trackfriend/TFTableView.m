//
//  TFTableView.m
//  trackfriend
//
//  Created by Ming Zhou on 12-02-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFTableView.h"
#import "TFAppDelegate.h"
#import "TFPersonClass.h"
#import "TFMapView.h"

#import "TZPersonViewCell.h"

@implementation TFTableView
@synthesize personAry;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    personAry = UIAppDelegate.personAry;
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(Edit:)];
    self.navigationItem.rightBarButtonItem = editBtn;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    personAry = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)aTableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.personAry count];
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UINib *nib = [UINib nibWithNibName:@"TZPersonViewCell" bundle:nil];
    [aTableView registerNib:nib forCellReuseIdentifier:cellId];
    
    TZPersonViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:
                           cellId];
    if (cell == nil) {
        cell = [[TZPersonViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSUInteger row = [indexPath row];
    NSUInteger reverserow = [personAry count] - row - 1;
    TFPersonClass *rowData = [personAry objectAtIndex:reverserow];
    
    // Storing information into the cell
    cell.nameLabel.text = [NSString stringWithFormat:@"%@, %@", rowData.lastName, rowData.firstName];
    cell.numberLabel.text = [NSString stringWithFormat:@"%@", rowData.phoneNumber];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60; // Same number we used in Interface Builder
}

- (void)tableView:(UITableView *)aTableView  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger reverserow = [personAry count] - indexPath.row - 1;
        [personAry removeObjectAtIndex:reverserow];
        [tableView reloadData];
        [UIAppDelegate storeData];
        
    }
}

- (BOOL)tableView:(UITableView *)aTableView   canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)aTableView  moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    NSUInteger reversefrom = [personAry count] - fromIndexPath.row - 1;
    NSUInteger reverseto = [personAry count] - toIndexPath.row - 1;
    NSString *item = [[personAry objectAtIndex:reversefrom] copy];
    [personAry removeObject:item];
    [personAry insertObject:item atIndex:reverseto];
    [UIAppDelegate storeData];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TFMapView *mapView = [[TFMapView alloc] initWithNibName:@"TFMapView" bundle:nil];
    NSUInteger reverserow = [personAry count] - indexPath.row - 1;
    mapView.person = [personAry objectAtIndex:reverserow];
    mapView.isScanMode = 0;
    [self.navigationController pushViewController:mapView animated:YES];
    [tableView reloadData];
    mapView = nil;
}

#pragma mark - Edit Mode
- (IBAction) Edit:(id)sender{
    if (self.editing) {
        [self setEditing:NO animated:NO];
        [tableView setEditing:NO animated:NO];
        [tableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else {
        [self setEditing:YES animated:YES];
        [tableView setEditing:YES animated:YES];
        [tableView reloadData];        
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}


@end
