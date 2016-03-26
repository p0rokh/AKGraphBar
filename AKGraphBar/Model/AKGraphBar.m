//
//  AKGraphBar.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKGraphBar.h"

@interface AKGraphBar ()

/* Obtain the correct rect for the pillars */
- (CGRect) columRectAtPoint: (CGPoint) point andHeight: (CGFloat) height;

/* Get the correct rect for dashes */
- (CGRect) miniRectAtPoint:(CGPoint) point;

@end

@implementation AKGraphBar

#pragma mark - init

- (id)initWhithSetting:(AKGraphBarSettings *)settings {
    self = [super init];
    
    if (self) {
        self.settings = [settings copy];
    }
    return self;
}

#pragma mark - Draw graph bar

- (UIImage *)drawGraphBarInRect:(CGRect)rect {
    if (_settings == nil) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    
    // First we learn the maximum value in the array
    CGFloat Hmax = _settings.maxHeightColum;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Creating color our canvas and paint over it.
    CGContextSetFillColorWithColor(ctx, [_settings.background CGColor]);
    CGContextFillRect(ctx, rect);
    
    // Default settings
    CGFloat kYLine = rect.size.height - _settings.indentBottomLine; // Самая нижняя точка
    CGFloat W = rect.size.width; // Общая ширина контента
    CGFloat kHmax = kYLine - _settings.indent - _settings.sizeMiniLine.height - _settings.indentTopLine; // Максимальный размер отведенный под столбик

    // Adjust the width of the column and dashes
    CGFloat maxMiniline = W / ((CGFloat) _settings.numberColums + 1 );
    if (_settings.sizeMiniLine.width >= maxMiniline) {
        _settings.sizeMiniLine = CGSizeMake(maxMiniline - _settings.indent, _settings.sizeMiniLine.height);
        _settings.widthColums = ( maxMiniline - _settings.indent );
    }
    
    NSArray* currentArray = _settings.arrayData;

    // Draw a line in the form of a dash indented
    for (int index = 1 ; index <= _settings.numberColums; index++) {
        CGFloat kX = (CGFloat)index;
        CGFloat kColums = (CGFloat)(_settings.numberColums + 1);
        
        // Vertical column around which to build
        CGPoint center = CGPointMake((kX * W) / kColums, kYLine);
        
        // Coordinates dashes
        CGRect rectMINIline = [self miniRectAtPoint:center];
        
        // Нарисуем черточку
        CGContextSetFillColorWithColor(ctx, [_settings.bottomLineColor CGColor]);
        CGContextFillRect(ctx, rectMINIline);
        
        if ( index <= currentArray.count ) {
            // We calculate the correct height for our colum within the permissible heights
            NSNumber* h = (NSNumber *)currentArray[index - 1];
            CGFloat procent =  ( h.floatValue * 100.0f ) / Hmax;
            CGFloat currentHeghtColum = ( procent * kHmax ) / 100 ;
            
            // Coordinates column
            CGRect rectColum =  [self columRectAtPoint:center andHeight:currentHeghtColum];

            // Draw bar with roundels
            UIBezierPath* columPath = [UIBezierPath bezierPathWithRoundedRect:rectColum byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];
            
            CGContextSetFillColorWithColor(ctx, [_settings.columsLineColor CGColor]);
            
            [columPath fill];
        
        }
    }
    
    UIImage* ctxImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return ctxImage;
}

- (CGRect) columRectAtPoint: (CGPoint) point andHeight: (CGFloat) height {
    return CGRectMake(point.x - ( _settings.widthColums / 2 ), point.y - height - _settings.indent - _settings.sizeMiniLine.height, _settings.widthColums, height);
}

- (CGRect) miniRectAtPoint:(CGPoint) point {
    return CGRectMake(point.x - ( _settings.sizeMiniLine.width / 2), point.y - _settings.sizeMiniLine.height, _settings.sizeMiniLine.width, _settings.sizeMiniLine.height);
}

@end
