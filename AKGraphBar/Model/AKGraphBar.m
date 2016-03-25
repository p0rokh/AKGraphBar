//
//  AKGraphBar.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKGraphBar.h"

@implementation AKGraphBar

#pragma mark - init

- (id)initWhithSetting:(AKGraphBarSettings *)settings {
    self = [super init];
    
    if (self) {
        self.settings = settings;
    }
    return self;
}

- (UIImage *)drawGraphBarInRect:(CGRect)rect {
    if (_settings == nil) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    
    // Первым делом узнаем максимальное значение в массиве
//    let Hmax = maximumHeight(array)
    
//    let ref = UIGraphicsGetCurrentContext()
    
    
    return nil;
}

@end
