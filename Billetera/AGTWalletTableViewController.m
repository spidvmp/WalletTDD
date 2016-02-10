//
//  AGTWalletTableViewController.m
//  Billetera
//
//  Created by Vicente de Miguel on 6/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"
#import "AGTBroker.h"

@interface AGTWalletTableViewController ()

@property(strong,nonatomic) AGTWallet *model;
@property(strong,nonatomic) AGTBroker *broker;
@end

@implementation AGTWalletTableViewController

-(id)initWithModel:(AGTWallet *) model{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _model = model;
        _broker = [[AGTBroker alloc] init];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //pongo las relaciones que puse en el appdelegate
    [self.broker addRate:2 fromCurrency:@"USD" toCurrency:@"EUR"];
    [self.broker addRate:3 fromCurrency:@"JPY" toCurrency:@"EUR"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //he de saber cuantas monedas diferentes hay y devolver las que hay mas 1

    return [[self.model currencies] count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return [self.model count] + 1;
    NSArray *monedas = [self.model currencies];
    if ( section >= [monedas count])
        return 1;
    else {
        //devuelvo una fiula mas de las que hay xq hay que poner el total de la divisa
        return [[self.model billsFromCurrency:[monedas objectAtIndex:section] ] count] +1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Celda";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    NSArray *monedas = [self.model currencies];
    if ( indexPath.section >= [monedas count])
        cell.textLabel.text = [NSString stringWithFormat:@"totales: %ld EUR", [self.model sumWalletInCurrency:@"EUR" andBroker:self.broker]];
    else {
        //compruebo si es la ultima row para poner el total de la divisa o no
        //este if no lo he hecho nunca, petar no peta, pero se puede/debe hacer esto?
        if ( [self tableView:tableView numberOfRowsInSection:indexPath.section] == (indexPath.row +1)) {
            //hay que poner el total
            cell.textLabel.text = [NSString stringWithFormat:@"Subtotal: %ld",[self.model sumCurrency:[monedas objectAtIndex:indexPath.section]]];

            
        } else {
            
            
            AGTMoney *moneda = [[self.model billsFromCurrency:[monedas objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld %@",[moneda.amount integerValue], moneda.currency];

        }
    }
    
    return cell;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    //saco el listado ordenado de las currencies
    //compruebo si me estan pidiendo la ultima seccion
    NSArray *monedas = [self.model currencies];
    if ( section >= [monedas count])
        return @"Total";
    else {
        return [monedas objectAtIndex:section];
    }
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
