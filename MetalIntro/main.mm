//
//  main.m
//  MetalIntro
//
//  Created by Hibyehello on 5/10/23.
//

#import "Window.h"
#import "Renderer.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSRect m_window_rect = CGRectMake(0, 0, 800, 600);
         
        Window* m_window = [[Window alloc]initWithRect:m_window_rect
                                                 title:@"Window"];
        
        NSLog(@"GPU is : %@", m_window.renderer.device.name);
        
        [m_window MainLoop];
    }
    return 0;
}
