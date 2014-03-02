//
//  HPLMainViewController.m
//  hoopla
//
//  Created by Kaming Li on 3/2/14.
//  Copyright (c) 2014 Kaming Li. All rights reserved.
//

#import "HPLMainViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HPLMovieViewController.h"

@interface HPLMainViewController ()
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerViewController;
@property (nonatomic, strong) NSURL *movieURL;
@property (nonatomic, strong) NSString *currentMissionBeaconName;
@end

@implementation HPLMainViewController

@synthesize playButton = _playButton;
@synthesize missionOneButton = _missionOneButton;
@synthesize missionTwoButton = _missionTwoButton;
@synthesize moviePlayerViewController = _moviePlayerViewController	;

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
	//[self addPlayButton];
	[self addMissionOneButton];
	[self addMissionTwoButton];
	[self.playButton addTarget:self action:@selector(playButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Play button

- (void)addPlayButton
{
	[self.view addSubview:self.playButton];
}

- (UIButton *)playButton
{
	if (_playButton == nil) {
		
		UIButton *btn;
		
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(0.0f, 0.0f, 240.0f, 80.0f);
		btn.center = CGPointMake(160.0f, 200.0f);
		btn.backgroundColor = [UIColor blackColor];
		[btn setTitle:@"Locate Satelllite" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
		
		_playButton = btn;
	}
	return _playButton;
}

- (void)playButtonTapped
{
	
//	NSString *movieName = @"movie-mission1";
//	NSURL *urlToLoad = [[NSBundle mainBundle] URLForResource:movieName withExtension:@"m4v"];
//	self.movieURL = urlToLoad;
//	[self playMovie];
}

#pragma mark - Mission One button

- (void)addMissionOneButton
{
	[self.view addSubview:self.missionOneButton];
}

- (UIButton *)missionOneButton
{
	if (_missionOneButton == nil) {
		
		UIButton *btn;
		
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(0.0f, 0.0f, 240.0f, 100.0f);
		btn.center = CGPointMake(160.0f, 320.0f);
		btn.backgroundColor = [UIColor blackColor];
		[btn setTitle:@"Mission 1:\nLocate Satellite" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:26.0f];
		btn.titleLabel.numberOfLines = 2;
		btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
		btn.titleLabel.textAlignment = NSTextAlignmentCenter;

		_missionOneButton = btn;
	}
	return _missionOneButton;
}

- (void)missionOneButtonTappped
{
	self.currentMissionBeaconName = @"Mission1";
}

#pragma mark - Mission Two button

- (void)addMissionTwoButton
{
	[self.view addSubview:self.missionTwoButton];
}

- (UIButton *)missionTwoButton
{
	if (_missionTwoButton == nil) {
		
		UIButton *btn;
		
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(0.0f, 0.0f, 240.0f, 100.0f);
		btn.center = CGPointMake(160.0f, 430.0f);
		btn.backgroundColor = [UIColor blackColor];
		[btn setTitle:@"Mission 2:\nSearch & Rescue" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:26.0f];
		btn.titleLabel.numberOfLines = 2;
		btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
		btn.titleLabel.textAlignment = NSTextAlignmentCenter;
		
		_missionTwoButton = btn;
	}
	return _missionTwoButton;
}

- (void)missionTwoButtonTappped
{
	self.currentMissionBeaconName = @"Mission2";
}

#pragma mark - Movie

- (MPMoviePlayerViewController *)moviePlayerViewController
{
	if (_moviePlayerViewController != nil) {
		_moviePlayerViewController = nil;
	}

	MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:self.movieURL];
	[playerVC.moviePlayer prepareToPlay];
	playerVC.view.frame = self.view.bounds;
	playerVC.moviePlayer.shouldAutoplay = YES;
	playerVC.moviePlayer.repeatMode = MPMovieRepeatModeOne;
	playerVC.moviePlayer.controlStyle = MPMovieControlStyleNone;
	playerVC.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
	playerVC.view.backgroundColor = [UIColor orangeColor];
	_moviePlayerViewController = playerVC;
	return _moviePlayerViewController;
}

- (void)setupMovie
{
	[self.view addSubview:_moviePlayerViewController.view];
	[self.view bringSubviewToFront:_moviePlayerViewController.view];
}

- (void)playMovie
{
	if (self.moviePlayerViewController.moviePlayer.playbackState != MPMoviePlaybackStatePlaying) {
		[self.view bringSubviewToFront:_moviePlayerViewController.view];
		[_moviePlayerViewController.moviePlayer play];
	}
}

- (void)pauseMovie
{
	[_moviePlayerViewController.moviePlayer pause];
}

- (void)handleMPMoviePlayerPlaybackDidFinishNotification:(NSNotification *)notification
{
	_moviePlayerViewController = nil;
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
