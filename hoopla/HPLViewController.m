//
//  HPLViewController.m
//  hoopla
//
//  Created by Kaming Li on 3/1/14.
//  Copyright (c) 2014 Kaming Li. All rights reserved.
//

#import "HPLViewController.h"

@interface HPLViewController ()

@end

@implementation HPLViewController

@synthesize backgroundImageView = _backgroundImageView;

- (void)loadView
{
	self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.backgroundImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackgroundImage:(UIImage *)img
{
	if (img != self.backgroundImageView.image) {
		self.backgroundImageView.image = img;
		[self.view sendSubviewToBack:self.backgroundImageView];
		[self.view setNeedsDisplay];
	}
}

- (UIImageView *)backgroundImageView
{
	if (_backgroundImageView == nil) {
		_backgroundImageView = [[UIImageView alloc] initWithImage:nil];
		_backgroundImageView.frame = self.view.bounds;
	}
	return _backgroundImageView;
}

@end
