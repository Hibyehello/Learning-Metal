//
//  Window.h
//  MetalIntro
//
//  Created by Hibyehello on 5/11/23.
//

#ifndef Window_h
#define Window_h

#import <AppKit/AppKit.h>
#import <Carbon/Carbon.h>
#import <Foundation/Foundation.h>

#import "Renderer.h"

@interface Window : NSWindow
@property Renderer* renderer;
@property BOOL running;
-(id)initWithRect:(NSRect)rect
                  title:(NSString*) t;
-(void)MainLoop;
@end


#endif /* Window_h */
