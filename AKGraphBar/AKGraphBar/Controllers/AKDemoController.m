//
//  AKDemoController.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKDemoController.h"
#import "AKGraph.h"


@interface AKDemoController ()

@end

@implementation AKDemoController {
    CGSize imageSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addGraphAction:(id)sender {
    NSArray* arrayGraph = [NSArray arrayWithObjects:@100, @220, @56, @154, @310, @197, nil];
    AKGraphBarSettings* setting = [[AKGraphBarSettings alloc] initDefaultWithArrayData:arrayGraph];
    AKGraphBar* graphBar = [[AKGraphBar alloc] initWhithSetting:setting];
    
    UIImage* image = [graphBar drawGraphBarInRect:_graphImageView.bounds];
    
    _graphImageView.image = image;
    
}

@end
