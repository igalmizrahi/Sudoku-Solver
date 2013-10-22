//
//  Solver.m
//  Sudoku
//
//  Created by Igal Mizrahi on 10/21/13.
//  Copyright (c) 2013 Igal Mizrahi. All rights reserved.
//

#import "Solver.h"

#define next(i,j)         [self nextRow:i column:j]
#define solve(i,j)        [self solveRow:i column:j]
#define validate(i,j,val) [self validateRow:i column:j value:val]

@implementation Solver {
    int ** cells;
}

- (id)init {
    NSLog(@"Call me with int**");
    return nil;
}

- (id)initWithCells:(int **)_cells {
    if(self = [super init]) {
        cells = _cells;
    }
    return self;
}

- (BOOL)solve {
    return solve(0,0);
}

- (BOOL) solveRow:(int)i column:(int)j {
    if(i == 9) return YES; // Solution found!!!
    if(cells[i][j] != 0) return next(i,j);
    for(int k = 1; k <= 9; k++) {
        if(validate(i,j,k)) {
            cells[i][j] = k;
            if(next(i,j)) return YES;
        }
    }
    cells[i][j] = 0;
    return NO;
}

- (BOOL) validateRow:(int)i column:(int)j value:(int)val {
    for(int k = 0; k < 9; k++) {
        if(cells[i][k] == val) return NO;
        if(cells[k][j] == val) return NO;
    }
    int boxRow = (i / 3) * 3;
    int boxCol = (j / 3) * 3;
    for(int r = 0; r < 3; r++)
        for(int c = 0; c < 3; c++)
            if( cells[boxRow+r][boxCol+c] == val ) return NO;
    return YES;
}

- (BOOL) nextRow:(int)i column:(int)j {
    if( j < 8 ) return solve(i , j + 1);
    else        return solve(i + 1 , 0);
}

@end
