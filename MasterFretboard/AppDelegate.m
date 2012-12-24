//
//  AppDelegate.m
//  MasterFretboard
//
//  Created by Xinrong Guo on 12/22/12.
//  Copyright (c) 2012 FoOTOo. All rights reserved.
//

#import "AppDelegate.h"
#import "NSMutableArray+Shuffle.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSThread *timerThread;
@property (strong, nonatomic) NSMutableArray *notes;
@property (strong, nonatomic) NSEnumerator *notesEnumerator;
@property (strong, nonatomic) NSString *note;

@property (strong, nonatomic) NSSpeechSynthesizer *speechSynth;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:@"com.apple.speech.synthesis.voice.Alex"];
    NSLog(@"avaliable voices:\n%@", [NSSpeechSynthesizer availableVoices]);
    
    _notes = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", nil];
    [_notes shuffle];
    _notesEnumerator = [_notes objectEnumerator];
    _note = [_notesEnumerator nextObject];
    
    NSInteger defaultSpeed = 20;

    [_speedSlider setMinValue:1];
    [_speedSlider setMaxValue:100];

    [_speedSlider setIntegerValue:defaultSpeed];

    [_speedLabel setIntegerValue:defaultSpeed];

//    [self reFireTimer];
    
    _timerThread = [[NSThread alloc] initWithTarget:self selector:@selector(reFireTimer) object:nil];
    [_timerThread start];
}

- (IBAction)sliderValueChange:(id)sender {
    [_speedLabel setIntegerValue:_speedSlider.integerValue];
    [self performSelector:@selector(reFireTimer) onThread:_timerThread withObject:nil waitUntilDone:NO];
}

- (void)randomNote {
//    NSLog(@"note [%@]", _note);
    [_noteLabel setStringValue:_note];

    [_speechSynth startSpeakingString:_note.lowercaseString];
    
    _note = [_notesEnumerator nextObject];
    if (!_note) {
        [_notes shuffle];
        _notesEnumerator = [_notes objectEnumerator];
        _note = [_notesEnumerator nextObject];
    }
}

#pragma mark - Timer Thread

- (void)reFireTimer {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 / _speedSlider.integerValue target:self selector:@selector(timeup) userInfo:nil repeats:YES];
    
    while (YES) {
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)timeup {
//    NSLog(@"timeup");
    [self performSelectorOnMainThread:@selector(randomNote) withObject:nil waitUntilDone:NO];
}

#pragma mark - Terminate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end