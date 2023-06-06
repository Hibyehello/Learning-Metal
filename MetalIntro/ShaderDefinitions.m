//
//  ShaderDefinitions.m
//  MetalIntro
//
//  Created by Hibyehello on 5/12/23.
//

#import "ShaderDefinitions.h"

Vertex vertex_ct(vector_float4 color, vector_float2 pos)
{
    Vertex vertex = {color, pos};
    return vertex;
}
