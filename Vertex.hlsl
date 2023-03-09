struct InputVertex
{
	float3 Pos : POSITION;
	float4 Color : COLOR;
	float2 Tex : TEXCORD;
	float3 norm : NORMAL;
	float4 indices : INDICES;
	float4 weights : WEIGHTS;
};

struct OutputVertex
{
	float4 Pos : SV_POSITION;
	float4 color : COLOR0;
	float2 Tex : TEXTURE;
	float3 norm : NORM;
	float4 Wpos : WPOSITION;
};

cbuffer Con : register(b0)
{
	matrix World;
	matrix View;
	matrix Projection;
	float4 LightPosition;
	float4 CameraPosition;
	matrix m[28];
};

OutputVertex main(InputVertex input)
{
	OutputVertex output;

	float4 skinned_pos = { 0.0f,0.0f,0.0f,0.0f };
	float4 skinned_norm = { 0.0f,0.0f,0.0f,0.0f };

	for (int i = 0; i < 4; i++)
	{
		skinned_pos += mul(float4(input.Pos.xyz, 1.0f), m[input.indices[i]]) * input.weights[i];
		skinned_norm += mul(float4(input.norm.xyz, 0.0f), m[input.indices[i]]) * input.weights[i];
	}

	output.Pos = mul(float4(skinned_pos.xyz, 1.0f), World);

	output.Wpos = output.Pos;

	output.Pos = mul(output.Pos, View);
	output.Pos = mul(output.Pos, Projection);

	output.Tex = input.Tex;
	
	output.norm = mul(skinned_norm, World);

	output.color = input.Color;

	



	return output;
}