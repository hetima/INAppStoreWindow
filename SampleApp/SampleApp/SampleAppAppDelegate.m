//
//  SampleAppAppDelegate.m
//  SampleApp
//
//  Created by Indragie Karunaratne on 11-02-23.
//  Copyright 2011 PCWiz Computer. All rights reserved.
//

#import "SampleAppAppDelegate.h"
#import "SampleWindowController.h"

@implementation SampleAppAppDelegate

@synthesize sheet = _sheet;
@synthesize window = _window;
@synthesize centerFullScreen = _centerFullScreen;
@synthesize centerTrafficLight = _centerTrafficLight;
@synthesize fullScreenRightMarginSlider = _fullScreenRightMarginSlider;
@synthesize trafficLightLeftMargin = _trafficLightLeftMargin;
@synthesize trafficLightTopMargin = _trafficLightTopMargin;
@synthesize showsBaselineSeparator = _showsBaselineSeparator;
@synthesize windowControllers = _windowControllers;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.windowControllers = [NSMutableArray array];
    // The class of the window has been set in INAppStoreWindow in Interface Builder
    self.window.trafficLightButtonsLeftMargin = 7.0;
    self.window.trafficLightButtonsTopMargin = 0.0;
    self.window.fullScreenButtonRightMargin = 7.0; 
    self.window.hideTitleBarInFullScreen = YES;    
    self.window.centerFullScreenButton = YES;    
    self.window.titleBarHeight = 40.0;
    
    // set checkboxes
    self.centerFullScreen.state = self.window.centerFullScreenButton;
    self.centerTrafficLight.state = self.window.centerTrafficLightButtons;
    self.showsBaselineSeparator.state = self.window.showsBaselineSeparator;
    self.fullScreenRightMarginSlider.doubleValue = self.window.fullScreenButtonRightMargin;
    self.trafficLightLeftMargin.doubleValue = self.window.trafficLightButtonsLeftMargin;
    self.trafficLightTopMargin.doubleValue = self.window.trafficLightButtonsTopMargin;
}

// window delegate to correct the position of the sheet
- (NSRect)window:(INAppStoreWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect
{
    rect.origin.y = NSHeight(window.frame)-window.titleBarHeight;
    return rect;
}

- (IBAction)showSheetAction:(id)sender
{
    [NSApp beginSheet:self.sheet modalForWindow:self.window
        modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (IBAction)doneSheetAction:(id)sender
{
    [self.sheet orderOut:nil];
    [NSApp endSheet:self.sheet];
}

- (IBAction)createWindowController:(id)sender
{
    SampleWindowController *controller = [[SampleWindowController alloc] initWithWindowNibName:@"SampleWindow"];
    [controller showWindow:nil];
    [self.windowControllers addObject:controller];
    [controller release];
}

- (IBAction)checkboxAction:(id)sender
{
    if ( [sender isEqual:self.centerFullScreen] ) {
        self.window.centerFullScreenButton = [sender state];
    } else if ( [sender isEqual:self.centerTrafficLight] ) {
        self.window.centerTrafficLightButtons = [sender state];        
    } else {
        self.window.showsBaselineSeparator = [sender state];
    }
}

- (IBAction)sliderAction:(id)sender 
{
    if ( [sender isEqual:self.fullScreenRightMarginSlider] ) {
        self.window.fullScreenButtonRightMargin = [sender doubleValue];
    } else if ( [sender isEqual:self.trafficLightTopMargin] ) {
        self.window.trafficLightButtonsTopMargin = [sender doubleValue];
    } else {
        self.window.trafficLightButtonsLeftMargin = [sender doubleValue];
    }    
}

- (void)dealloc
{
    [_windowControllers release];
    [super dealloc];
}
@end
