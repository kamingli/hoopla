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
#import "AudioToolBox/AudioToolBox.h"
#import <AVFoundation/AVFoundation.h>

@interface HPLMainViewController ()
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerViewController;
@property (nonatomic, strong) NSURL *movieURL;
@property (nonatomic, strong) NSString *currentMissionBeaconName;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger remainingSeconds;
@property (nonatomic, strong) AVAudioPlayer *radarAudioPlayer;

@end

@implementation HPLMainViewController

#define MISSION_ONE_TIME 30
#define MISSION_TWO_TIME 20

@synthesize playButton = _playButton;
@synthesize missionOneButton = _missionOneButton;
@synthesize missionTwoButton = _missionTwoButton;
@synthesize moviePlayerViewController = _moviePlayerViewController	;
@synthesize shareButton = _shareButton;

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
	self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    [self.visitManager start];
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
	[self addShareButton];
	[self.playButton addTarget:self action:@selector(playButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[self.missionOneButton addTarget:self action:@selector(missionOneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[self.missionTwoButton addTarget:self action:@selector(missionTwoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[self.shareButton addTarget:self action:@selector(shareButtonTapped) forControlEvents:UIControlEventTouchUpInside];
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

- (void)missionOneButtonTapped
{
	NSLog(@"Look for Mission One beacon");
	self.currentMissionBeaconName = @"Mission1";
	NSString *text = [NSString stringWithFormat:@"You have %d seconds to locate the satellite! Get moving! Go!", MISSION_ONE_TIME];
	[self sayIt:text];
	[self startTimer];
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

- (void)missionTwoButtonTapped
{
	NSLog(@"Look for Mission Two beacon");
	self.currentMissionBeaconName = @"Mission2";
	NSString *text = [NSString stringWithFormat:@"You have %d seconds to find George Clooney. Hurry! Go!", MISSION_TWO_TIME];
	[self sayIt:text];
	[self startTimer];
}

#pragma mark - Share button

- (void)addShareButton
{
	[self.view addSubview:self.shareButton];
}

- (UIButton *)shareButton
{
	if (_shareButton == nil) {
		
		UIButton *btn;
		
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(0.0f, 0.0f, 240.0f, 50.0f);
		btn.center = CGPointMake(160.0f, 520.0f);
		btn.backgroundColor = [UIColor blackColor];
		[btn setTitle:@"Share" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
		
		_shareButton = btn;
	}
	return _shareButton;
}

- (void)shareButtonTapped
{
	UIImage *postImage = [UIImage imageNamed:@"selfie.png"];
	NSString *postText = @"Play to earn points to exchange for goodies from your favorite brands! #HooplaTeam at SF Beacon Hack! #BRINGITSF  ";
	
    NSArray *activityItems = @[postText, postImage];
	
    UIActivityViewController *activityController =
	[[UIActivityViewController alloc]
	 initWithActivityItems:activityItems
	 applicationActivities:nil];
	
    [self presentViewController:activityController
					   animated:YES completion:nil];
}

#pragma mark - Audio

- (void)startRadarAudio
{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep_end.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
    self.radarAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.radarAudioPlayer.enableRate = YES;
	self.radarAudioPlayer.numberOfLoops = -1;
    [self setRateAndVolume:0.2 volume:1.0];
	[self.radarAudioPlayer play];
}

- (void)stopRadarAudio
{
    [self.radarAudioPlayer stop];
    [self setRateAndVolume:0.2 volume:1.0];
}

- (void)setRateAndVolume:(float)rate volume:(float)volume
{
    if (self.radarAudioPlayer.rate==rate)
    {
        NSLog(@"Rate is the same");
        return;
    }
    
    self.radarAudioPlayer.rate=rate;
    self.radarAudioPlayer.volume=0.8;
}

- (void)updateRateAndVolume:(NSNumber *)RSSI
{
    if (RSSI.floatValue >= -60.0f)
        [self setRateAndVolume:2.0 volume:1.0];
    else if (RSSI.floatValue >= -75.0f && RSSI.floatValue < -60.0f)
        [self setRateAndVolume:1.0 volume:1.0];
    else if (RSSI.floatValue < -75.0f)
        [self setRateAndVolume:0.2 volume:1.0];
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

#pragma mark - Gimbal

- (void)didArrive:(FYXVisit *)visit;
{
	// this will be invoked when an authorized transmitter is sighted for the first time
	NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI
{
	// this will be invoked when an authorized transmitter is sighted during an on-going visit
	NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
	NSLog(@"Beacon name:%@", visit.transmitter.name);
	NSLog(@"RSSI: %f", RSSI.floatValue);
	NSLog(@"update time: %@", updateTime);
    
	if ([self.currentMissionBeaconName isEqualToString:@"Mission1"]){
        [self updateRateAndVolume:RSSI];
        
		if (RSSI.floatValue >= -55.0f) {
			[self sayIt:@"Super, you have located the satellite."];
			[self resetTimer];
			[self resetMission];
		}
	} else if ([self.currentMissionBeaconName isEqualToString:@"Mission2"]) {
        [self updateRateAndVolume:RSSI];
        
		if (RSSI.floatValue >= -55.0f) {
			[self sayIt:@"Fantastic, you have found George Clooney!"];
			[self resetTimer];
			[self resetMission];
		}
	}
}

- (void)didDepart:(FYXVisit *)visit;
{
	// this will be invoked when an authorized transmitter has not been sighted for some time
	NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
	NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

- (void)sayIt:(NSString *)textToSpeech
{
	if (textToSpeech.length == 0) {
		return;
	}
	
	if (NSStringFromClass([AVSpeechUtterance class])) {
		AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:textToSpeech];
		utterance.rate = 0.2f;
		AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
		[synth speakUtterance:utterance];
	} else {
		// pre iOS7
		// list of sounds: http://iphonedevwiki.net/index.php/AudioServices
		AudioServicesPlaySystemSound(1328);
	}
}

- (void)resetTimer
{
	[self.countDownTimer invalidate];
	self.countDownTimer = nil;
    [self stopRadarAudio];
}

- (void)startTimer
{
	self.remainingSeconds = [self.currentMissionBeaconName isEqualToString:@"Mission1"] ? MISSION_ONE_TIME : MISSION_TWO_TIME;
	self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    
    [self startRadarAudio];
}

- (void)countDown
{
	self.remainingSeconds -= 1;
	if (self.remainingSeconds <= 30) {
		if (self.remainingSeconds == 20) {
			[self sayIt:@"20 seconds"];
		} else if (self.remainingSeconds == 10) {
			[self sayIt:@"10 seconds"];
		} else if (self.remainingSeconds == 5) {
			[self sayIt:@"5 seconds"];
		}
	}
	
	if (self.remainingSeconds <= 0) {
		[self sayIt:@"Mission failed. You ran out of oxygen."];
		[self resetTimer];
		[self resetMission];
	}
}

- (void)resetMission
{
	self.currentMissionBeaconName = @"";
}

@end
