//
//  AKGraphBarSettings.h
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Prefix.h"

@interface AKGraphBarSettings : NSObject <NSCopying>

/*Default whiteColor*/
@property (copy, nonatomic, nonnull) UIColor* background;

/* Default orangeColor */
@property (copy, nonatomic, nonnull) UIColor* columsLineColor;
@property (copy, nonatomic, nonnull) UIColor* bottomLineColor;

/* Default 10.0f  */
@property (assign, nonatomic) CGFloat indentBottomLine;
@property (assign, nonatomic) CGFloat indentTopLine;

/* Default 2.0f */
@property (assign, nonatomic) CGFloat indent;

/* Default 22 */
@property (assign, nonatomic) NSInteger numberColums;

/* Default W:48, H:2 */
@property (assign, nonatomic) CGSize sizeMiniLine;

/* The width of the column, you can determine your size. The default column width is equal to the width of the underscore. */
@property (assign, nonatomic) CGFloat widthColums;

/* Data for NSNumber type columns */
@property (copy, nonatomic, nonnull) NSArray<NSNumber*>* arrayData;

@property (assign, nonatomic) BOOL miniLineHidden;

@property (assign, nonatomic) CGFloat maxHeightColum;

/* Init methods */
-(id _Nonnull)initDefaultWithArrayData:(AKArray * _Nonnull) arrayData;
-(id _Nonnull)initDefaultWithArrayData:(AKArray * _Nonnull) arrayData andNumberColums:(NSInteger) numberColums;


@end
