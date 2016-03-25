//
//  AKGraphBar.h
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGraphBarSettings.h"

@interface AKGraphBar : NSObject

@property (strong, nonatomic) AKGraphBarSettings* settings;

/* init method */
-(id) initWhithSetting:(AKGraphBarSettings *) settings;

/* Returns schedule */
-(UIImage *) drawGraphBarInRect:(CGRect) rect;

@end
