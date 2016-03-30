//
//  AKBulderGraph.m
//  AKGraphBar
//
//  Created by Anton Korolev on 28.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKBulderGraph.h"

NSString* const AKBuilderBackgroundColor = @"AKBuilderBackgroundColor";
NSString* const AKBuilderBottomLineColor = @"AKBuilderBottomLineColor";
NSString* const AKBuilderColumsLineColor = @"AKBuilderColumsLineColor";
NSString* const AKBuilderArrayData       = @"AKBuilderArrayData";

@interface AKBulderGraph()

- (void) update: ( AKGraphBar * ) graphBar;

- (UIColor *) randomeColor;
- (NSUInteger) currentRandomFromMinimum:(NSUInteger) min toMaximum: (NSUInteger) max;

@end

@implementation AKBulderGraph

-(void) changeSettingsGraphBar:(AKGraphBar *)graphBar
                withParameters:(NSDictionary *) parameters
             andToDrawGraphBar:(BOOL) toDraw {
    
    
    UIColor* colorBackground = [parameters objectForKey:AKBuilderBackgroundColor];
    UIColor* colorBottomLine = [parameters objectForKey:AKBuilderBottomLineColor];
    UIColor* colorColumsLine = [parameters objectForKey:AKBuilderColumsLineColor];
    AKArray* arrayData       = [parameters objectForKey:AKBuilderArrayData];

    if (colorBackground) [graphBar setBackgroundColor:colorBackground];
    if (colorBottomLine) [graphBar setBottomLineColor:colorBottomLine];
    if (colorColumsLine) [graphBar setColumsLineColor:colorColumsLine];
    if (arrayData)       [graphBar setArrayData:arrayData];
    
    if (toDraw) [graphBar drawGraphBar];
}

-(void)changeSettingsBarRandom:(AKGraphBar *)graphBar {
    __weak typeof (self) weekSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        typeof (self) strongSelf = weekSelf;
        if (!strongSelf) {
            return;
        }
         
        @synchronized (strongSelf) {
            [strongSelf update:graphBar];
        }
    });
}

- (void) update: ( AKGraphBar * ) graphBar {
    NSInteger type = [self currentRandomFromMinimum:0 toMaximum:3];
    NSUInteger count = [self currentRandomFromMinimum:3 toMaximum:14];
    NSMutableArray* randomArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int index = 0; index < count; index++) {
        NSUInteger randomeNumber = [self currentRandomFromMinimum:150 toMaximum:500];
        randomArray[index] = [NSNumber numberWithUnsignedInteger:randomeNumber];
    }

    [graphBar setArrayData:randomArray];
    
    /* v1.1.6 - [graphBar.settings setMethod:[self randomeColor]]; */
    switch (type) {
        case 0:
            [graphBar setBackgroundColor:[self randomeColor]];
            break;
            
        case 1:
            [graphBar setBottomLineColor:[self randomeColor]];
            break;
        
        case 2:
            [graphBar setColumsLineColor:[self randomeColor]];
            break;
            
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @synchronized(graphBar) {
            [graphBar drawGraphBar];
        }
    });
}

#pragma mark - random
- (UIColor *) randomeColor {
    NSUInteger random = [self currentRandomFromMinimum:0 toMaximum:3];
    
    if (random < 1) {
        return [UIColor greenColor];
    }else if (random < 2) {
        return [UIColor redColor];
    }else {
        return [UIColor yellowColor];
    }
}

- (NSUInteger) currentRandomFromMinimum:(NSUInteger) min toMaximum: (NSUInteger) max {
    NSUInteger randomNum = 0;
    arc4random_buf(&randomNum, sizeof(NSUInteger));
    
    return min + (randomNum % (max - min));
}

@end
