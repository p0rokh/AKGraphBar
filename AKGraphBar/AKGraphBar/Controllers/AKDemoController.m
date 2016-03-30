//
//  AKDemoController.m
//  AKGraphBar
//
//  Created by Anton Korolev on 25.03.16.
//  Copyright © 2016 AntonKorolev. All rights reserved.
//

#import "AKDemoController.h"
#import "AKGraph.h"


@interface AKDemoController () <AKGraphBarDelegate>

@end

@implementation AKDemoController {
    CGSize imageSize;
    AKGraphBar* graphBar;
    AKBulderGraph* builder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    AKArray * arrayGraph = [AKArray arrayWithObjects:@122, @321, @543, @233, @211, nil];
    AKGraphBarSettings* setting = [[AKGraphBarSettings alloc] initDefaultWithArrayData:arrayGraph];
    graphBar = [[AKGraphBar alloc] initWhithSetting:setting andDelegate:self];
    
    /* v1.1.5 */
    builder = [[AKBulderGraph alloc] init];
    
    /* v1.1.4  - example block */
    __weak typeof (self) weekSelf = self;
    [graphBar drawGraphBarInRect:CGRectZero withCompletedBlock:^(UIImage * _Nullable image) {
        
        typeof (self) strongSelf = weekSelf;
        if (!strongSelf) {
            return;
        }
        
        strongSelf.graphImageView.image = image;
    } andErrorBlock:^(NSString * _Nonnull message) {
        NSLog(@"--->ERROR block graph bar message: %@", message);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/* v1.1.3 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(complitedDrawGraphBar:) name:AKGraphBarCreateImageNotification object:nil];
}

/* v1.1.3 */
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AKGraphBarCreateImageNotification object:nil];
}

#pragma mark - Action draw graph bar

BOOL toRandomeSettings = NO;

- (IBAction)addGraphAction:(id)sender {
    /* v1.1.5 */

    if (toRandomeSettings) {
        [builder changeSettingsBarRandom:graphBar];

    }else {
        /* v1.1.7 */
        toRandomeSettings = YES;
        NSDictionary* parameters = [self createDictionary];
        [builder changeSettingsGraphBar:graphBar withParameters:parameters andToDrawGraphBar:YES];
    }
}

/* v1.1.7 */
-(NSDictionary *) createDictionary {
    AKArray * arrayGraph = [AKArray arrayWithObjects:@122, @321, @543, @233, @211, @122, @654, @34, @432, nil];
    NSDictionary *currentDic = [[NSDictionary alloc]
                                 initWithObjectsAndKeys:[UIColor grayColor], AKBuilderBackgroundColor,
                                 [UIColor whiteColor], AKBuilderBottomLineColor,
                                 [UIColor whiteColor], AKBuilderColumsLineColor,
                                 arrayGraph, AKBuilderArrayData,
                                 nil];
    return currentDic;
}

#pragma mark - Notification graph bar method

/* v1.1.3 */
- (void) complitedDrawGraphBar:(NSNotification *) notification {
    UIImage* image = (UIImage *)notification.object;
    NSLog(@"--->Image size W: %f, H: %f", image.size.width, image.size.height);
}

# pragma mark - delegate method AK Graph Bar delegate

-(CGRect)sizeOfImageInGraphBar:(AKGraphBar *)graphBar {
    if (_graphImageView) {
        return _graphImageView.bounds;
    }
    
    return CGRectZero;
}

- (void)graphBar:(AKGraphBar *)graphBar drawImage:(UIImage *)image {
    _graphImageView.image = image;
}

- (void) graphBar:(AKGraphBar *)graphBar errorWithMessage:(NSString *)message {
    NSLog(@"--->ERROR delegate graph bar message: %@", message);
}

@end
