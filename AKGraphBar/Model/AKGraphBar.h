//
//  AKGraphBar.h
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGraphBarSettings.h"
#import "Prefix.h"

/*********************
    Methods delegate
 **********************/

@class AKGraphBar;
@protocol AKGraphBarDelegate <NSObject, UITableViewDelegate>

/* v1.1.1 */
/* Requesting the correct size  */
- (CGRect) sizeOfImageInGraphBar: (AKGraphBar * _Nonnull) graphBar;

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

/* v1.1.4 */
@property (atomic, copy, nonnull) AKGraphBarSettings* settings;
@property (nonatomic, weak, nullable) id<AKGraphBarDelegate> delegate;

/* init method */
- (id _Nonnull) initWhithSetting:( AKGraphBarSettings * _Nonnull ) settings;
- (id _Nonnull) initWhithSetting:(AKGraphBarSettings * _Nonnull)settings andDelegate:(id _Nullable) delegate;

/*v1.1.0*/
/* Returns schedule */
- (void) drawGraphBar;

#if NS_BLOCKS_AVAILABLE
- (void) drawGraphBarInRect:(CGRect) rect withCompletedBlock:(void (^ _Nullable)(UIImage * _Nullable image))completedBlock andErrorBlock:(void (^ _Nullable)(NSString* _Nonnull message))errorBlock;
#endif

/* v1.1.0 - v1.1.5 (change _Nullable = _Nonnull)*/
/* setter methods */
- (void) setBackgroundColor:(UIColor * _Nonnull) color;
- (void) setColumsLineColor:(UIColor * _Nonnull) color;
- (void) setBottomLineColor:(UIColor * _Nonnull) color;
- (void) setArrayData:(AKArray * _Nonnull) newArray;

@end

/* v1.1.3 */
extern NSString* _Nonnull const AKGraphBarCreateImageNotification;
