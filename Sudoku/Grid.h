//
//  Grid.h
//  Sudoku
//
//  Created by Igal Mizrahi on 10/21/13.
//  Copyright (c) 2013 Igal Mizrahi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Grid : UIView

- (void)solve;

- (void)clearNumber;

- (void)setNumber:(NSString *)num;

- (void)reset;

@end

