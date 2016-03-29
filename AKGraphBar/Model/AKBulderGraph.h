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
- (void) changeSettingsBarRandom: ( AKGraphBar * _Nonnull) graphBar /* completedBlock:(void (^ _Nonnull)(void))block */;

@end
