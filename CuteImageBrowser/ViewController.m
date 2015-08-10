//
//  ViewController.m
//  CuteImageBrowser
//
//  Created by 我的宝宝 on 15/8/10.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "ViewController.h"
#import "CuteImageBrowser.h"

@interface ViewController ()
{
    UIImageView *_imageView;
}
@end

@implementation ViewController

- (void)show {
    NSArray *imageArr = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"1"],
                         [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"], nil];
    CuteImageBrowser *imageBrowser = [[CuteImageBrowser alloc]init];
    imageBrowser.imageArray = imageArr;
    imageBrowser.imagesCount = 3;
    imageBrowser.tag = 2;
    imageBrowser.animationType = AnimationTypeCube;
    [self.navigationController pushViewController:imageBrowser animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(150, 200, 80, 80)];
    _imageView.backgroundColor = [UIColor blackColor];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(show)];
    [_imageView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
