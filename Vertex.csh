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
//   float4x4 World;                    // Offset:    0 Size:    64
//   float4x4 View;                     // Offset:   64 Size:    64
//   float4x4 Projection;               // Offset:  128 Size:    64
//   float4 LightPosition;              // Offset:  192 Size:    16 [unused]
//   float4 CameraPosition;             // Offset:  208 Size:    16 [unused]
//   float4x4 m[28];                    // Offset:  224 Size:  1792
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// Con                               cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// POSITION                 0   xyz         0     NONE   float   xyz 
// COLOR                    0   xyzw        1     NONE   float   xyzw
// TEXCORD                  0   xy          2     NONE   float   xy  
// NORMAL                   0   xyz         3     NONE   float   xyz 
// INDICES                  0   xyzw        4     NONE   float   xyzw
// WEIGHTS                  0   xyzw        5     NONE   float   xyzw
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float   xyzw
// COLOR                    0   xyzw        1     NONE   float   xyzw
// TEXTURE                  0   xy          2     NONE   float   xy  
// NORM                     0   xyz         3     NONE   float   xyz 
// WPOSITION                0   xyzw        4     NONE   float   xyzw
//
vs_4_0
dcl_constantbuffer CB0[126], dynamicIndexed
dcl_input v0.xyz
dcl_input v1.xyzw
dcl_input v2.xy
dcl_input v3.xyz
dcl_input v4.xyzw
dcl_input v5.xyzw
dcl_output_siv o0.xyzw, position
dcl_output o1.xyzw
dcl_output o2.xy
dcl_output o3.xyz
dcl_output o4.xyzw
dcl_temps 4
mov r0.xyz, v0.xyzx
mov r0.w, l(1.000000)
ftou r1.xyzw, v4.xyzw
ishl r1.xyzw, r1.xyzw, l(2)
dp4 r2.x, r0.xyzw, cb0[r1.y + 14].xyzw
dp4 r2.y, r0.xyzw, cb0[r1.y + 15].xyzw
dp4 r2.z, r0.xyzw, cb0[r1.y + 16].xyzw
mul r2.xyz, r2.xyzx, v5.yyyy
dp4 r3.x, r0.xyzw, cb0[r1.x + 14].xyzw
dp4 r3.y, r0.xyzw, cb0[r1.x + 15].xyzw
dp4 r3.z, r0.xyzw, cb0[r1.x + 16].xyzw
mad r2.xyz, r3.xyzx, v5.xxxx, r2.xyzx
dp4 r3.x, r0.xyzw, cb0[r1.z + 14].xyzw
dp4 r3.y, r0.xyzw, cb0[r1.z + 15].xyzw
dp4 r3.z, r0.xyzw, cb0[r1.z + 16].xyzw
mad r2.xyz, r3.xyzx, v5.zzzz, r2.xyzx
dp4 r3.x, r0.xyzw, cb0[r1.w + 14].xyzw
dp4 r3.y, r0.xyzw, cb0[r1.w + 15].xyzw
dp4 r3.z, r0.xyzw, cb0[r1.w + 16].xyzw
mad r0.xyz, r3.xyzx, v5.wwww, r2.xyzx
mov r0.w, l(1.000000)
dp4 r2.x, r0.xyzw, cb0[0].xyzw
dp4 r2.y, r0.xyzw, cb0[1].xyzw
dp4 r2.z, r0.xyzw, cb0[2].xyzw
dp4 r2.w, r0.xyzw, cb0[3].xyzw
dp4 r0.x, r2.xyzw, cb0[4].xyzw
dp4 r0.y, r2.xyzw, cb0[5].xyzw
dp4 r0.z, r2.xyzw, cb0[6].xyzw
dp4 r0.w, r2.xyzw, cb0[7].xyzw
mov o4.xyzw, r2.xyzw
dp4 o0.x, r0.xyzw, cb0[8].xyzw
dp4 o0.y, r0.xyzw, cb0[9].xyzw
dp4 o0.z, r0.xyzw, cb0[10].xyzw
dp4 o0.w, r0.xyzw, cb0[11].xyzw
mov o1.xyzw, v1.xyzw
mov o2.xy, v2.xyxx
dp3 r0.x, v3.xyzx, cb0[r1.y + 14].xyzx
dp3 r0.y, v3.xyzx, cb0[r1.y + 15].xyzx
dp3 r0.z, v3.xyzx, cb0[r1.y + 16].xyzx
dp3 r0.w, v3.xyzx, cb0[r1.y + 17].xyzx
mul r0.xyzw, r0.xyzw, v5.yyyy
dp3 r2.x, v3.xyzx, cb0[r1.x + 14].xyzx
dp3 r2.y, v3.xyzx, cb0[r1.x + 15].xyzx
dp3 r2.z, v3.xyzx, cb0[r1.x + 16].xyzx
dp3 r2.w, v3.xyzx, cb0[r1.x + 17].xyzx
mad r0.xyzw, r2.xyzw, v5.xxxx, r0.xyzw
dp3 r2.x, v3.xyzx, cb0[r1.z + 14].xyzx
dp3 r2.y, v3.xyzx, cb0[r1.z + 15].xyzx
dp3 r2.z, v3.xyzx, cb0[r1.z + 16].xyzx
dp3 r2.w, v3.xyzx, cb0[r1.z + 17].xyzx
mad r0.xyzw, r2.xyzw, v5.zzzz, r0.xyzw
dp3 r2.x, v3.xyzx, cb0[r1.w + 14].xyzx
dp3 r2.y, v3.xyzx, cb0[r1.w + 15].xyzx
dp3 r2.z, v3.xyzx, cb0[r1.w + 16].xyzx
dp3 r2.w, v3.xyzx, cb0[r1.w + 17].xyzx
mad r0.xyzw, r2.xyzw, v5.wwww, r0.xyzw
dp4 o3.x, r0.xyzw, cb0[0].xyzw
dp4 o3.y, r0.xyzw, cb0[1].xyzw
dp4 o3.z, r0.xyzw, cb0[2].xyzw
ret 
// Approximately 60 instruction slots used
#endif

const BYTE Vertex[] =
{
     68,  88,  66,  67,  33,  53, 
    163, 135,  25,  93, 216, 158, 
    244, 133,  15,  22, 143, 114, 
     29, 152,   1,   0,   0,   0, 
    100,  12,   0,   0,   5,   0, 
      0,   0,  52,   0,   0,   0, 
    184,   1,   0,   0, 136,   2, 
      0,   0,  60,   3,   0,   0, 
    232,  11,   0,   0,  82,  68, 
     69,  70, 124,   1,   0,   0, 
      1,   0,   0,   0,  64,   0, 
      0,   0,   1,   0,   0,   0, 
     28,   0,   0,   0,   0,   4, 
    254, 255,   0,   1,   0,   0, 
     84,   1,   0,   0,  60,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   1,   0, 
      0,   0,   1,   0,   0,   0, 
     67, 111, 110,   0,  60,   0, 
      0,   0,   6,   0,   0,   0, 
     88,   0,   0,   0, 224,   7, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0, 232,   0, 
      0,   0,   0,   0,   0,   0, 
     64,   0,   0,   0,   2,   0, 
      0,   0, 240,   0,   0,   0, 
      0,   0,   0,   0,   0,   1, 
      0,   0,  64,   0,   0,   0, 
     64,   0,   0,   0,   2,   0, 
      0,   0, 240,   0,   0,   0, 
      0,   0,   0,   0,   5,   1, 
      0,   0, 128,   0,   0,   0, 
     64,   0,   0,   0,   2,   0, 
      0,   0, 240,   0,   0,   0, 
      0,   0,   0,   0,  16,   1, 
      0,   0, 192,   0,   0,   0, 
     16,   0,   0,   0,   0,   0, 
      0,   0,  32,   1,   0,   0, 
      0,   0,   0,   0,  48,   1, 
      0,   0, 208,   0,   0,   0, 
     16,   0,   0,   0,   0,   0, 
      0,   0,  32,   1,   0,   0, 
      0,   0,   0,   0,  63,   1, 
      0,   0, 224,   0,   0,   0, 
      0,   7,   0,   0,   2,   0, 
      0,   0,  68,   1,   0,   0, 
      0,   0,   0,   0,  87, 111, 
    114, 108, 100,   0, 171, 171, 
      3,   0,   3,   0,   4,   0, 
      4,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,  86, 105, 
    101, 119,   0,  80, 114, 111, 
    106, 101,  99, 116, 105, 111, 
    110,   0,  76, 105, 103, 104, 
    116,  80, 111, 115, 105, 116, 
    105, 111, 110,   0, 171, 171, 
      1,   0,   3,   0,   1,   0, 
      4,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,  67,  97, 
    109, 101, 114,  97,  80, 111, 
    115, 105, 116, 105, 111, 110, 
      0, 109,   0, 171, 171, 171, 
      3,   0,   3,   0,   4,   0, 
      4,   0,  28,   0,   0,   0, 
      0,   0,   0,   0,  77, 105, 
     99, 114, 111, 115, 111, 102, 
    116,  32,  40,  82,  41,  32, 
     72,  76,  83,  76,  32,  83, 
    104,  97, 100, 101, 114,  32, 
     67, 111, 109, 112, 105, 108, 
    101, 114,  32,  49,  48,  46, 
     49,   0,  73,  83,  71,  78, 
    200,   0,   0,   0,   6,   0, 
      0,   0,   8,   0,   0,   0, 
    152,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   0,   0, 
      0,   0,   7,   7,   0,   0, 
    161,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   1,   0, 
      0,   0,  15,  15,   0,   0, 
    167,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   2,   0, 
      0,   0,   3,   3,   0,   0, 
    175,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   3,   0, 
      0,   0,   7,   7,   0,   0, 
    182,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   4,   0, 
      0,   0,  15,  15,   0,   0, 
    190,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      3,   0,   0,   0,   5,   0, 
      0,   0,  15,  15,   0,   0, 
     80,  79,  83,  73,  84,  73, 
     79,  78,   0,  67,  79,  76, 
     79,  82,   0,  84,  69,  88, 
     67,  79,  82,  68,   0,  78, 
     79,  82,  77,  65,  76,   0, 
     73,  78,  68,  73,  67,  69, 
     83,   0,  87,  69,  73,  71, 
     72,  84,  83,   0, 171, 171, 
     79,  83,  71,  78, 172,   0, 
      0,   0,   5,   0,   0,   0, 
      8,   0,   0,   0, 128,   0, 
      0,   0,   0,   0,   0,   0, 
      1,   0,   0,   0,   3,   0, 
      0,   0,   0,   0,   0,   0, 
     15,   0,   0,   0, 140,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   3,   0, 
      0,   0,   1,   0,   0,   0, 
     15,   0,   0,   0, 146,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   3,   0, 
      0,   0,   2,   0,   0,   0, 
      3,  12,   0,   0, 154,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   3,   0, 
      0,   0,   3,   0,   0,   0, 
      7,   8,   0,   0, 159,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   3,   0, 
      0,   0,   4,   0,   0,   0, 
     15,   0,   0,   0,  83,  86, 
     95,  80,  79,  83,  73,  84, 
     73,  79,  78,   0,  67,  79, 
     76,  79,  82,   0,  84,  69, 
     88,  84,  85,  82,  69,   0, 
     78,  79,  82,  77,   0,  87, 
     80,  79,  83,  73,  84,  73, 
     79,  78,   0, 171, 171, 171, 
     83,  72,  68,  82, 164,   8, 
      0,   0,  64,   0,   1,   0, 
     41,   2,   0,   0,  89,   8, 
      0,   4,  70, 142,  32,   0, 
      0,   0,   0,   0, 126,   0, 
      0,   0,  95,   0,   0,   3, 
    114,  16,  16,   0,   0,   0, 
      0,   0,  95,   0,   0,   3, 
    242,  16,  16,   0,   1,   0, 
      0,   0,  95,   0,   0,   3, 
     50,  16,  16,   0,   2,   0, 
      0,   0,  95,   0,   0,   3, 
    114,  16,  16,   0,   3,   0, 
      0,   0,  95,   0,   0,   3, 
    242,  16,  16,   0,   4,   0, 
      0,   0,  95,   0,   0,   3, 
    242,  16,  16,   0,   5,   0, 
      0,   0, 103,   0,   0,   4, 
    242,  32,  16,   0,   0,   0, 
      0,   0,   1,   0,   0,   0, 
    101,   0,   0,   3, 242,  32, 
     16,   0,   1,   0,   0,   0, 
    101,   0,   0,   3,  50,  32, 
     16,   0,   2,   0,   0,   0, 
    101,   0,   0,   3, 114,  32, 
     16,   0,   3,   0,   0,   0, 
    101,   0,   0,   3, 242,  32, 
     16,   0,   4,   0,   0,   0, 
    104,   0,   0,   2,   4,   0, 
      0,   0,  54,   0,   0,   5, 
    114,   0,  16,   0,   0,   0, 
      0,   0,  70,  18,  16,   0, 
      0,   0,   0,   0,  54,   0, 
      0,   5, 130,   0,  16,   0, 
      0,   0,   0,   0,   1,  64, 
      0,   0,   0,   0, 128,  63, 
     28,   0,   0,   5, 242,   0, 
     16,   0,   1,   0,   0,   0, 
     70,  30,  16,   0,   4,   0, 
      0,   0,  41,   0,   0,   7, 
    242,   0,  16,   0,   1,   0, 
      0,   0,  70,  14,  16,   0, 
      1,   0,   0,   0,   1,  64, 
      0,   0,   2,   0,   0,   0, 
     17,   0,   0,  10,  18,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   6, 
      0,   0,   0,   0,  14,   0, 
      0,   0,  26,   0,  16,   0, 
      1,   0,   0,   0,  17,   0, 
      0,  10,  34,   0,  16,   0, 
      2,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     70, 142,  32,   6,   0,   0, 
      0,   0,  15,   0,   0,   0, 
     26,   0,  16,   0,   1,   0, 
      0,   0,  17,   0,   0,  10, 
     66,   0,  16,   0,   2,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   6,   0,   0,   0,   0, 
     16,   0,   0,   0,  26,   0, 
     16,   0,   1,   0,   0,   0, 
     56,   0,   0,   7, 114,   0, 
     16,   0,   2,   0,   0,   0, 
     70,   2,  16,   0,   2,   0, 
      0,   0,  86,  21,  16,   0, 
      5,   0,   0,   0,  17,   0, 
      0,  10,  18,   0,  16,   0, 
      3,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     70, 142,  32,   6,   0,   0, 
      0,   0,  14,   0,   0,   0, 
     10,   0,  16,   0,   1,   0, 
      0,   0,  17,   0,   0,  10, 
     34,   0,  16,   0,   3,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   6,   0,   0,   0,   0, 
     15,   0,   0,   0,  10,   0, 
     16,   0,   1,   0,   0,   0, 
     17,   0,   0,  10,  66,   0, 
     16,   0,   3,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   6, 
      0,   0,   0,   0,  16,   0, 
      0,   0,  10,   0,  16,   0, 
      1,   0,   0,   0,  50,   0, 
      0,   9, 114,   0,  16,   0, 
      2,   0,   0,   0,  70,   2, 
     16,   0,   3,   0,   0,   0, 
      6,  16,  16,   0,   5,   0, 
      0,   0,  70,   2,  16,   0, 
      2,   0,   0,   0,  17,   0, 
      0,  10,  18,   0,  16,   0, 
      3,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     70, 142,  32,   6,   0,   0, 
      0,   0,  14,   0,   0,   0, 
     42,   0,  16,   0,   1,   0, 
      0,   0,  17,   0,   0,  10, 
     34,   0,  16,   0,   3,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   6,   0,   0,   0,   0, 
     15,   0,   0,   0,  42,   0, 
     16,   0,   1,   0,   0,   0, 
     17,   0,   0,  10,  66,   0, 
     16,   0,   3,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   6, 
      0,   0,   0,   0,  16,   0, 
      0,   0,  42,   0,  16,   0, 
      1,   0,   0,   0,  50,   0, 
      0,   9, 114,   0,  16,   0, 
      2,   0,   0,   0,  70,   2, 
     16,   0,   3,   0,   0,   0, 
    166,  26,  16,   0,   5,   0, 
      0,   0,  70,   2,  16,   0, 
      2,   0,   0,   0,  17,   0, 
      0,  10,  18,   0,  16,   0, 
      3,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     70, 142,  32,   6,   0,   0, 
      0,   0,  14,   0,   0,   0, 
     58,   0,  16,   0,   1,   0, 
      0,   0,  17,   0,   0,  10, 
     34,   0,  16,   0,   3,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   6,   0,   0,   0,   0, 
     15,   0,   0,   0,  58,   0, 
     16,   0,   1,   0,   0,   0, 
     17,   0,   0,  10,  66,   0, 
     16,   0,   3,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   6, 
      0,   0,   0,   0,  16,   0, 
      0,   0,  58,   0,  16,   0, 
      1,   0,   0,   0,  50,   0, 
      0,   9, 114,   0,  16,   0, 
      0,   0,   0,   0,  70,   2, 
     16,   0,   3,   0,   0,   0, 
    246,  31,  16,   0,   5,   0, 
      0,   0,  70,   2,  16,   0, 
      2,   0,   0,   0,  54,   0, 
      0,   5, 130,   0,  16,   0, 
      0,   0,   0,   0,   1,  64, 
      0,   0,   0,   0, 128,  63, 
     17,   0,   0,   8,  18,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,  17,   0,   0,   8, 
     34,   0,  16,   0,   2,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      1,   0,   0,   0,  17,   0, 
      0,   8,  66,   0,  16,   0, 
      2,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     70, 142,  32,   0,   0,   0, 
      0,   0,   2,   0,   0,   0, 
     17,   0,   0,   8, 130,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   0, 
      0,   0,   0,   0,   3,   0, 
      0,   0,  17,   0,   0,   8, 
     18,   0,  16,   0,   0,   0, 
      0,   0,  70,  14,  16,   0, 
      2,   0,   0,   0,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      4,   0,   0,   0,  17,   0, 
      0,   8,  34,   0,  16,   0, 
      0,   0,   0,   0,  70,  14, 
     16,   0,   2,   0,   0,   0, 
     70, 142,  32,   0,   0,   0, 
      0,   0,   5,   0,   0,   0, 
     17,   0,   0,   8,  66,   0, 
     16,   0,   0,   0,   0,   0, 
     70,  14,  16,   0,   2,   0, 
      0,   0,  70, 142,  32,   0, 
      0,   0,   0,   0,   6,   0, 
      0,   0,  17,   0,   0,   8, 
    130,   0,  16,   0,   0,   0, 
      0,   0,  70,  14,  16,   0, 
      2,   0,   0,   0,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      7,   0,   0,   0,  54,   0, 
      0,   5, 242,  32,  16,   0, 
      4,   0,   0,   0,  70,  14, 
     16,   0,   2,   0,   0,   0, 
     17,   0,   0,   8,  18,  32, 
     16,   0,   0,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   0, 
      0,   0,   0,   0,   8,   0, 
      0,   0,  17,   0,   0,   8, 
     34,  32,  16,   0,   0,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      9,   0,   0,   0,  17,   0, 
      0,   8,  66,  32,  16,   0, 
      0,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     70, 142,  32,   0,   0,   0, 
      0,   0,  10,   0,   0,   0, 
     17,   0,   0,   8, 130,  32, 
     16,   0,   0,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   0, 
      0,   0,   0,   0,  11,   0, 
      0,   0,  54,   0,   0,   5, 
    242,  32,  16,   0,   1,   0, 
      0,   0,  70,  30,  16,   0, 
      1,   0,   0,   0,  54,   0, 
      0,   5,  50,  32,  16,   0, 
      2,   0,   0,   0,  70,  16, 
     16,   0,   2,   0,   0,   0, 
     16,   0,   0,  10,  18,   0, 
     16,   0,   0,   0,   0,   0, 
     70,  18,  16,   0,   3,   0, 
      0,   0,  70, 130,  32,   6, 
      0,   0,   0,   0,  14,   0, 
      0,   0,  26,   0,  16,   0, 
      1,   0,   0,   0,  16,   0, 
      0,  10,  34,   0,  16,   0, 
      0,   0,   0,   0,  70,  18, 
     16,   0,   3,   0,   0,   0, 
     70, 130,  32,   6,   0,   0, 
      0,   0,  15,   0,   0,   0, 
     26,   0,  16,   0,   1,   0, 
      0,   0,  16,   0,   0,  10, 
     66,   0,  16,   0,   0,   0, 
      0,   0,  70,  18,  16,   0, 
      3,   0,   0,   0,  70, 130, 
     32,   6,   0,   0,   0,   0, 
     16,   0,   0,   0,  26,   0, 
     16,   0,   1,   0,   0,   0, 
     16,   0,   0,  10, 130,   0, 
     16,   0,   0,   0,   0,   0, 
     70,  18,  16,   0,   3,   0, 
      0,   0,  70, 130,  32,   6, 
      0,   0,   0,   0,  17,   0, 
      0,   0,  26,   0,  16,   0, 
      1,   0,   0,   0,  56,   0, 
      0,   7, 242,   0,  16,   0, 
      0,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     86,  21,  16,   0,   5,   0, 
      0,   0,  16,   0,   0,  10, 
     18,   0,  16,   0,   2,   0, 
      0,   0,  70,  18,  16,   0, 
      3,   0,   0,   0,  70, 130, 
     32,   6,   0,   0,   0,   0, 
     14,   0,   0,   0,  10,   0, 
     16,   0,   1,   0,   0,   0, 
     16,   0,   0,  10,  34,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  18,  16,   0,   3,   0, 
      0,   0,  70, 130,  32,   6, 
      0,   0,   0,   0,  15,   0, 
      0,   0,  10,   0,  16,   0, 
      1,   0,   0,   0,  16,   0, 
      0,  10,  66,   0,  16,   0, 
      2,   0,   0,   0,  70,  18, 
     16,   0,   3,   0,   0,   0, 
     70, 130,  32,   6,   0,   0, 
      0,   0,  16,   0,   0,   0, 
     10,   0,  16,   0,   1,   0, 
      0,   0,  16,   0,   0,  10, 
    130,   0,  16,   0,   2,   0, 
      0,   0,  70,  18,  16,   0, 
      3,   0,   0,   0,  70, 130, 
     32,   6,   0,   0,   0,   0, 
     17,   0,   0,   0,  10,   0, 
     16,   0,   1,   0,   0,   0, 
     50,   0,   0,   9, 242,   0, 
     16,   0,   0,   0,   0,   0, 
     70,  14,  16,   0,   2,   0, 
      0,   0,   6,  16,  16,   0, 
      5,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     16,   0,   0,  10,  18,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  18,  16,   0,   3,   0, 
      0,   0,  70, 130,  32,   6, 
      0,   0,   0,   0,  14,   0, 
      0,   0,  42,   0,  16,   0, 
      1,   0,   0,   0,  16,   0, 
      0,  10,  34,   0,  16,   0, 
      2,   0,   0,   0,  70,  18, 
     16,   0,   3,   0,   0,   0, 
     70, 130,  32,   6,   0,   0, 
      0,   0,  15,   0,   0,   0, 
     42,   0,  16,   0,   1,   0, 
      0,   0,  16,   0,   0,  10, 
     66,   0,  16,   0,   2,   0, 
      0,   0,  70,  18,  16,   0, 
      3,   0,   0,   0,  70, 130, 
     32,   6,   0,   0,   0,   0, 
     16,   0,   0,   0,  42,   0, 
     16,   0,   1,   0,   0,   0, 
     16,   0,   0,  10, 130,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  18,  16,   0,   3,   0, 
      0,   0,  70, 130,  32,   6, 
      0,   0,   0,   0,  17,   0, 
      0,   0,  42,   0,  16,   0, 
      1,   0,   0,   0,  50,   0, 
      0,   9, 242,   0,  16,   0, 
      0,   0,   0,   0,  70,  14, 
     16,   0,   2,   0,   0,   0, 
    166,  26,  16,   0,   5,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  16,   0, 
      0,  10,  18,   0,  16,   0, 
      2,   0,   0,   0,  70,  18, 
     16,   0,   3,   0,   0,   0, 
     70, 130,  32,   6,   0,   0, 
      0,   0,  14,   0,   0,   0, 
     58,   0,  16,   0,   1,   0, 
      0,   0,  16,   0,   0,  10, 
     34,   0,  16,   0,   2,   0, 
      0,   0,  70,  18,  16,   0, 
      3,   0,   0,   0,  70, 130, 
     32,   6,   0,   0,   0,   0, 
     15,   0,   0,   0,  58,   0, 
     16,   0,   1,   0,   0,   0, 
     16,   0,   0,  10,  66,   0, 
     16,   0,   2,   0,   0,   0, 
     70,  18,  16,   0,   3,   0, 
      0,   0,  70, 130,  32,   6, 
      0,   0,   0,   0,  16,   0, 
      0,   0,  58,   0,  16,   0, 
      1,   0,   0,   0,  16,   0, 
      0,  10, 130,   0,  16,   0, 
      2,   0,   0,   0,  70,  18, 
     16,   0,   3,   0,   0,   0, 
     70, 130,  32,   6,   0,   0, 
      0,   0,  17,   0,   0,   0, 
     58,   0,  16,   0,   1,   0, 
      0,   0,  50,   0,   0,   9, 
    242,   0,  16,   0,   0,   0, 
      0,   0,  70,  14,  16,   0, 
      2,   0,   0,   0, 246,  31, 
     16,   0,   5,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  17,   0,   0,   8, 
     18,  32,  16,   0,   3,   0, 
      0,   0,  70,  14,  16,   0, 
      0,   0,   0,   0,  70, 142, 
     32,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,  17,   0, 
      0,   8,  34,  32,  16,   0, 
      3,   0,   0,   0,  70,  14, 
     16,   0,   0,   0,   0,   0, 
     70, 142,  32,   0,   0,   0, 
      0,   0,   1,   0,   0,   0, 
     17,   0,   0,   8,  66,  32, 
     16,   0,   3,   0,   0,   0, 
     70,  14,  16,   0,   0,   0, 
      0,   0,  70, 142,  32,   0, 
      0,   0,   0,   0,   2,   0, 
      0,   0,  62,   0,   0,   1, 
     83,  84,  65,  84, 116,   0, 
      0,   0,  60,   0,   0,   0, 
      4,   0,   0,   0,   0,   0, 
      0,   0,  11,   0,   0,   0, 
     51,   0,   0,   0,   1,   0, 
      0,   0,   0,   0,   0,   0, 
      1,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      6,   0,   0,   0,   0,   0, 
      0,   0,   1,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0,   0,   0, 
      0,   0,   0,   0
};
