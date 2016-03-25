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
    CGFloat Hmax = _settings.maxHeightColum;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Созданим цвет нашего полотна и закрасим его.
    CGContextSetFillColorWithColor(ctx, [_settings.background CGColor]);
    CGContextFillRect(ctx, rect);
    
    // Дефолтные настройки
    CGFloat kYLine = rect.size.height - _settings.indentBottomLine; // Самая нижняя точка
    CGFloat W = rect.size.width; // Общая ширина контента
    CGFloat kHmax = kYLine - _settings.indent - _settings.sizeMiniLine.height - _settings.indentTopLine; // Максимальный размер отведенный под столбик
    
    // Корректируем ширину черкаша и столбика
    CGFloat maxMiniline = W / ((CGFloat) _settings.numberColums + 1 );
    if (_settings.sizeMiniLine.width >= maxMiniline) {
        _settings.sizeMiniLine = CGSizeMake(maxMiniline - _settings.indent, _settings.sizeMiniLine.height);
        _settings.widthColums = ( maxMiniline - _settings.indent );
    }
    
    NSArray* currentArray = _settings.arrayData;

    // Рисуем линию в виде тире с отступом
    for (int index = 1 ; index <= _settings.numberColums; index++) {
        CGFloat kX = (CGFloat)index;
        CGFloat kColums = (CGFloat)(_settings.numberColums + 1);
        
        // Вертикаль вокруг которой строиться столбец
        CGPoint center = CGPointMake((kX * W) / kColums, kYLine);
        
        // Координаты черкаша
        CGRect rectMINIline = [self miniRectAtPoint:center];
        
        // Отрисуем черкаш
        CGContextSetFillColorWithColor(ctx, [_settings.bottomLineColor CGColor]);
        CGContextFillRect(ctx, rectMINIline);
        
        if ( index <= currentArray.count ) {
            // Вычисляем корректную высоту для нашего столбика в пределах допустимых высот
            NSNumber* h = (NSNumber *)currentArray[index - 1];   // Значение из массива
            CGFloat procent =  ( h.floatValue * 100.0f ) / Hmax; // вычисляем процент от самого большого
            CGFloat currentHeghtColum = ( procent * kHmax ) / 100 ; // сохраним пропорции для наших размеров
            
            // Координаты столбика
            CGRect rectColum =  [self columRectAtPoint:center andHeight:currentHeghtColum];

            // Отрисуем столбик с закругляшками
            UIBezierPath* columPath = [UIBezierPath bezierPathWithRoundedRect:rectColum byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];
            
            CGContextSetFillColorWithColor(ctx, [_settings.columsLineColor CGColor]);
            
            [columPath fill];
        
        }
    }
    
    UIImage* ctxImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return ctxImage;
}

/*
 // Получаем корректную коорденатную сетку для столбиков
 private func columRect ( point : CGPoint , height : CGFloat) -> CGRect {
 return CGRect(x: point.x - ( widthColums! / 2 ), y: point.y - height - indent - sizeMiniLine.height, width: widthColums!, height: height )
 }
 */

- (CGRect) columRectAtPoint: (CGPoint) point andHeight: (CGFloat) height {
    return CGRectMake(point.x - ( _settings.widthColums / 2 ), point.y - height - _settings.indent - _settings.sizeMiniLine.height, _settings.widthColums, height);
}

// Получаем корректную коорденатную сетку для черкашей
- (CGRect) miniRectAtPoint:(CGPoint) point {
    return CGRectMake(point.x - ( _settings.sizeMiniLine.width / 2), point.y - _settings.sizeMiniLine.height, _settings.sizeMiniLine.width, _settings.sizeMiniLine.height);
}

@end
