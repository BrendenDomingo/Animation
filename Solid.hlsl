

struct VSOut
{
	float4 Pos : SV_POSITION;
	float4 color : COLOR0;
	float2 TEX : TEXTURE;
	float3 norm : NORM;
	float4 wpos : WPOSITION;
};

cbuffer Con : register(b0)
{
	matrix World;
	matrix View;
	matrix Projection;
	float4 LightPosition;
	float4 CameraPosition;

};

float4 main(VSOut input) : SV_TARGET
{
	return input.color * 5;
}