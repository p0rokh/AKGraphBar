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

    NSArray* arrayGraph = [NSArray arrayWithObjects:@10, @120, @56, @154, @110, @97, nil];
    AKGraphBarSettings* setting = [[AKGraphBarSettings alloc] initDefaultWithArrayData:arrayGraph];
    AKGraphBar* graphBar = [[AKGraphBar alloc] initWhithSetting:setting];
    
    UIImage* image = [graphBar drawGraphBarInRect:_graphImageView.bounds];

    _graphImageView.image = image;
}

-(void)viewDidLayoutSubviews {
    NSArray* arrayGraph = [NSArray arrayWithObjects:@10, @120, @56, @154, @110, @97, nil];
    AKGraphBarSettings* setting = [[AKGraphBarSettings alloc] initDefaultWithArrayData:arrayGraph];
    AKGraphBar* graphBar = [[AKGraphBar alloc] initWhithSetting:setting];
    
    UIImage* image = [graphBar drawGraphBarInRect:_graphImageView.bounds];
    
    _graphImageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
