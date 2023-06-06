//
//  Shaders.metal
//  MetalIntro
//
//  Created by Hibyehello on 5/11/23.
//

#include <metal_stdlib>
#include "ShaderDefinitions.h"

struct vertexOut {
    float4 color;
    float4 pos [[position]];
};

using namespace metal;

vertex vertexOut vertexShader(const device float2 *pos [[buffer(0)]], constant float4 *color [[buffer(1)]], unsigned int vid [[vertex_id]])
{
    
    vertexOut out;
    out.color = color[vid];
    out.pos = float4(pos[vid].x, pos[vid].y, 0, 1);
    
    return out;
}

fragment float4 fragmentShader(vertexOut interpolated [[stage_in]])
{
    return interpolated.color;
}
