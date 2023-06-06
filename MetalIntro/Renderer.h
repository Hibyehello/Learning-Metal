//
//  Renderer.h
//  MetalIntro
//
//  Created by Hibyehello on 5/11/23.
//

#ifndef Renderer_h
#define Renderer_h

#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Renderer : MTKView
@property id<MTLCommandQueue> queue;
@property id<MTLLibrary> mtlLibrary;
@property id<MTLCommandBuffer> cmdbuffer;
@property id<MTLRenderPipelineState> state;
@property id<MTLRenderCommandEncoder> encoder;
@property NSArray* vertices;
@property id<MTLBuffer> vtxBuffer;
@property id<MTLBuffer> colorBuffer;

-(id)initWithFrame:(NSRect)rect
            device:(id<MTLDevice>)device;

-(void)present;

-(id<MTLRenderPipelineState>)buildRenderPipeline;
@end

#endif /* Renderer_h */
