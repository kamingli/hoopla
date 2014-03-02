//
//  HPLMovieViewController.m
//  hoopla
//
//  Created by Kaming Li on 3/2/14.
//  Copyright (c) 2014 Kaming Li. All rights reserved.
//

#import "HPLMovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HPLMovieViewController ()
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerViewController;
@property (nonatomic, strong) NSURL *movieURL;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation HPLMovieViewController

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithURL:(NSURL *)url
{
	self = [self initWithNibName:nil bundle:nil];
	if (self != nil) {
		_movieURL = url;
	}
	return self;
}

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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMPMoviePlayerPlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self playMovie];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupMyView
{
	[self addCloseButton];
	[self.closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Close button

- (void)addCloseButton
{
	[self.view addSubview:self.closeButton];
}

- (UIButton *)closeButton
{
	if (_closeButton == nil) {
		
		UIButton *btn;
		
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(0.0f, 0.0f, 60.0f, 44.0f);
		btn.backgroundColor = [UIColor blackColor];
		[btn setTitle:@"Close" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
		
		_closeButton = btn;
	}
	return _closeButton;
}

- (void)closeButtonTapped
{
	_moviePlayerViewController = nil;
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Movie

- (MPMoviePlayerViewController *)moviePlayerViewController
{
	if (_moviePlayerViewController == nil) {
		
		MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:self.movieURL];
		[playerVC.moviePlayer prepareToPlay];
		playerVC.view.frame = self.view.bounds;
		playerVC.moviePlayer.shouldAutoplay = YES;
		playerVC.moviePlayer.repeatMode = MPMovieRepeatModeOne;
		playerVC.moviePlayer.controlStyle = MPMovieControlStyleNone;
		playerVC.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
		playerVC.view.backgroundColor = [UIColor orangeColor];
		_moviePlayerViewController = playerVC;
	}
	return _moviePlayerViewController;
}

- (void)setupMovie
{
	[self.view addSubview:self.moviePlayerViewController.view];
	[self.view bringSubviewToFront:self.moviePlayerViewController.view];
}

- (void)playMovie
{
	if (self.moviePlayerViewController.moviePlayer.playbackState != MPMoviePlaybackStatePlaying) {
		[self.moviePlayerViewController.moviePlayer play];
	}
}

- (void)pauseMovie
{
	[self.moviePlayerViewController.moviePlayer pause];
}

- (void)handleMPMoviePlayerPlaybackDidFinishNotification:(NSNotification *)notification
{
	_moviePlayerViewController = nil;
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
