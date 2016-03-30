//
//  AKBulderGraph.h
//  AKGraphBar
//
//  Created by Anton Korolev on 28.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGraphBar.h"
#import "Prefix.h"

/* v1.1.5 */
@interface AKBulderGraph : NSObject

/* Modify fields of graphics settings randomly and returns the unit after modification. */
- (void) changeSettingsBarRandom: ( AKGraphBar * _Nonnull) graphBar;

/** v1.1.7 
 With this method, you can override some properties of the graph.
 
 list parameters key
    AKBuilderBackgroundColor - object UIColor, change bacground graph
    AKBuilderBottomLineColor - object UIColor, change bottom line graph
    AKBuilderColumsLineColor - object UIColor, change colums line graph
    AKBuilderArrayData       - object AKArray, change array data graph
 */
-(void) changeSettingsGraphBar:(AKGraphBar * _Nonnull)graphBar withParameters:(NSDictionary * _Nonnull) parameters andToDrawGraphBar:(BOOL) toDraw;

@end

/** v1.1.7
    UIColor element and AKArray data
 */
extern NSString* _Nonnull const AKBuilderBackgroundColor;
extern NSString* _Nonnull const AKBuilderBottomLineColor;
extern NSString* _Nonnull const AKBuilderColumsLineColor;
extern NSString* _Nonnull const AKBuilderArrayData;

