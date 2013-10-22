//
//  Solver.h
//  Sudoku
//
//  Created by Igal Mizrahi on 10/21/13.
//  Copyright (c) 2013 Igal Mizrahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Solver : NSObject

- (id)initWithCells:(int **)cells;

- (BOOL)solve;

@end
