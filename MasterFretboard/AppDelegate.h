//
//  AppDelegate.h
//  MasterFretboard
//
//  Created by Xinrong Guo on 12/22/12.
//  Copyright (c) 2012 FoOTOo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField *noteLabel;
@property (assign) IBOutlet NSTextField *speedLabel;
@property (assign) IBOutlet NSSlider *speedSlider;

@property (strong, nonatomic) NSTimer *timer;

@end