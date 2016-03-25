//
//  AKImageView.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKView.h"

IB_DESIGNABLE
@interface AKView ()

@property (nonatomic) IBInspectable UIColor* fillColor;
@property (nonatomic) IBInspectable CGFloat radius;
@property (nonatomic) IBInspectable CGFloat thickness;

@end

@implementation AKView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(_radius, _radius)];
    bezierPath.lineWidth = _thickness;
    
    CGContextSetStrokeColorWithColor(ctx, [_fillColor CGColor]);

    [bezierPath stroke];
    
    [super drawRect:rect];
}

@end
