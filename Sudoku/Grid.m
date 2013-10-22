//
//  Grid.m
//  Sudoku
//
//  Created by Igal Mizrahi on 10/21/13.
//  Copyright (c) 2013 Igal Mizrahi. All rights reserved.
//

#import "Grid.h"

#import "Macros.h"
#import "Solver.h"

@implementation Grid {
    NSMutableArray * labels;
    UILabel * pointer;
    int ** numbers;
}

- (void)solve {
    Solver * s = [[Solver alloc] initWithCells:numbers];
    if([s solve]) {
        [self highlight:pointer];
        for(int i = 0; i < 9; i++) {
            for(int j = 0; j < 9; j++) {
                UILabel * label = labels[i][j];
                label.text = [NSString stringWithFormat:@"%d",numbers[i][j]];
            }
        }
    }
    else {
        ULog(@"Unsolvable!");
        // Anything else to do here?
    }
}

- (BOOL)validate:(int)val {
    int i = pointer.tag / 9;
    int j = pointer.tag % 9;
    for(int k = 0; k < 9; k++) {
        if(numbers[i][k] == val) return NO;
        if(numbers[k][j] == val) return NO;
    }
    int boxRow = (i / 3) * 3;
    int boxCol = (j / 3) * 3;
    for(int r = 0; r < 3; r++)
        for(int c = 0; c < 3; c++)
            if( numbers[boxRow+r][boxCol+c] == val ) return NO;
    return YES;
}

- (void)clearNumber {
    if(pointer != nil) {
        pointer.text = @"";
        numbers[pointer.tag / 9][pointer.tag % 9] = 0;
    }
}

- (void)setNumber:(NSString *)num {
    if(pointer != nil) {
        if([self validate:[num intValue]]) {
            pointer.text = num;
            numbers[pointer.tag / 9][pointer.tag % 9] = [num intValue];
        }
        else ULog(@"That's an invalid number for this cell");
    }
}

- (void)clearNumbers {
    if(numbers == NULL) { DLog(@"Memory error"); return; }
    for(int i = 0; i < 9; i++) {
        for(int j = 0; j < 9; j++) numbers[i][j] = 0;
    }
}

- (void)clearLabels {
    for(int i = 0; i < self.subviews.count; i++) {
        id obj = [self.subviews objectAtIndex:i]; // Find all UILabels and change their texts
        if([obj isMemberOfClass:[UILabel class]]) [obj setText:@""];
    }
}

- (void) reset {
    //TODO: Stop solving if takes too long
    [self clearLabels];
    [self clearNumbers];
}

- (void) highlight:(UILabel *)label {
    if(pointer != nil) pointer.backgroundColor = [UIColor clearColor];
    if(pointer == label) pointer = nil;
    else {
        label.backgroundColor = HIGHLIGHT;
        pointer = label;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(![touch.view isKindOfClass:[UILabel class]]) return;
    else [self highlight:(UILabel *)touch.view];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    int bound = 297; // frame edge length
    CGFloat bw = 0.9; // border width
    CGFloat cw = bound / 9; // cell edge length
    if (self = [super initWithCoder:aDecoder])
    {
        self.backgroundColor = BACKGROUND;
        pointer = nil;
        labels = [NSMutableArray new];
        for(int i = 0; i < 9; i++) {
            [labels insertObject:[NSMutableArray new] atIndex:i];
            for(int j = 0; j < 9; j++) {
                UILabel * label = [UILabel new];
                label.frame = CGRectIntegral(CGRectMake(bw+j*cw,bw+i*cw,cw,cw)) ;
                label.textColor = DARKTEXT;
                label.textAlignment = NSTextAlignmentCenter;
                label.userInteractionEnabled = YES;
                label.layer.borderWidth = bw;
                label.layer.borderColor = LIGHT.CGColor;
                label.tag = i*9 + j; // Give labels tags from 0 to 80
                [self addSubview:label];
                [labels[i] insertObject:label atIndex:j];
            }
        }
        // Draw 3*3 box borders
        for(int i = 0; i < 10; i+=3) {
            UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, i*cw, bound+1, 2*bw)];
            UIView *vertical   = [[UIView alloc] initWithFrame:CGRectMake(i*cw, 0, 2*bw, bound+1)];
            horizontal.backgroundColor = DARK;
            vertical.backgroundColor = DARK;
            [self addSubview:horizontal];
            [self addSubview:vertical];
        }
        numbers = (int **)malloc(9 * sizeof(int *)); //TODO: dealloc everything when program ends
        for(int i = 0; i < 9; i++) numbers[i] = (int *)malloc(9*sizeof(int));
        [self clearNumbers];
    }
    return self;
}

@end
