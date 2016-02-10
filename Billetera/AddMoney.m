//
//  AddMoney.m
//  Billetera
//
//  Created by Vicente de Miguel on 10/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "AddMoney.h"
#import "AGTMoney.h"

@interface AddMoney ()

@property (strong,nonatomic) UITextField *moneda;
@property (strong,nonatomic) UITextField *cantidad;
@property (strong,nonatomic) UITextField *relacion;
@property (strong,nonatomic) UIButton *done;

@end

@implementation AddMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //creo y no compruebo nada
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.moneda = [[UITextField alloc]initWithFrame:CGRectMake(20, 50, 200, 40)];
    self.cantidad = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 200, 40)];
    self.relacion = [[UITextField alloc]initWithFrame:CGRectMake(20, 150, 200, 40)];
    self.done = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, 100, 40)];
    [self.done setTitle:@"Done" forState:UIControlStateNormal];
    self.done.backgroundColor = [UIColor greenColor];
    [self.done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moneda.placeholder = @"identificacion moneda";
    self.cantidad.placeholder = @"un numero entero";
    self.relacion.placeholder = @"la misma que ya hubiera";
    [self.view addSubview:self.moneda];
    [self.view addSubview:self.cantidad];
    [self.view addSubview:self.relacion];
    [self.view addSubview:self.done];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //self.money = [[AGTMoney alloc]initWithAmount:[self.cantidad.text integerValue] currency:self.moneda.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)done:(id)sender {
    [self.delegate dismissWithCurrency:self.moneda.text amount:[self.cantidad.text integerValue] andRate:[self.relacion.text integerValue]];
    
}

@end
