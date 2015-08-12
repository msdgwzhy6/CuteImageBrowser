//
//  CuteImageBrowser.h
//  CuteImageBrowser
//
//  Created by 我的宝宝 on 15/8/10.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypeNone,
    AnimationTypeFade,
    AnimationTypeMovein,
    AnimationTypePush,
    AnimationTypeReveal,
    AnimationTypeCube,
    AnimationTypeSuckEffect,
    AnimationTypeOglFlip,
    AnimationTypeRippleEffect
};

typedef NS_ENUM(NSInteger, BrowserType) {
    BrowserTypeLocal,
    BrowserTypeInternet
};


@interface CuteImageBrowser : UIViewController <UIScrollViewDelegate>

@property(nonatomic, assign)NSInteger imageCount;
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, assign)NSInteger tag;
@property(nonatomic, assign)AnimationType animationType;
@property(nonatomic, strong)NSArray *imageArray;

- (void)show:(NSInteger)tag;
- (instancetype)init:(NSArray *)imageArray tag:(NSInteger)tag animationType:(AnimationType)type;

+ (CuteImageBrowser *)sharedCuteImageBrowser;

@end
