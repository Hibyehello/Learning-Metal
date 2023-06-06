//
//  Window.m
//  MetalIntro
//
//  Created by Hibyehello on 5/11/23.
//

#import "Window.h"
#import <Foundation/Foundation.h>

@implementation Window
-(void)stop {
    self.running = NO;
}

-(id)initWithRect:(NSRect)rect
                   title:(NSString*) t
{
    [NSApplication sharedApplication];
    
    [NSApplication.sharedApplication finishLaunching];
    
    unsigned long styleMask =
        NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable;
    self = [super initWithContentRect:rect
                            styleMask:styleMask
                              backing:NSBackingStoreBuffered
                                defer:NO];
    if (self)
    {
        self.title = t;
        self.running = YES;
        id<MTLDevice> device = MTLCreateSystemDefaultDevice();
        _renderer = [[Renderer alloc] initWithFrame:rect
                                                     device:device];
        
        
        
    }
    
    NSNotificationCenter* c = [NSNotificationCenter defaultCenter];
    [c addObserver:self
          selector:@selector(stop)
              name:NSWindowWillCloseNotification
            object:self];
    
    self.contentView = self.renderer;
    
    [self makeKeyAndOrderFront:NSApp];
    [self makeMainWindow];
    [NSApp activateIgnoringOtherApps:YES];
    return self;
}

-(void)MainLoop
{
    while(self.running)
    {
        NSDate* expiration = [NSDate dateWithTimeIntervalSinceNow:1];
        NSEvent* event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                                 untilDate:expiration
                                                    inMode:NSDefaultRunLoopMode
                                                   dequeue:YES];
        [self.renderer present];
        
        [NSApp sendEvent:event];
    }
    
    [NSApp stop:self];
}
@end
