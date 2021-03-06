//
//  AKGraphBarSettings.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKGraphBarSettings.h"

#define kDefaultColumsNumber 22
#define kDefaultIndentLine 10.0f
#define kDefaultIndent 4.0f
#define kDefaulWightMiniLine 48.0f
#define kDefaultHeightColum 300

@interface AKGraphBarSettings ()

/* Private metods */
- (void) setup:(NSInteger) numberColums andArrayData:(AKArray *) array;
- (CGFloat) getMAXHeightInArrayData:(AKArray *)array ;

@end

@implementation AKGraphBarSettings

# pragma mark - Init methods

-(id)copyWithZone:(NSZone *)zone {

    AKGraphBarSettings *copySettings = [[AKGraphBarSettings allocWithZone:zone] init];
   
    if (copySettings) {
        [copySettings setBackground:self.background];
        [copySettings setColumsLineColor:self.columsLineColor];
        [copySettings setBottomLineColor:self.bottomLineColor];
        [copySettings setIndentBottomLine:self.indentBottomLine];
        [copySettings setIndentTopLine:self.indentTopLine];
        [copySettings setIndent:self.indent];
        [copySettings setNumberColums:self.numberColums];
        [copySettings setSizeMiniLine:self.sizeMiniLine];
        [copySettings setWidthColums:self.widthColums];
        [copySettings setArrayData:self.arrayData];
        [copySettings setMiniLineHidden:self.miniLineHidden];
        [copySettings setMaxHeightColum:self.maxHeightColum];
    }
    
    return copySettings;
}

/* v1.1.6 */
-(instancetype)init {
    return [self initDefaultWithArrayData:[AKArray array] andNumberColums:0];
}

-(id)initDefaultWithArrayData:(AKArray *)arrayData {
    return [self initDefaultWithArrayData:arrayData andNumberColums:0];
}

-(id)initDefaultWithArrayData:(AKArray *)arrayData andNumberColums:(NSInteger)numberColums {
    self = [super init];
    if (self) {
        [self setup:numberColums andArrayData:arrayData];
    }
    return self;
}

# pragma mark - Setup settings

-(void) setup:(NSInteger) numberColums andArrayData:(AKArray *) array {
    self.background = [UIColor whiteColor];
    self.columsLineColor = [UIColor orangeColor];
    self.bottomLineColor = [UIColor orangeColor];
    self.indentBottomLine = kDefaultIndentLine;
    self.indentTopLine = kDefaultIndentLine;
    self.indent = kDefaultIndent;
    self.numberColums = (numberColums <= 0) ? kDefaultColumsNumber : numberColums;
    self.sizeMiniLine =  CGSizeMake(kDefaulWightMiniLine, 2.0f);
    self.widthColums = kDefaulWightMiniLine/2.0f;
    self.arrayData = [self getCurrentArrayFrom:array];
    self.miniLineHidden = NO;
    self.maxHeightColum = [self getMAXHeightInArrayData:_arrayData];
}

/* v1.1.1 */
-(void)setArrayData:(AKArray * _Nonnull)arrayData {
    _arrayData = [self getCurrentArrayFrom:arrayData];
    self.maxHeightColum = [self getMAXHeightInArrayData:_arrayData];
}

- (CGFloat)getMAXHeightInArrayData:(AKArray *)array {
    NSInteger maxNumber = kDefaultHeightColum;
    for (NSNumber* object in array) {
        maxNumber = MAX(object.integerValue, maxNumber);
    }
    
    return (CGFloat)maxNumber;
}

- (AKArray *) getCurrentArrayFrom:(AKArray *) array {
    NSMutableArray<NSNumber *>* currentArray = [NSMutableArray<NSNumber *> arrayWithCapacity:_numberColums];
    NSUInteger countArray = array.count;
    
    for (int index = 0; index < _numberColums; index++) {
        if (index < countArray) {
            NSNumber* object = (NSNumber *)array[index];
            [currentArray addObject:object];
        }else {
            [currentArray addObject:@0];
        }
    }
    return currentArray;
}

@end
