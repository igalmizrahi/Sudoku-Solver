//
//  ViewController.m
//  Sudoku
//
//  Created by Igal Mizrahi on 10/21/13.
//  Copyright (c) 2013 Igal Mizrahi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)resetPressed {
    [_grid reset];
}

- (IBAction)solvePressed {
    [_grid solve];
}

- (IBAction)clearPressed {
    [_grid clearNumber];
}

- (IBAction)numberPressed:(UIButton *)sender {
    [_grid setNumber:sender.currentTitle];
}

- (BOOL)shouldAutorotate { return NO; }

@end
