//
//  AKGraphBarSettings.h
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AKGraphBarSettings : NSObject

@property (strong, nonatomic) UIColor* background;
@property (strong, nonatomic) UIColor* columsLineColor;
@property (strong, nonatomic) UIColor* bottomLineColor;
@property (assign) CGFloat indentBottomLine;
@property (assign) CGFloat indentTopLine;
@property (assign) CGFloat indent;
@property (assign) NSInteger numberColums;
@property (assign) CGSize sizeMiniLine;
@property (assign) CGFloat widthColums;
@property (strong, nonatomic) NSArray* arrayData;
@property (assign) BOOL miniLineHidden;
@property (assign) CGFloat maxHeightColum;

-(id)initDefaultWithArrayData:(NSArray*) arrayData;
-(id)initDefaultWithArrayData:(NSArray*) arrayData andNumberColums:(NSInteger) numberColums;


@end
