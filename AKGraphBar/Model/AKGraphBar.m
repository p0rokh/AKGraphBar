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

/* v1.0.3 */
- (void) drawGraphBarInRect:(CGRect)rect;

- (void) reportErrorMessage:(NSString * _Nonnull) message ;

@end

@implementation AKGraphBar

#pragma mark - init

- (id)initWhithSetting:(AKGraphBarSettings *)settings andDelegate:(id) delegate {
    self = [super init];
    
    if (self) {
        self.settings = [settings copy];
        self.delegate = delegate;
    }
    
    return self;
}

- (id)initWhithSetting:(AKGraphBarSettings *)settings {
    return [self initWhithSetting:settings andDelegate:nil];
}

/* v1.0.3 */
- (void) drawGraphBar {
    if ([_delegate respondsToSelector:@selector(parametersOfTheCanvas:)])  {
       CGRect currentRect = [_delegate parametersOfTheCanvas:self];
        
        if (CGRectEqualToRect(CGRectZero, currentRect) ) {
            [self reportErrorMessage:@"Слишком малые размеры"];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self drawGraphBarInRect:currentRect];
            });
        }
    }
}

#pragma mark - Draw graph bar

- (void) drawGraphBarInRect:(CGRect)rect {
    if (_settings == nil) {
        return;
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

    /* v1.0.3 */
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if ([_delegate respondsToSelector:@selector(graphBar:drawImage:)]) {
            [_delegate graphBar:self drawImage:ctxImage];
        }
        
        if (ctx == nil) {
            [self reportErrorMessage:@"Не удалось отрисовать картинку"];
        }
    }];
}

/* v1.0.3 */
- (void) reportErrorMessage:(NSString *) message {
    if ([_delegate respondsToSelector:@selector(graphBar:errorWithMessage:)]) {
        [_delegate graphBar:self errorWithMessage:message];
    }
}

- (CGRect) columRectAtPoint: (CGPoint) point andHeight: (CGFloat) height {
    return CGRectMake(point.x - ( _settings.widthColums / 2 ), point.y - height - _settings.indent - _settings.sizeMiniLine.height, _settings.widthColums, height);
}

- (CGRect) miniRectAtPoint:(CGPoint) point {
    return CGRectMake(point.x - ( _settings.sizeMiniLine.width / 2), point.y - _settings.sizeMiniLine.height, _settings.sizeMiniLine.width, _settings.sizeMiniLine.height);
}

/* v1.0.3 */
# pragma mark - setter meyhods

- (void) setBackgroundColor:(UIColor *) color {
    if (color) {
        [self.settings setBackground:color];
    }
}

- (void) setColumsLineColor:(UIColor *) color {
    if (color) {
        [self.settings setColumsLineColor:color];
    }
}

- (void) setBottomLineColor:(UIColor *) color {
    if (color) {
        [self.settings setBottomLineColor:color];
    }
}

- (void) setArrayData:(NSArray *) newArray {
    if (newArray) {
        [self.settings setArrayData:newArray];
    }
}

@end
