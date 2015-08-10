//
//  CuteImageBrowser.m
//  CuteImageBrowser
//
//  Created by 我的宝宝 on 15/8/10.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "CuteImageBrowser.h"

#define IPHONE_SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define IPHONE_SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

const NSArray *__AnimationType;
#define animationTypeGet (__AnimationType == nil ?__AnimationType = [[NSArray alloc] initWithObjects:@"",kCATransitionFade,kCATransitionMoveIn,kCATransitionPush,kCATransitionReveal,@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",nil] : __AnimationType)
#define animationTypeString(type) ([animationTypeGet objectAtIndex:type])// 枚举 to 字串
#define animationTypeEnum(string) ([animationTypeGet indexOfObject:string])// 字串 to 枚举

@interface CuteImageBrowser() {
    UIImageView *_imageView;
    UIWindow *_window;
}
@end

@implementation CuteImageBrowser

+(CuteImageBrowser *)sharedCuteImageBrowser{
    static CuteImageBrowser *cuteImageBrowser;
    @synchronized(self){
        if (!cuteImageBrowser) {
            cuteImageBrowser = [[self alloc]init];
        }
    }
    return cuteImageBrowser;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _animationType = AnimationTypeCube;
        _imageArray = [[NSArray alloc]init];
        _tag = 0;
    }
    return self;
}

- (instancetype)init:(NSInteger)tag {
    self = [super init];
    if (self) {
        _animationType = AnimationTypeCube;
        _imageArray = [[NSArray alloc]init];
        _tag = tag;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self prefersStatusBarHidden];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self show:_tag];
}

- (void)loadView {
    //reset the root content view: UIView change to UIScrollView
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollview.backgroundColor = [UIColor blackColor];
    //[UIColor colorWithRed:236.0/255.0f green:235.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = YES;
    scrollview.delegate = self;
    scrollview.maximumZoomScale = 2.0;
    scrollview.minimumZoomScale = 0.5;
    self.view = scrollview;
}

- (void)show:(NSInteger)tag{
    
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = (UIImage *)_imageArray[tag];
    [self setContentFrame:_imageView.image];
    [self.view addSubview:_imageView];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeWindow:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImage:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
}

- (void)setContentFrame:(UIImage *)image{
    CGSize imageSize = image.size;
    float b = imageSize.width/(IPHONE_SCREEN_WIDTH);
    if (imageSize.height/b >= IPHONE_SCREEN_HEIGHT) {
        _imageView.frame = CGRectMake(0, 0, IPHONE_SCREEN_WIDTH, imageSize.height/b);
        ((UIScrollView *)self.view).contentSize = CGSizeMake(IPHONE_SCREEN_WIDTH, _imageView.frame.size.height);
    }else {
        _imageView.frame = [UIScreen mainScreen].bounds;
        //CGRectMake(0, (IPHONE_SCREEN_HEIGHT - imageSize.height/b)/2, IPHONE_SCREEN_WIDTH, imageSize.height/b);
        ((UIScrollView *)self.view).contentSize = [UIScreen mainScreen].bounds.size;
    }
}

#pragma mark - GestureEvent

- (void)leftSwipe: (UISwipeGestureRecognizer *)gesture {
    [self transitionAnimation:YES];
}

- (void)rightSwipe: (UISwipeGestureRecognizer *)gesture {
    [self transitionAnimation:NO];
}

- (void)closeWindow: (UITapGestureRecognizer *)tap {
    UIView *backgroundView = tap.view;
    [UIScrollView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 0;
    }completion:^(BOOL finished){
        //[backgroundView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (void)scaleImage:(UITapGestureRecognizer *)tap {
    UIView *backgroundView = tap.view;
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Animation and image change

- (void)transitionAnimation: (BOOL)isNext {
    CATransition *transition = [[CATransition alloc]init];
    NSLog(@"%@",animationTypeString(_animationType));
    transition.type = animationTypeString(_animationType);
    
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    }else {
        transition.subtype = kCATransitionFromLeft;
    }
    
    transition.duration = 1.0f;
    _imageView.image = [self getImage:isNext];
    [self setContentFrame:_imageView.image];
    [_imageView.layer addAnimation:transition forKey:@"CuteTranstionAnimation"];
}

- (UIImage *)getImage: (BOOL)isNext {
    if (isNext) {
        _currentPage = (_currentPage + 1) % _imagesCount;
    }else {
        _currentPage = (_currentPage - 1 + _imagesCount) % _imagesCount;
    }
    
    NSLog(@"------------%d-----------",_currentPage);
    return _imageArray[_currentPage];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (scrollView == self.view) {
        return _imageView;
    }
    return nil;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                   scrollView.contentSize.height * 0.5 + offsetY);
}

@end
