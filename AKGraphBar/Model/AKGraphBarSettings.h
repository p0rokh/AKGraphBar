//
//  AKGraphBarSettings.h
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AKGraphBarSettings : NSObject <NSCopying>

/*Default whiteColor*/
@property (copy, nonatomic) UIColor* background;

/* Default orangeColor */
@property (copy, nonatomic) UIColor* columsLineColor;
@property (copy, nonatomic) UIColor* bottomLineColor;

/* Default 10.0f  */
@property (assign) CGFloat indentBottomLine;
@property (assign) CGFloat indentTopLine;

/* Default 2.0f */
@property (assign) CGFloat indent;

/* Default 22 */
@property (assign) NSInteger numberColums;

/* Default W:48, H:2 */
@property (assign) CGSize sizeMiniLine;

/* The width of the column, you can determine your size. The default column width is equal to the width of the underscore. */
@property (assign) CGFloat widthColums;

/* Data for NSNumber type columns */
@property (copy, nonatomic) NSArray* arrayData;


@property (assign) BOOL miniLineHidden;

@property (assign) CGFloat maxHeightColum;

/* Init methods */
-(id)initDefaultWithArrayData:(NSArray*) arrayData;
-(id)initDefaultWithArrayData:(NSArray*) arrayData andNumberColums:(NSInteger) numberColums;


@end
