//
//  Renderer.m
//  MetalIntro
//
//  Created by Hibyehello on 5/11/23.
//

#import "Renderer.h"

@interface Vertex : NSObject {
    float _position[2];
    float _color[4];
}
    
@property(readonly) float* position;
@property(readonly) float* color;

-(id)initWithPosition:(float[2])position color:(float[4])color;
@end

@implementation Vertex

-(float *) position { return _position; }
-(float *) color { return _color; }

-(id)initWithPosition:(float[2])position color:(float[4])color {
    self = [super init];
    if (self) {
        _position[0] = position[0];
        _position[1] = position[1];
        _color[0] = color[0];
        _color[1] = color[1];
        _color[2] = color[2];
        _color[3] = color[3];
    }
    
    return self;
}

@end


@implementation Renderer
-(id)initWithFrame:(NSRect)rect
            device:(id<MTLDevice>)device;
{
    self = [super initWithFrame:rect device:device];
    
    if(self)
    {
        _queue = [device newCommandQueue];
        
        @try {
            _state = [self buildRenderPipeline];
        }
        @catch (NSException* e) {
            NSLog(@"Failed to build pipeline: %@", e.reason);
            return nil;
        }
        @finally {}
    }
    
    return self;
}

-(void)present
{
    @autoreleasepool {
        MTLRenderPassDescriptor* descriptor = self.currentRenderPassDescriptor;
        descriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.39, 0.75, 0.9, 1);
        
        self.cmdbuffer = [self.queue commandBuffer];
        self.encoder = [_cmdbuffer renderCommandEncoderWithDescriptor:descriptor];
        
        float pos[] = { -0.5, -0.5};
        float color[] = {1.0, 0.0, 0.0, 1.0};

        Vertex* v = [[Vertex alloc] initWithPosition:pos color:color];
        
        self.vtxBuffer = [self.device newBufferWithBytes:v.position length:sizeof(v.position) options:MTLResourceOptionCPUCacheModeDefault];
        
        self.colorBuffer = [self.device newBufferWithBytes:v.color length:sizeof(v.position) options:MTLResourceOptionCPUCacheModeDefault];
        
        [self.encoder setRenderPipelineState:self.state];
        [self.encoder setVertexBuffer:self.vtxBuffer offset:0 atIndex:0];
        [self.encoder setVertexBuffer:self.colorBuffer offset:0 atIndex:1];
        [self.encoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3 instanceCount:1];
        
        [self.encoder endEncoding];
        
        [self.cmdbuffer presentDrawable:self.currentDrawable];
        
        [self.cmdbuffer commit];
        
    }
    
}

-(id<MTLRenderPipelineState>)buildRenderPipeline
{
    MTLRenderPipelineDescriptor* descriptor = [MTLRenderPipelineDescriptor new];
    id<MTLLibrary> lib = [self.device newDefaultLibrary];
    
    descriptor.vertexFunction = [lib newFunctionWithName:@"vertexShader"];
    descriptor.fragmentFunction = [lib newFunctionWithName:@"fragmentShader"];
    
    descriptor.colorAttachments[0].pixelFormat = self.colorPixelFormat;
    return [self.device newRenderPipelineStateWithDescriptor:descriptor error:NULL];
}
@end
