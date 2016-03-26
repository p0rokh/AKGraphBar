//
//  AKGraphBar.h
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGraphBarSettings.h"

/*********************
    Methods delegate
 **********************/

@class AKGraphBar;
@protocol AKGraphBarDelegate <NSObject>

/* Requesting the correct size  */
- (CGRect) parametersOfTheCanvas: (AKGraphBar * _Nonnull) graphBar;

/* Use this delegate method to implement the logic of your application, it returns a picture.. */
- (void) graphBar:(AKGraphBar * _Nonnull)graphBar drawImage:(UIImage * _Nullable) image;

@optional

/* It triggered in the event when: 1.CGRectZero 2. Unable to generate a picture, in this case, the delegate "drawImage" would work. */
- (void) graphBar: (AKGraphBar * _Nonnull) graphBar errorWithMessage: (NSString * _Nonnull) message;

@end

/*********************
    AKGraphBar class
    nonnull, nullable, _Nonnull, _Nullable - In order to use in swift projects
 **********************/

@interface AKGraphBar : NSObject

@property (strong, atomic, nonnull) AKGraphBarSettings* settings;
@property (nonatomic,weak, nullable) id<AKGraphBarDelegate> delegate;

/* init method */
- (id _Nonnull) initWhithSetting:( AKGraphBarSettings * _Nonnull ) settings;
- (id _Nonnull) initWhithSetting:(AKGraphBarSettings * _Nonnull)settings andDelegate:(id _Nullable) delegate;

/* Returns schedule */
- (void) drawGraphBar;

/* v1.0.3 */
/* setter methods */
- (void) setBackgroundColor:(UIColor * _Nullable) color;
- (void) setColumsLineColor:(UIColor * _Nullable) color;
- (void) setBottomLineColor:(UIColor * _Nullable) color;
- (void) setArrayData:(NSArray * _Nullable) newArray;

@end
