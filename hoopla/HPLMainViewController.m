//
//  HPLMainViewController.m
//  hoopla
//
//  Created by Kaming Li on 3/2/14.
//  Copyright (c) 2014 Kaming Li. All rights reserved.
//

#import "HPLMainViewController.h"

@interface HPLMainViewController ()

@end

@implementation HPLMainViewController

@synthesize playButton = _playButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupMyView
{
	[self setBackgroundImage:[UIImage imageNamed:@"main_background.png"]];
	[self addPlayButton];
}

- (void)addPlayButton
{
	[self.view addSubview:self.playButton];
}

- (UIButton *)playButton
{
	if (_playButton == nil) {
		
		UIButton *btn;
		
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(0.0f, 0.0f, 200.0f, 80.0f);
		btn.center = CGPointMake(160.0f, 480.0f);
		btn.backgroundColor = [UIColor blackColor];
		[btn setTitle:@"Play" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:40.0f];
		
		_playButton = btn;
	}
	return _playButton;
}

@end
