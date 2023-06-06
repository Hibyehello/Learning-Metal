//
//  ShaderDefinitions.h
//  MetalIntro
//
//  Created by Hibyehello on 5/11/23.
//

#ifndef ShaderDefinitions_h
#define ShaderDefinitions_h

#include <simd/simd.h>

typedef struct Vertex {
    vector_float4 color;
    vector_float2 pos;
} Vertex;

Vertex vertex_ct(vector_float4 color, vector_float2 pos);

#endif /* ShaderDefinitions_h */
