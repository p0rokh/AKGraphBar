//
//  AKDemoController.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKDemoController.h"
#import "AKGraph.h"


@interface AKDemoController () <AKGraphBarDelegate>

@end

@implementation AKDemoController {
    CGSize imageSize;
    AKGraphBar* graphBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* arrayGraph = [NSArray arrayWithObjects:@100, @220, @56, @154, @310, @197, nil];
    AKGraphBarSettings* setting = [[AKGraphBarSettings alloc] initDefaultWithArrayData:arrayGraph];
    graphBar = [[AKGraphBar alloc] initWhithSetting:setting andDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addGraphAction:(id)sender {

    [self changeSettingsBarRandom];
    [graphBar drawGraphBar];
}

- (void) changeSettingsBarRandom {
    NSInteger type = [self currentRandomFromMinimum:0 toMaximum:3];
    NSUInteger count = [self currentRandomFromMinimum:3 toMaximum:14];
    NSMutableArray* randomArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int index = 0; index < count; index++) {
        NSUInteger randomeNumber = [self currentRandomFromMinimum:150 toMaximum:500];
        randomArray[index] = [NSNumber numberWithUnsignedInteger:randomeNumber];
    }
    
    [graphBar setArrayData:randomArray];
    
    switch (type) {
        case 0:
            [graphBar.settings setBackground:[self randomeColor]];
            break;
            
        case 1:
            [graphBar.settings setBottomLineColor:[self randomeColor]];
            break;
        case 2:
            [graphBar.settings setColumsLineColor:[self randomeColor]];
            break;
            
        default:
            break;
    }
}

# pragma mark - delegate method AK Graph Bar delegate

-(CGRect)sizeOfImageInGraphBar:(AKGraphBar *)graphBar {
    if (_graphImageView) {
        return _graphImageView.bounds;
    }
    
    return CGRectZero;
}

- (void)graphBar:(AKGraphBar *)graphBar drawImage:(UIImage *)image {
    _graphImageView.image = image;
}

- (void) graphBar:(AKGraphBar *)graphBar errorWithMessage:(NSString *)message {
    NSLog(@"--->ERROR graph bar message: %@", message);
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
