//
//  AKGraphBar.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKGraphBar.h"

/* v1.1.3 */
NSString* const AKGraphBarCreateImageNotification = @"AKGraphBarCreateImageNotification";

@interface AKGraphBar ()

#if NS_BLOCKS_AVAILABLE
@property (copy) void (^completedBlock)(UIImage * _Nullable);
@property (copy) void (^errorBlock)(NSString * _Nonnull);
#endif

/* Obtain the correct rect for the pillars */
- (CGRect) columRectAtPoint: (CGPoint) point andHeight: (CGFloat) height;

/* Get the correct rect for dashes */
- (CGRect) miniRectAtPoint:(CGPoint) point;

/* v1.1.0 */
- (void) drawGraphBarInRect:(CGRect)rect;
- (void) reportErrorMessage:(NSString * _Nonnull) message ;

@end

@implementation AKGraphBar

#pragma mark - init

/* v1.1.6 */
-(instancetype)init {
    return [self initWhithSetting:[[AKGraphBarSettings alloc] init] andDelegate:nil];
}

- (id)initWhithSetting:(AKGraphBarSettings *)settings {
    return [self initWhithSetting:settings andDelegate:nil];
}

- (id)initWhithSetting:(AKGraphBarSettings *)settings andDelegate:(id) delegate {
    self = [super init];
    
    if (self) {
        /* v1.1.4 */
        self.settings = settings; //[settings copy];
        self.delegate = delegate;
    }
    
    return self;
}

#pragma mark - draw method
/* v1.0.3 */
- (void) drawGraphBar {
    if ([_delegate respondsToSelector:@selector(sizeOfImageInGraphBar:)])  {
        CGRect currentRect = [_delegate sizeOfImageInGraphBar:self];
        [self startDrawInRect:currentRect];
    }
}

#if NS_BLOCKS_AVAILABLE
-(void)drawGraphBarInRect:(CGRect)rect withCompletedBlock:(void (^)(UIImage * _Nullable))completedBlock andErrorBlock:(void (^)(NSString * _Nonnull))errorBlock {
    self.completedBlock = completedBlock;
    self.errorBlock = errorBlock;
    [self startDrawInRect:rect];
}
#endif

- (void) startDrawInRect: (CGRect) rect {
    if (CGRectEqualToRect(CGRectZero, rect) || ( _settings.arrayData.count <= 0 )) {
       
        /* v1.1.7 */
        if ( CGRectEqualToRect(CGRectZero, rect) ) [self reportErrorMessage:@"Слишком малые размеры"];
        if ( _settings.arrayData.count <= 0 )      [self reportErrorMessage:@"Нет данных"];
        
    } else {
    
        /* v1.1.4 */
        __weak typeof (self) weekSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            typeof (self) strongSelf = weekSelf;
            if (!strongSelf) {
                return;
            }
            
            [strongSelf drawGraphBarInRect:rect];
        });
    }
}

#pragma mark - Draw graph bar

- (void) drawGraphBarInRect:(CGRect)rect {
    if (_settings == nil) {
        return;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    
    // First we learn the maximum value in the array
    CGFloat Hmax = _settings.maxHeightColum; //( rect.size.height > _settings.maxHeightColum ) ? rect.size.height : _settings.maxHeightColum ;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Creating color our canvas and paint over it.
    CGContextSetFillColorWithColor(ctx, [_settings.background CGColor]);
    CGContextFillRect(ctx, rect);
    
    // Default settings
    CGFloat kYLine = rect.size.height - _settings.indentBottomLine;
    CGFloat W = rect.size.width;
    CGFloat kHmax = kYLine - _settings.indent - _settings.sizeMiniLine.height - _settings.indentTopLine;

    // Adjust the width of the column and dashes
    CGFloat maxMiniline = W / ((CGFloat) _settings.numberColums + 1 );
    if (_settings.sizeMiniLine.width >= maxMiniline) {
        _settings.sizeMiniLine = CGSizeMake(maxMiniline - _settings.indent, _settings.sizeMiniLine.height);
        _settings.widthColums = ( maxMiniline - _settings.indent );
    }
    
    AKArray * currentArray = _settings.arrayData;

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

    /* v1.1.0 */
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{

        /* v1.1.3 */
        if (ctxImage) {
            [[NSNotificationCenter defaultCenter] postNotificationName:AKGraphBarCreateImageNotification object:ctxImage];
        }
        
        if ([_delegate respondsToSelector:@selector(graphBar:drawImage:)]) {
            [_delegate graphBar:self drawImage:ctxImage];
        }
        
#if NS_BLOCKS_AVAILABLE
        if (_completedBlock != nil) {
            _completedBlock(ctxImage);
            _completedBlock = nil;
        }
#endif
        if (ctx == nil) {
            [self reportErrorMessage:@"Не удалось отрисовать картинку"];
        }
    }];
}

/* v1.1.0 */
- (void) reportErrorMessage:(NSString *) message {
    if ([_delegate respondsToSelector:@selector(graphBar:errorWithMessage:)]) {
        [_delegate graphBar:self errorWithMessage:message];
    }
    
    if (_errorBlock != nil) {
        _errorBlock(message);
        _errorBlock = nil;
        _completedBlock = nil;
    }
}

- (CGRect) columRectAtPoint: (CGPoint) point andHeight: (CGFloat) height {
    return CGRectMake(point.x - ( _settings.widthColums / 2 ), point.y - height - _settings.indent - _settings.sizeMiniLine.height, _settings.widthColums, height);
}

- (CGRect) miniRectAtPoint:(CGPoint) point {
    return CGRectMake(point.x - ( _settings.sizeMiniLine.width / 2), point.y - _settings.sizeMiniLine.height, _settings.sizeMiniLine.width, _settings.sizeMiniLine.height);
}

/* v1.1.0 */
# pragma mark - setter methods

- (void) setBackgroundColor:(UIColor *) color {
    if (color) {
        
        /* v1.1.5 */
        @synchronized (_settings) {
            [self.settings setBackground:color];
        }
    }
}

- (void) setColumsLineColor:(UIColor *) color {
    if (color) {
        
        /* v1.1.5 */
        @synchronized (_settings) {
            [self.settings setColumsLineColor:color];
        }
    }
}

- (void) setBottomLineColor:(UIColor *) color {
    if (color) {
        
        /* v1.1.5 */
        @synchronized (_settings) {
            [self.settings setBottomLineColor:color];
        }
    }
}

- (void) setArrayData:(AKArray *) newArray {
    if (newArray) {
        
        /* v1.1.5 */
        @synchronized (_settings) {
            [self.settings setArrayData:newArray];
        }
    }
}

@end
