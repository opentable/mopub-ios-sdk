//
//  MPBaseInterstitialAdapter.m
//  MoPub
//
//  Created by Nafis Jamal on 4/27/11.
//  Copyright 2011 MoPub. All rights reserved.
//

#import "MPBaseInterstitialAdapter.h"
#import "MPAdConfiguration.h"
#import "MPGlobal.h"
#import "MPAnalyticsTracker.h"
#import "MPInstanceProvider.h"
#import "MPTimer.h"
#import "MPConstants.h"

@interface MPBaseInterstitialAdapter ()

@property (nonatomic, strong) MPAdConfiguration *configuration;
@property (nonatomic, strong) MPTimer *timeoutTimer;

- (void)startTimeoutTimer;

@end

@implementation MPBaseInterstitialAdapter

@synthesize delegate = _delegate;
@synthesize configuration = _configuration;
@synthesize timeoutTimer = _timeoutTimer;

- (id)initWithDelegate:(id<MPInterstitialAdapterDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    [self unregisterDelegate];

    [self.timeoutTimer invalidate];

}

- (void)unregisterDelegate
{
    self.delegate = nil;
}

- (void)getAdWithConfiguration:(MPAdConfiguration *)configuration
{
    // To be implemented by subclasses.
    [self doesNotRecognizeSelector:_cmd];
}

- (void)_getAdWithConfiguration:(MPAdConfiguration *)configuration
{
    self.configuration = configuration;

    [self startTimeoutTimer];

    [self getAdWithConfiguration:configuration];
}

- (void)startTimeoutTimer
{
    self.timeoutTimer = [[MPInstanceProvider sharedProvider] buildMPTimerWithTimeInterval:INTERSTITIAL_TIMEOUT_INTERVAL
                                                                                   target:self
                                                                                 selector:@selector(timeout)
                                                                                  repeats:NO];
    [self.timeoutTimer scheduleNow];
}

- (void)didStopLoading
{
    [self.timeoutTimer invalidate];
}

- (void)timeout
{
    [self.delegate adapter:self didFailToLoadAdWithError:nil];
}

#pragma mark - Presentation

- (void)showInterstitialFromViewController:(UIViewController *)controller
{
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark - Metrics

- (void)trackImpression
{
    [[[MPInstanceProvider sharedProvider] sharedMPAnalyticsTracker] trackImpressionForConfiguration:self.configuration];
}

- (void)trackClick
{
    [[[MPInstanceProvider sharedProvider] sharedMPAnalyticsTracker] trackClickForConfiguration:self.configuration];
}

@end
