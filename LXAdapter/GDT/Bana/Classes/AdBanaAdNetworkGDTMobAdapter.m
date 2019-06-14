//
//  AdBanaAdNetworkGDTAdapter.m
//  LXAdapter
//
//  Created by 刘霞 on 2019/6/13.
//  Copyright © 2019年 刘霞. All rights reserved.
//

#import "AdBanaAdNetworkGDTMobAdapter.h"
#import <AdBanaGDTMobSDK/GDTMobBannerView.h>

@interface AdBanaAdNetworkGDTMobAdapter()<GDTMobBannerViewDelegate>

@property (nonatomic, strong) GDTMobBannerView *bannerView;

@end
@implementation AdBanaAdNetworkGDTMobAdapter
+ (NSString*)networkType{
    return AdBanaAdNetworkAdGDT;
}

+ (void)load {
    [[AdBanaBannerSDKAdNetworkRegistry sharedRegistry] registerClass:self];
}

-(void)getThirdAd{
    CGSize size = CGSizeZero;
    switch (self.adType) {
        case AdBanaViewTypeUnknown:
        case AdBanaViewTypeNormalBanner:
        case AdBanaViewTypeMediumBanner:
        case AdBanaViewTypeiPadNormalBanner:
            size = GDTMOB_AD_SUGGEST_SIZE_320x50;
            break;
        case AdBanaViewTypeLargeBanner:
            size = GDTMOB_AD_SUGGEST_SIZE_728x90;
            break;
        default:
             [self adapter:self didFailAd:[AdBanaError errorWithCode:1 description:@"没有对应的广告尺寸"]];
            break;
    }
    
    self.bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) appId:[self getAdapterKey1] placementId:[self getAdapterKey2]];
    self.adNetworkView=self.bannerView;
    //设置当前的ViewController
    self.bannerView.currentViewController = [self developerViewControllerForPresentingModalView];
    //设置广告轮播时间，范围为30-120秒，0表示不轮播
    self.bannerView.interval = 0;
    //开启bnner轮播时的动画效果。默认开启。
    self.bannerView.isAnimationOn = NO;
    //展示关闭按钮，默认展示。
    self.bannerView.showCloseBtn = NO;
    //开启GPS定位，默认关闭。
    self.bannerView.isGpsOn = NO;
    //设置Delegate
    self.bannerView.delegate = self;
    [self.bannerView loadAdAndShow];
    
}
//当bannerView收到内存警告时回调
- (void)bannerViewMemoryWarning{
    
}
//请求广告条数据成功后调用
- (void)bannerViewDidReceived{
    [self adapter:self didReceiveAdView:self.adNetworkView];
}
//请求广告条数据失败后调用
- (void)bannerViewFailToReceived:(NSError *)error{
    [self adapter:self didFailAd:[AdBanaError errorWithCode:AdBanaRequestAdapterAd_NotAd]];
}
//应用进入后台时调用
- (void)bannerViewWillLeaveApplication{
   [self adapter:self didClickAdView:self.adNetworkView];
}
//banner条被用户关闭时调用
- (void)bannerViewWillClose{
    
}
//banner条曝光回调
- (void)bannerViewWillExposure{
    
}
//banner条点击回调
- (void)bannerViewClicked{
    [self adapter:self didClickAdView:self.adNetworkView];
}
//全屏广告页已经被关闭
- (void)bannerViewDidDismissFullScreenModal{
    [self adapter:self didDismissFullScreenModal:nil];
}

- (void)dealloc{
    
}
@end
