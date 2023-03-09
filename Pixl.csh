#if 0
//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer Con
// {
//
//   float4x4 World;                    // Offset:    0 Size:    64 [unused]
//   float4x4 View;                     // Offset:   64 Size:    64 [unused]
//   float4x4 Projection;               // Offset:  128 Size:    64 [unused]
//   float4 LightPosition;              // Offset:  192 Size:    16
//   float4 CameraPosition;             // Offset:  208 Size:    16
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// simpleSampler                     sampler      NA          NA             s0      1 
// simpleTexture                     texture  float4          2d             t0      1 
// simpleTexture1                    texture  float4          2d             t1      1 
// simpleTexture2                    texture  float4          2d             t2      1 
// Con                               cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float       
// COLOR                    0   xyzw        1     NONE   float       
// TEXTURE                  0   xy          2     NONE   float   xy  
// NORM                     0   xyz         3     NONE   float   xyz 
// WPOSITION                0   xyzw        4     NONE   float   xyz 
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_TARGET                0   xyzw        0   TARGET   float   xyzw
//
ps_4_0
dcl_constantbuffer CB0[14], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t1
dcl_resource_texture2d (float,float,float,float) t2
dcl_input_ps linear v2.xy
dcl_input_ps linear v3.xyz
dcl_input_ps linear v4.xyz
dcl_output o0.xyzw
dcl_temps 3
add r0.xyz, -v4.xyzx, cb0[12].xyzx
dp3 r0.w, r0.xyzx, r0.xyzx
sqrt r1.x, r0.w
div r0.xyz, r0.xyzx, r1.xxxx
add r1.xyz, r0.xyzx, cb0[13].xyzx
dp3_sat r0.x, v3.xyzx, r0.xyzx
dp3 r0.y, r1.xyzx, r1.xyzx
rsq r0.y, r0.y
mul r1.xyz, r0.yyyy, r1.xyzx
dp3_sat r0.y, v3.xyzx, r1.xyzx
log r0.y, r0.y
mul r0.y, r0.y, l(25.000000)
exp r0.y, r0.y
sample r1.xyzw, v2.xyxx, t2.xyzw, s0
mul r1.xyz, r0.yyyy, r1.xyzx
mul r1.xyz, r1.xyzx, l(80.000000, 80.000000, 80.000000, 0.000000)
div r1.xyz, r1.xyzx, r0.wwww
sample r2.xyzw, v2.xyxx, t0.xyzw, s0
mul r0.xyz, r0.xxxx, r2.xyzx
mul r0.xyz, r0.xyzx, l(50.000000, 50.000000, 50.000000, 0.000000)
div r0.xyz, r0.xyzx, r0.wwww
add r0.xyz, r1.xyzx, r0.xyzx
sample r1.xyzw, v2.xyxx, t1.xyzw, s0
mad o0.xyz, r1.xyzx, l(2.000000, 2.000000, 2.000000, 0.000000), r0.xyzx
mov o0.w, l(1.000000)
ret 
// Approximately 26 instruction slots used
#endif

const BYTE Pixl[] =
{
     68,  88,  66,  67, 158,  73, 
    169,  24,  98, 244,  15,  42, 
    159,  96,   8, 161, 215, 119, 
     57,  10,   1,   0,   0,   0, 
     40,   7,   0,   0,   5,   0, 
      0,   0,  52,   0,   0,   0, 
     72,   2,   0,   0, 252,   2, 
      0,   0,  48,   3,   0,   0, 
    172,   6,   0,   0,  82,  68, 
     69,  70,  12,   2,   0,   0, 
      1,   0,   0,   0, 252,   0, 
      0,   0,   5,   0,   0,   0, 
     28,   0,   0,   0,   0,   4, 
    255, 255,   0,   1,   0,   0, 
    227,   1,   0,   0, 188,   0, 
      0,   0,   3,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   1,   0, 
      0,   0,   1,   0,   0,   0, 
    202,   0,   0,   0,   2,   0, 
      0,   0,   5,   0,   0,   0, 
      4,   0,   0,   0, 255, 255, 
    255, 255,   0,   0,   0,   0, 
      1,   0,   0,   0,  13,   0, 
      0,   0, 216,   0,   0,   0, 
      2,   0,   0,   0,   5,   0, 
      0,   0,   4,   0,   0,   0, 
    255, 255, 255, 255,   1,   0, 
      0,   0,   1,   0,   0,   0, 
     13,   0,   0,   0, 231,   0, 
      0,   0,   2,   0,   0,   0, 
      5,   0,   0,   0,   4,   0, 
      0,   0, 255, 255, 255, 255, 
      2,   0,   0,   0,   1,   0, 
      0,   0,  13,   0,   0,   0, 
    246,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      1,   0,   0,   0,   1,   0, 
      0,   0, 115, 105, 109, 112, 
    108, 101,  83,  97, 109, 112, 
    108, 101, 114,   0, 115, 105, 
    109, 112, 108, 101,  84, 101, 
    120, 116, 117, 114, 101,   0, 
    115, 105, 109, 112, 108, 101, 
     84, 101, 120, 116, 117, 114, 
    101,  49,   0, 115, 105, 109, 
    112, 108, 101,  84, 101, 120, 
    116, 117, 114, 101,  50,   0, 
     67, 111, 110,   0, 171, 171, 
    246,   0,   0,   0,   5,   0, 
      0,   0,  20,   1,   0,   0, 
    224,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
    140,   1,   0,   0,   0,   0, 
      0,   0,  64,   0,   0,   0, 
      0,   0,   0,   0, 148,   1, 
      0,   0,   0,   0,   0,   0, 
    164,   1,   0,   0,  64,   0, 
      0,   0,  64,   0,   0,   0, 
      0,   0,   0,   0, 148,   1, 
      0,   0,   0,   0,   0,   0, 
    169,   1,   0,   0, 128,   0, 
      0,   0,  64,   0,   0,   0, 
      0,   0,   0,   0, 148,   1, 
      0,   0,   0,   0,   0,   0, 
    180,   1,   0,   0, 192,   0, 
      0,   0,  16,   0,   0,   0, 
      2,   0,   0,   0, 196,   1, 
      0,   0,   0,   0,   0,   0, 
    212,   1,   0,   0, 208,   0, 
      0,   0,  16,   0,   0,   0, 
      2,   0,   0,   0, 196,   1, 
      0,   0,   0,   0,   0,   0, 
     87, 111, 114, 108, 100,   0, 
    171, 171,   3,   0,   3,   0, 
      4,   0,   4,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
     86, 105, 101, 119,   0,  80, 
    114, 111, 106, 101,  99, 116, 
    105, 111, 110,   0,  76, 105, 
    103, 104, 116,  80, 111, 115, 
    105, 116, 105, 111, 110,   0, 
    171, 171,   1,   0,   3,   0, 
      1,   0,   4,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
     67,  97, 109, 101, 114,  97, 
     80, 111, 115, 105, 116, 105, 
    111, 110,   0,  77, 105,  99, 
    114, 111, 115, 111, 102, 116, 
     32,  40,  82,  41,  32,  72, 
     76,  83,  76,  32,  83, 104, 
     97, 100, 101, 114,  32,  67, 
    111, 109, 112, 105, 108, 101, 
    114,  32,  49,  48,  46,  49, 
      0, 171,  73,  83,  71,  78, 
    172,   0,   0,   0,   5,   0, 
      0,   0,   8,   0,   0,   0, 
    128,   0,   0,   0,   0,   0, 
      0,   0,   1,   0,   0,   0, 
      3,   0,   0,   0,   0,   0, 
      0,   0,  15,   0,   0,   0, 
    140,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   1,   0, 
      0,   0,  15,   0,   0,   0, 
    146,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   2,   0, 
      0,   0,   3,   3,   0,   0, 
    154,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   3,   0, 
      0,   0,   7,   7,   0,   0, 
    159,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   4,   0, 
      0,   0,  15,   7,   0,   0, 
     83,  86,  95,  80,  79,  83, 
     73,  84,  73,  79,  78,   0, 
     67,  79,  76,  79,  82,   0, 
     84,  69,  88,  84,  85,  82, 
     69,   0,  78,  79,  82,  77, 
      0,  87,  80,  79,  83,  73, 
     84,  73,  79,  78,   0, 171, 
    171, 171,  79,  83,  71,  78, 
     44,   0,   0,   0,   1,   0, 
      0,   0,   8,   0,   0,   0, 
     32,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   0,   0, 
      0,   0,  15,   0,   0,   0, 
     83,  86,  95,  84,  65,  82, 
     71,  69,  84,   0, 171, 171, 
     83,  72,  68,  82, 116,   3, 
      0,   0,  64,   0,   0,   0, 
    221,   0,   0,   0,  89,   0, 
      0,   4,  70, 142,  32,   0, 
      0,   0,   0,   0,  14,   0, 
      0,   0,  90,   0,   0,   3, 
      0,  96,  16,   0,   0,   0, 
      0,   0,  88,  24,   0,   4, 
      0, 112,  16,   0,   0,   0, 
      0,   0,  85,  85,   0,   0, 
     88,  24,   0,   4,   0, 112, 
     16,   0,   1,   0,   0,   0, 
     85,  85,   0,   0,  88,  24, 
      0,   4,   0, 112,  16,   0, 
      2,   0,   0,   0,  85,  85, 
      0,   0,  98,  16,   0,   3, 
     50,  16,  16,   0,   2,   0, 
      0,   0,  98,  16,   0,   3, 
    114,  16,  16,   0,   3,   0, 
      0,   0,  98,  16,   0,   3, 
    114,  16,  16,   0,   4,   0, 
      0,   0, 101,   0,   0,   3, 
    242,  32,  16,   0,   0,   0, 
      0,   0, 104,   0,   0,   2, 
      3,   0,   0,   0,   0,   0, 
      0,   9, 114,   0,  16,   0, 
      0,   0,   0,   0,  70,  18, 
     16, 128,  65,   0,   0,   0, 
      4,   0,   0,   0,  70, 130, 
     32,   0,   0,   0,   0,   0, 
     12,   0,   0,   0,  16,   0, 
      0,   7, 130,   0,  16,   0, 
      0,   0,   0,   0,  70,   2, 
     16,   0,   0,   0,   0,   0, 
     70,   2,  16,   0,   0,   0, 
      0,   0,  75,   0,   0,   5, 
     18,   0,  16,   0,   1,   0, 
      0,   0,  58,   0,  16,   0, 
      0,   0,   0,   0,  14,   0, 
      0,   7, 114,   0,  16,   0, 
      0,   0,   0,   0,  70,   2, 
     16,   0,   0,   0,   0,   0, 
      6,   0,  16,   0,   1,   0, 
      0,   0,   0,   0,   0,   8, 
    114,   0,  16,   0,   1,   0, 
      0,   0,  70,   2,  16,   0, 
      0,   0,   0,   0,  70, 130, 
     32,   0,   0,   0,   0,   0, 
     13,   0,   0,   0,  16,  32, 
      0,   7,  18,   0,  16,   0, 
      0,   0,   0,   0,  70,  18, 
     16,   0,   3,   0,   0,   0, 
     70,   2,  16,   0,   0,   0, 
      0,   0,  16,   0,   0,   7, 
     34,   0,  16,   0,   0,   0, 
      0,   0,  70,   2,  16,   0, 
      1,   0,   0,   0,  70,   2, 
     16,   0,   1,   0,   0,   0, 
     68,   0,   0,   5,  34,   0, 
     16,   0,   0,   0,   0,   0, 
     26,   0,  16,   0,   0,   0, 
      0,   0,  56,   0,   0,   7, 
    114,   0,  16,   0,   1,   0, 
      0,   0,  86,   5,  16,   0, 
      0,   0,   0,   0,  70,   2, 
     16,   0,   1,   0,   0,   0, 
     16,  32,   0,   7,  34,   0, 
     16,   0,   0,   0,   0,   0, 
     70,  18,  16,   0,   3,   0, 
      0,   0,  70,   2,  16,   0, 
      1,   0,   0,   0,  47,   0, 
      0,   5,  34,   0,  16,   0, 
      0,   0,   0,   0,  26,   0, 
     16,   0,   0,   0,   0,   0, 
     56,   0,   0,   7,  34,   0, 
     16,   0,   0,   0,   0,   0, 
     26,   0,  16,   0,   0,   0, 
      0,   0,   1,  64,   0,   0, 
      0,   0, 200,  65,  25,   0, 
      0,   5,  34,   0,  16,   0, 
      0,   0,   0,   0,  26,   0, 
     16,   0,   0,   0,   0,   0, 
     69,   0,   0,   9, 242,   0, 
     16,   0,   1,   0,   0,   0, 
     70,  16,  16,   0,   2,   0, 
      0,   0,  70, 126,  16,   0, 
      2,   0,   0,   0,   0,  96, 
     16,   0,   0,   0,   0,   0, 
     56,   0,   0,   7, 114,   0, 
     16,   0,   1,   0,   0,   0, 
     86,   5,  16,   0,   0,   0, 
      0,   0,  70,   2,  16,   0, 
      1,   0,   0,   0,  56,   0, 
      0,  10, 114,   0,  16,   0, 
      1,   0,   0,   0,  70,   2, 
     16,   0,   1,   0,   0,   0, 
      2,  64,   0,   0,   0,   0, 
    160,  66,   0,   0, 160,  66, 
      0,   0, 160,  66,   0,   0, 
      0,   0,  14,   0,   0,   7, 
    114,   0,  16,   0,   1,   0, 
      0,   0,  70,   2,  16,   0, 
      1,   0,   0,   0, 246,  15, 
     16,   0,   0,   0,   0,   0, 
     69,   0,   0,   9, 242,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  16,  16,   0,   2,   0, 
      0,   0,  70, 126,  16,   0, 
      0,   0,   0,   0,   0,  96, 
     16,   0,   0,   0,   0,   0, 
     56,   0,   0,   7, 114,   0, 
     16,   0,   0,   0,   0,   0, 
      6,   0,  16,   0,   0,   0, 
      0,   0,  70,   2,  16,   0, 
      2,   0,   0,   0,  56,   0, 
      0,  10, 114,   0,  16,   0, 
      0,   0,   0,   0,  70,   2, 
     16,   0,   0,   0,   0,   0, 
      2,  64,   0,   0,   0,   0, 
     72,  66,   0,   0,  72,  66, 
      0,   0,  72,  66,   0,   0, 
      0,   0,  14,   0,   0,   7, 
    114,   0,  16,   0,   0,   0, 
      0,   0,  70,   2,  16,   0, 
      0,   0,   0,   0, 246,  15, 
     16,   0,   0,   0,   0,   0, 
      0,   0,   0,   7, 114,   0, 
     16,   0,   0,   0,   0,   0, 
     70,   2,  16,   0,   1,   0, 
      0,   0,  70,   2,  16,   0, 
      0,   0,   0,   0,  69,   0, 
      0,   9, 242,   0,  16,   0, 
      1,   0,   0,   0,  70,  16, 
     16,   0,   2,   0,   0,   0, 
     70, 126,  16,   0,   1,   0, 
      0,   0,   0,  96,  16,   0, 
      0,   0,   0,   0,  50,   0, 
      0,  12, 114,  32,  16,   0, 
      0,   0,   0,   0,  70,   2, 
     16,   0,   1,   0,   0,   0, 
      2,  64,   0,   0,   0,   0, 
      0,  64,   0,   0,   0,  64, 
      0,   0,   0,  64,   0,   0, 
      0,   0,  70,   2,  16,   0, 
      0,   0,   0,   0,  54,   0, 
      0,   5, 130,  32,  16,   0, 
      0,   0,   0,   0,   1,  64, 
      0,   0,   0,   0, 128,  63, 
     62,   0,   0,   1,  83,  84, 
     65,  84, 116,   0,   0,   0, 
     26,   0,   0,   0,   3,   0, 
      0,   0,   0,   0,   0,   0, 
      4,   0,   0,   0,  21,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   1,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   3,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   1,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0
};
