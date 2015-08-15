//
//  ScrollImageBrowser.h
//  CuteImageBrowser
//
//  Created by Caesar on 15/8/14.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollImageBrowser : UICollectionViewController<UIScrollViewDelegate>
@property(nonatomic, assign)NSInteger imagesCount;
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, assign)NSInteger tag;
@property(nonatomic, strong)NSArray *imageArray;
@property(nonatomic, weak)UIPageControl *pageControl;

- (void)show:(NSInteger)tag;

+ (ScrollImageBrowser *)sharedScrollImageBrowser;

@end
