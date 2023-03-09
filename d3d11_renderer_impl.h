#pragma once

#include "renderer.h"
#include "view.h"
#include "debug_renderer.h"
#include "WICTextureLoader.h"

#define WIN32_LEAN_AND_MEAN
#define SAFE_RELEASE(ptr) { if(ptr) { ptr->Release(); ptr = nullptr; } }

#include <Windows.h>
#include <dxgi1_2.h>
#include <d3d11_2.h>
#include <time.h>
#include <dxgi.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <DirectXMath.h>

#include "Vertex.csh"
#include "Pixl.csh"
#include "Solid.csh"
#include "Animation1.csh"

#pragma comment(lib, "d2d1.lib")
#pragma comment(lib, "d3d11.lib")
#pragma comment(lib, "DXGI.lib")

using namespace DirectX;

namespace end
{
	struct renderer::impl
	{
		ID3D11Device* device = nullptr;
		ID3D11DeviceContext* context = nullptr;
		IDXGISwapChain* swapchain = nullptr;

		ID3D11RenderTargetView*		render_target[VIEW_RENDER_TARGET::COUNT]{};

		ID3D11DepthStencilView*		depthStencilView[VIEW_DEPTH_STENCIL::COUNT]{};

		ID3D11DepthStencilState*	depthStencilState[STATE_DEPTH_STENCIL::COUNT]{};

		ID3D11Buffer*				vertex_buffer[VERTEX_BUFFER::COUNT]{};

		ID3D11Buffer*				index_buffer[INDEX_BUFFER::COUNT]{};
		
		ID3D11InputLayout*			input_layout[2]{};

		ID3D11VertexShader*			vertex_shader[2]{};

		ID3D11Buffer*				constant_buffer[CONSTANT_BUFFER::COUNT]{};

		ID3D11PixelShader*			pixel_shader[2]{};

		ID3D11RasterizerState*		rasterState[STATE_RASTERIZER::COUNT]{};

		D3D11_VIEWPORT				view_port[VIEWPORT::COUNT]{};

		ID3D11ShaderResourceView*	BATTLEMAGETexture[3];

		ID3D11SamplerState*			BATTLEMAGESamplerState = nullptr;

		ID3D11Texture2D*			BATTLEMAGETEXTURE;

		ID3D11Resource*				TempResource;
		
		HRESULT						hr;
	
		struct ConstantBuffer
		{
			XMMATRIX mWorld;
			XMMATRIX mView;
			XMMATRIX mProjection;
			float4 LightPosition;
			float4 CameraPosition;
			XMMATRIX matrices[28];
		};

		struct joint
		{
			float global_xform[16];
			int parent_index;
		};

		struct keyframe
		{
			double time;
			joint joints[28];
		};

		struct anim_clip
		{
			double duration;
			keyframe keyframes[17];
		};

		struct vert_pos_skinned
		{
			float Weights[4];
			int joints[4];
		};

		vert_pos_skinned vertposskinned[13392];



		joint joints[28];
		anim_clip animation;
		
		XMMATRIX World;
		XMMATRIX WORLD2;
		XMVECTOR Look;
		XMVECTOR UP;
		XMMATRIX Camera;

		float verticies[30132];
		float Normals[30132];
		float UVS[20088];
		bool check = true;
		int counter = 1;

		std::wstring DefusePath;
		std::wstring EmissivePath;
		std::wstring SpecPath;

		std::vector<float3> mesh;
		std::vector<float3> normals;
		std::vector<float2> UV;
	
		std::ifstream myFile;

		float4 Color = float4{ 1.0f,1.0f,1.0f,1.0f };
		float4 Color1 = float4{ 1.0f,0.0f,0.0f,1.0f };
		float4 Color2 = float4{ 0.0f,1.0f,0.0f,1.0f };
		float4 Color3 = float4{ 0.0f,0.0f,1.0f,1.0f };

		float2 ZEROS = { 0.0f,0.0f };
		float3 zeronorm = { 0.0f,0.0f,0.0f };
		float4 zerofour = { 0.0f,0.0f,0.0f,0.0f };

		float seconds;
		int timer = 0;
		DWORD thetime;

		XMMATRIX Translate;
		XMMATRIX Scale;
		XMMATRIX Rotate;

		XMMATRIX LookAt = XMMatrixTranslation(-0.5f,0.5f,0);
		XMMATRIX TurnTo = XMMatrixTranslation(0.5f,0.5f,0);
		XMMATRIX Move = XMMatrixTranslation(0, 0.2f, 0);

		ConstantBuffer CB;
		 
		impl(native_handle_type window_handle, view_t& default_view)
		{
			World = XMMatrixTranslation(0, 5, -15);
			Look = XMVECTOR{ 0, 0, 0 };
			UP = XMVECTOR{ 0, 1, 0 };

			Camera = XMMatrixLookAtLH(World.r[3],Look,UP);

			default_view.Projection = XMMatrixPerspectiveFovLH(XM_PIDIV4, 1280.0f/720.0f, 0.1f, 1000.0f);
			default_view.View = XMMatrixInverse(nullptr, Camera);

			thetime = GetTickCount();

			DXGI_SWAP_CHAIN_DESC sd;
			ZeroMemory(&sd, sizeof(sd));
			sd.BufferCount = 1;
			sd.BufferDesc.Width = 1280;
			sd.BufferDesc.Height = 720;
			sd.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
			sd.BufferDesc.RefreshRate.Numerator = 60;
			sd.BufferDesc.RefreshRate.Denominator = 1;
			sd.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
			sd.OutputWindow = (HWND)window_handle;
			sd.SampleDesc.Count = 1;
			sd.SampleDesc.Quality = 0;
			sd.Windowed = true;

			D3D_FEATURE_LEVEL  FeatureLevelsRequested = D3D_FEATURE_LEVEL_11_0 ;
			UINT               numLevelsRequested = 1;
			D3D_FEATURE_LEVEL  FeatureLevelsSupported;

			

			hr = D3D11CreateDeviceAndSwapChain(
				NULL,
				D3D_DRIVER_TYPE_HARDWARE,
				NULL,
				D3D11_CREATE_DEVICE_DEBUG,
				&FeatureLevelsRequested,
				1,
				D3D11_SDK_VERSION,
				&sd,
				&swapchain,
				&device,
				&FeatureLevelsSupported,
				&context);
			if (FAILED(hr)) 
			{ 
				MessageBox(nullptr, L"device or swapchain creation failed", L"Error", MB_OK);
				exit(0); 
			}

			ID3D11Texture2D* pBackBuffer = nullptr;
			swapchain->GetBuffer(0, __uuidof(ID3D11Texture2D), reinterpret_cast<void**>(&pBackBuffer));

			hr = device->CreateRenderTargetView(pBackBuffer, nullptr, &render_target[VIEW_RENDER_TARGET::DEFAULT]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"RTV", L"Error", MB_OK);
				exit(0);
			}
			pBackBuffer->Release();
			
			D3D11_BUFFER_DESC BD = {};
			BD.Usage = D3D11_USAGE_DEFAULT;
			BD.ByteWidth = sizeof(ConstantBuffer);
			BD.BindFlags = D3D11_BIND_CONSTANT_BUFFER;
			BD.CPUAccessFlags = 0;

			hr = device->CreateBuffer(&BD, nullptr, constant_buffer);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"constant buffer creation failed", L"Error", MB_OK);
				exit(0);
			}

			ID3D11Texture2D* pDepthStencil = NULL;
			D3D11_TEXTURE2D_DESC descDepth;
			descDepth.Width = 1280;
			descDepth.Height = 720;
			descDepth.MipLevels = 1;
			descDepth.ArraySize = 1;
			descDepth.Format = DXGI_FORMAT_D32_FLOAT; 
			descDepth.SampleDesc.Count = 1;
			descDepth.SampleDesc.Quality = 0;
			descDepth.Usage = D3D11_USAGE_DEFAULT;
			descDepth.BindFlags = D3D11_BIND_DEPTH_STENCIL;
			descDepth.CPUAccessFlags = 0;
			descDepth.MiscFlags = 0;

			hr = device->CreateTexture2D(&descDepth, NULL, &pDepthStencil);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"depth Stencil creation failed", L"Error", MB_OK);
				exit(0);
			}

			D3D11_DEPTH_STENCIL_DESC dsDesc;
			dsDesc.DepthEnable = true;
			dsDesc.DepthWriteMask = D3D11_DEPTH_WRITE_MASK_ALL;
			dsDesc.DepthFunc = D3D11_COMPARISON_LESS;
			dsDesc.StencilEnable = false;
			dsDesc.StencilReadMask = D3D11_DEFAULT_STENCIL_READ_MASK;
			dsDesc.StencilWriteMask = D3D11_DEFAULT_STENCIL_WRITE_MASK;
			dsDesc.FrontFace.StencilFailOp = D3D11_STENCIL_OP_KEEP;
			dsDesc.FrontFace.StencilDepthFailOp = D3D11_STENCIL_OP_KEEP;
			dsDesc.FrontFace.StencilPassOp = D3D11_STENCIL_OP_KEEP;
			dsDesc.FrontFace.StencilFunc = D3D11_COMPARISON_ALWAYS;
			dsDesc.BackFace.StencilFailOp = D3D11_STENCIL_OP_KEEP;
			dsDesc.BackFace.StencilDepthFailOp = D3D11_STENCIL_OP_KEEP;
			dsDesc.BackFace.StencilPassOp = D3D11_STENCIL_OP_KEEP;
			dsDesc.BackFace.StencilFunc = D3D11_COMPARISON_ALWAYS;

			hr = device->CreateDepthStencilState(&dsDesc, depthStencilState);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"deepth stencil state creation error", L"Error", MB_OK);
				exit(0);
			}

			context->OMSetDepthStencilState(depthStencilState[0], 1);
			
			hr = device->CreateDepthStencilView(pDepthStencil, nullptr, &depthStencilView[0]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Depth Stencil View Creation Error", L"Error", MB_OK);
				exit(0);
			}

			context->OMSetRenderTargets(1, render_target, depthStencilView[0]);

			D3D11_RASTERIZER_DESC RD;
			RD.FillMode = D3D11_FILL_SOLID;
			RD.CullMode = D3D11_CULL_NONE;
			RD.FrontCounterClockwise = false;
			RD.DepthBias = 0;
			RD.DepthBiasClamp = 0.0f;
			RD.SlopeScaledDepthBias = 0.0f;
			RD.DepthClipEnable = false;
			RD.ScissorEnable = false;
			RD.MultisampleEnable = true;
			RD.AntialiasedLineEnable = true;

			hr = device->CreateRasterizerState(&RD, rasterState);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Raster State Creation Error", L"Error", MB_OK);
				exit(0);
			}

			D3D11_INPUT_ELEMENT_DESC IputLayout[] =
			{
				{"POSITION", 0, DXGI_FORMAT_R32G32B32_FLOAT, 0,0,D3D11_INPUT_PER_VERTEX_DATA,0},
				{"COLOR", 0, DXGI_FORMAT_R32G32B32A32_FLOAT,0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0},
				{"TEXCORD", 0, DXGI_FORMAT_R32G32_FLOAT,0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0},
				{"NORMAL", 0, DXGI_FORMAT_R32G32B32_FLOAT, 0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0},
				{"INDICES", 0, DXGI_FORMAT_R32G32B32A32_FLOAT, 0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0},
				{"WEIGHTS", 0, DXGI_FORMAT_R32G32B32A32_FLOAT, 0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0},
			};

			hr = device->CreateInputLayout(IputLayout, 6, Vertex, sizeof(Vertex), &input_layout[0]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Input Layout Creation Error", L"Error", MB_OK);
				exit(0);
			}
			hr = device->CreateInputLayout(IputLayout, 6, Animation1, sizeof(Animation1), &input_layout[1]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Input Layout Creation Error", L"Error", MB_OK);
				exit(0);
			}

			//context->IASetInputLayout(input_layout[0]);
			//context->IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST);

			D3D11_SAMPLER_DESC Sampler = {};
			Sampler.Filter = D3D11_FILTER_MIN_MAG_MIP_LINEAR;
			Sampler.AddressU = D3D11_TEXTURE_ADDRESS_WRAP;
			Sampler.AddressV = D3D11_TEXTURE_ADDRESS_WRAP;
			Sampler.AddressW = D3D11_TEXTURE_ADDRESS_WRAP;
			Sampler.ComparisonFunc = D3D11_COMPARISON_NEVER;
			Sampler.MinLOD = 0;
			Sampler.MaxLOD = D3D11_FLOAT32_MAX;

			hr = device->CreateSamplerState(&Sampler, &BATTLEMAGESamplerState);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Sampler State Creation Error", L"Error", MB_OK);
				exit(0);
			}
			
			hr = device->CreateVertexShader(Vertex, sizeof(Vertex), nullptr, &vertex_shader[0]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Vertex Shader Creation Error", L"Error", MB_OK);
				exit(0);
			}

			hr = device->CreateVertexShader(Animation1, sizeof(Animation1), nullptr, &vertex_shader[1]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Vertex Shader Creation Error", L"Error", MB_OK);
				exit(0);
			}

			hr = device->CreatePixelShader(Pixl, sizeof(Pixl), nullptr, &pixel_shader[0]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Pixl Shaver Creation Error", L"Error", MB_OK);
				exit(0);
			}

			hr = device->CreatePixelShader(Solid, sizeof(Solid), nullptr, &pixel_shader[1]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Pixl Shaver2 Creation Error", L"Error", MB_OK);
				exit(0);
			}

			BD = {};
			BD.Usage = D3D11_USAGE_DEFAULT;
			BD.ByteWidth = sizeof(colored_vertex) * debug_renderer::get_line_vert_capacity();
			BD.BindFlags = D3D11_BIND_VERTEX_BUFFER;
			BD.CPUAccessFlags = 0;

			D3D11_SUBRESOURCE_DATA InitData = {};
			InitData.pSysMem = debug_renderer::get_line_verts();
			hr = device->CreateBuffer(&BD, &InitData, &vertex_buffer[0]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Vertex Buffer Creation Error", L"Error", MB_OK);
				exit(0);
			}

			myFile.open("BattleMageVerts.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageVerts.bin";
			}

			for (int i = 0; i < 30132; i++)
			{
				myFile.read((char*)&verticies[i], sizeof(float));
			}

			myFile.close();

			myFile.open("BattleMageWeights.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageVerts.bin";
			}

			myFile.read((char*)&vertposskinned, sizeof(vert_pos_skinned) * 13392);

			myFile.close();

			myFile.open("BattleMageNormals.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageNormals.bin";
			}

			for (int i = 0; i < 30132; i++)
			{
				myFile.read((char*)&Normals[i], sizeof(float));
			}

			myFile.close();

			myFile.open("BattleMageUV.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could Not find BattleMageUV.bin";
			}

			for (int i = 0; i < 20088; i++)
			{
				myFile.read((char*)&UVS[i], sizeof(float));
			}

			myFile.close();
			
			myFile.open("BattleMageD.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageD.bin";
			}

			int len = 0;
			myFile.read((char*)&len, sizeof(len));

			for (int i = 0; i < len + 4; i++)
			{
				char k;
				myFile.read(&k, 1);
				DefusePath += k;
			}

			DefusePath.erase(sizeof(char), 72);
			DefusePath[0] = 'P';
		
			myFile.close();

			myFile.open("BattleMageE.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageE.bin";
			}

			len = 0;
			myFile.read((char*)&len, sizeof(len));

			for (int i = 0; i < len + 4; i++)
			{
				char k;
				myFile.read(&k, 1);
				EmissivePath += k;
			}

			EmissivePath.erase(sizeof(char), 72);
			EmissivePath[0] = 'P';

			myFile.close();

			myFile.open("BattleMageS.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageS.bin";
			}

			len = 0;
			myFile.read((char*)&len, sizeof(len));

			for (int i = 0; i < len + 4; i++)
			{
				char k;
				myFile.read(&k, 1);
				SpecPath += k;
			}

			SpecPath.erase(sizeof(char), 72);
			SpecPath[0] = 'P';

			myFile.close();

			myFile.open("BattleMageJoints.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageJoints.bin";
			}

			myFile.read((char*)&joints, sizeof(joint) * 28);

			myFile.close();

			myFile.open("BattleMageAnimation.bin", std::ios::in | std::ios::binary);
			if (!myFile.is_open())
			{
				std::cout << "Could not find BattleMageJoints.bin";
			}

			myFile.read((char*)&animation, sizeof(anim_clip));

			myFile.close();

			hr = CreateWICTextureFromFileEx(device, DefusePath.c_str(), 0, D3D11_USAGE_DEFAULT, D3D11_BIND_SHADER_RESOURCE, 0, 0, WIC_LOADER_DEFAULT, &TempResource, &BATTLEMAGETexture[0]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Defuse Texture Creation", L"Error", MB_OK);
				exit(0);
			}

			hr = CreateWICTextureFromFileEx(device, EmissivePath.c_str(), 0, D3D11_USAGE_DEFAULT, D3D11_BIND_SHADER_RESOURCE, 0, 0, WIC_LOADER_DEFAULT, &TempResource, &BATTLEMAGETexture[1]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Emissive Texture Creation", L"Error", MB_OK);
				exit(0);
			}

			hr = CreateWICTextureFromFileEx(device, SpecPath.c_str(), 0, D3D11_USAGE_DEFAULT, D3D11_BIND_SHADER_RESOURCE, 0, 0, WIC_LOADER_DEFAULT, &TempResource, &BATTLEMAGETexture[2]);
			if (FAILED(hr))
			{
				MessageBox(nullptr, L"Specular Texture Creation", L"Error", MB_OK);
				exit(0);
			}

			for (int i = 0; i < 30132; i = i + 3)
			{
				float3 Vert = { verticies[i],verticies[i + 1],verticies[i + 2] };
				mesh.push_back(Vert);
			}

			for (int i = 0; i < 30132; i = i + 3)
			{
				float3 normal = { Normals[i],Normals[i + 1],Normals[i + 2] };
				normals.push_back(normal);
			}

			for (int i = 0; i < 20088; i = i + 2)
			{
				float2 uv = { UVS[i], 1 - UVS[i + 1] };
				UV.push_back(uv);
			}

			//context->IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST);
			//context->VSSetShader(vertex_shader[0], nullptr, 0);
			//context->VSSetShader(vertex_shader[1], nullptr, 0);
			//context->PSSetShader(pixel_shader[0], nullptr, 0);
			//context->PSSetShader(pixel_shader[1], nullptr, 0);
			context->PSSetShaderResources(0, 3, BATTLEMAGETexture);
			context->PSSetSamplers(0, 1, &BATTLEMAGESamplerState);
		}

		void draw_view(view_t& v)
		{
			DWORD time = GetTickCount();
			seconds = (time - thetime) / 1000.0f;

			context->OMSetRenderTargets(1, &render_target[0], depthStencilView[0]);

			const float d_green[] = { 0.5, 0.5, 0.5, 0.5 };

			context->ClearRenderTargetView(render_target[0], d_green);
			context->ClearDepthStencilView(depthStencilView[0], D3D11_CLEAR_DEPTH, 1, 0);

			view_port[0].Width = (FLOAT)1280;
			view_port[0].Height = (FLOAT)720;
			view_port[0].MinDepth = 0.01f;
			view_port[0].MaxDepth = 1.0f;
			view_port[0].TopLeftX = 0;
			view_port[0].TopLeftY = 0;

			context->RSSetViewports(1, &view_port[0]);

			/*if (GetAsyncKeyState(VK_UP))
			{
				Move = XMMatrixTranslation(0, 0, 0.01f) * Move;
			}
			if (GetAsyncKeyState(VK_DOWN))
			{
				Move = XMMatrixTranslation(0, 0, -0.01f) * Move;
			}

			/*if (GetAsyncKeyState(VK_LEFT))
			{
				XMVECTOR temp = Move.r[3];

				Move.r[3] = { 0,0,0 };

				Move *= XMMatrixRotationY(-0.01f);

				Move.r[3] = temp;
			}*/

			int meshsize = mesh.size();

			//debug_renderer::clear_lines();

			float4 indices_i;
			float4 indices_i1;
			float4 indices_i2;

			float4 weights_i;
			float4 weights_i1;
			float4 weights_i2;

			for (int i = 0; i < meshsize; i = i + 3)
			{
				

				indices_i[0] = vertposskinned[i].joints[0];
				indices_i[1] = vertposskinned[i].joints[1];
				indices_i[2] = vertposskinned[i].joints[2];
				indices_i[3] = vertposskinned[i].joints[3];

				indices_i1[0] = vertposskinned[i + 1].joints[0];
				indices_i1[1] = vertposskinned[i + 1].joints[1];
				indices_i1[2] = vertposskinned[i + 1].joints[2];
				indices_i1[3] = vertposskinned[i + 1].joints[3];

				indices_i2[0] = vertposskinned[i + 2].joints[0];
				indices_i2[1] = vertposskinned[i + 2].joints[1];
				indices_i2[2] = vertposskinned[i + 2].joints[2];
				indices_i2[3] = vertposskinned[i + 2].joints[3];

				weights_i[0] = vertposskinned[i].Weights[0];
				weights_i[1] = vertposskinned[i].Weights[1];
				weights_i[2] = vertposskinned[i].Weights[2];
				weights_i[3] = vertposskinned[i].Weights[3];
				
				weights_i1[0] = vertposskinned[i + 1].Weights[0];
				weights_i1[1] = vertposskinned[i + 1].Weights[1];
				weights_i1[2] = vertposskinned[i + 1].Weights[2];
				weights_i1[3] = vertposskinned[i + 1].Weights[3];
													  
				weights_i2[0] = vertposskinned[i + 2].Weights[0];
				weights_i2[1] = vertposskinned[i + 2].Weights[1];
				weights_i2[2] = vertposskinned[i + 2].Weights[2];
				weights_i2[3] = vertposskinned[i + 2].Weights[3];





				debug_renderer::add_line(mesh[i], mesh[i + 1], Color, UV[i], UV[i + 1], normals[i], normals[i + 1],indices_i,indices_i1,weights_i,weights_i1);

				debug_renderer::add_line(mesh[i + 2], mesh[i + 1], Color, UV[i + 2], UV[i + 1], normals[i + 2], normals[i + 1],indices_i2,indices_i1,weights_i2,weights_i1);

				debug_renderer::add_line(mesh[i + 2], mesh[i], Color, UV[i + 2], UV[i], normals[i + 2], normals[i],indices_i2,indices_i,weights_i2,weights_i);
			}

			Scale = XMMatrixScaling(1, 1, 1);
			Rotate = XMMatrixRotationY(3.14);
			WORLD2 = Scale * Rotate;
			XMMATRIX light = XMMatrixTranslation(-8.0, 6.0, 0.0);
			light = light * XMMatrixRotationY(seconds);
			XMMATRIX camerapos = XMMatrixTranspose(Camera);

			float4 LP = { light.r[3].m128_f32[0],light.r[3].m128_f32[1] ,light.r[3].m128_f32[2] ,light.r[3].m128_f32[3] };
			float4 CP = { camerapos.r[3].m128_f32[0], camerapos.r[3].m128_f32[1], camerapos.r[3].m128_f32[2], camerapos.r[3].m128_f32[3], };
			XMMATRIX bindposee;
			XMMATRIX two;

			for (int i = 0; i < 28; i++)
			{


				float bindpose[16] = { joints[i].global_xform[0]
									  ,joints[i].global_xform[1]
									  ,joints[i].global_xform[2]
									  ,joints[i].global_xform[3]
									  ,joints[i].global_xform[4]
									  ,joints[i].global_xform[5]
									  ,joints[i].global_xform[6]
									  ,joints[i].global_xform[7]
									  ,joints[i].global_xform[8]
									  ,joints[i].global_xform[9]
									  ,joints[i].global_xform[10]
									  ,joints[i].global_xform[11]
									  ,joints[i].global_xform[12]
									  ,joints[i].global_xform[13]
									  ,joints[i].global_xform[14]
									  ,joints[i].global_xform[15]
				};

				float twoo[16] = { animation.keyframes[1].joints[i].global_xform[0]
									  ,animation.keyframes[counter].joints[i].global_xform[1]
									  ,animation.keyframes[counter].joints[i].global_xform[2]
									  ,animation.keyframes[counter].joints[i].global_xform[3]
									  ,animation.keyframes[counter].joints[i].global_xform[4]
									  ,animation.keyframes[counter].joints[i].global_xform[5]
									  ,animation.keyframes[counter].joints[i].global_xform[6]
									  ,animation.keyframes[counter].joints[i].global_xform[7]
									  ,animation.keyframes[counter].joints[i].global_xform[8]
									  ,animation.keyframes[counter].joints[i].global_xform[9]
									  ,animation.keyframes[counter].joints[i].global_xform[10]
									  ,animation.keyframes[counter].joints[i].global_xform[11]
									  ,animation.keyframes[counter].joints[i].global_xform[12]
									  ,animation.keyframes[counter].joints[i].global_xform[13]
									  ,animation.keyframes[counter].joints[i].global_xform[14]
									  ,animation.keyframes[counter].joints[i].global_xform[15]
				};

				

				bindposee.r[0] = XMVectorSet(bindpose[0], bindpose[1], bindpose[2], bindpose[3]);
				bindposee.r[1] = XMVectorSet(bindpose[4], bindpose[5], bindpose[6], bindpose[7]);
				bindposee.r[2] = XMVectorSet(bindpose[8], bindpose[9], bindpose[10], bindpose[11]);
				bindposee.r[3] = XMVectorSet(bindpose[12], bindpose[13], bindpose[14], bindpose[15]);

				two.r[0] = XMVectorSet(twoo[0], twoo[1], twoo[2], twoo[3]);
				two.r[1] = XMVectorSet(twoo[4], twoo[5], twoo[6], twoo[7]);
				two.r[2] = XMVectorSet(twoo[8], twoo[9], twoo[10], twoo[11]);
				two.r[3] = XMVectorSet(twoo[12], twoo[13], twoo[14], twoo[15]);

				bindposee = XMMatrixInverse(nullptr, bindposee);

				bindposee *= two;

				bindposee = XMMatrixTranspose(bindposee);

				CB.matrices[i] = bindposee;
			}

			
			CB.mWorld = XMMatrixTranspose(WORLD2);
			CB.mView = camerapos;
			CB.mProjection = XMMatrixTranspose(v.Projection);
			CB.CameraPosition = CP;
			CB.LightPosition = LP;

			context->IASetInputLayout(input_layout[0]);
			context->UpdateSubresource(constant_buffer[0], 0, nullptr, &CB, 0, 0);
			context->UpdateSubresource(vertex_buffer[0], 0, nullptr, debug_renderer::get_line_verts(), 0, 0);
			context->IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST);
			context->PSSetShader(pixel_shader[0], nullptr, 0);
			context->VSSetShader(vertex_shader[0], nullptr, 0);
			context->VSSetConstantBuffers(0, 1, constant_buffer);
			context->PSSetConstantBuffers(0, 1, constant_buffer);
			

			context->Draw(debug_renderer::get_line_vert_count(), 0);

			debug_renderer::clear_lines();

			UINT Stride = sizeof(colored_vertex);
			UINT Offset = 0;
			context->IASetVertexBuffers(0, 1, &vertex_buffer[0], &Stride, &Offset);

			if (GetAsyncKeyState('W'))
			{
				Camera = XMMatrixTranslation(0, 0, -0.1f) * Camera;
			}
			if (GetAsyncKeyState('S'))
			{
				Camera = XMMatrixTranslation(0, 0, 0.1f) * Camera;
			}
			if (GetAsyncKeyState('A'))
			{
				Camera = XMMatrixTranslation(0.1f, 0, 0) * Camera;
			}
			if (GetAsyncKeyState('D'))
			{
				Camera = XMMatrixTranslation(-0.1f, 0, 0) * Camera;
			}

			/*for (int i = 0; i < 28; i++)
			{


				if (joints[i].parent_index == -1)
				{
					continue;
				}

				float3 point1 = { joints[i].global_xform[12],joints[i].global_xform[13],joints[i].global_xform[14] };
				float3 point2 = { joints[joints[i].parent_index].global_xform[12],joints[joints[i].parent_index].global_xform[13], joints[joints[i].parent_index].global_xform[14], };

				debug_renderer::add_line(point1, point2, Color, ZEROS, ZEROS, zeronorm, zeronorm);
			}*/

			XMVECTOR UP = { 0.0f,1.0f,0.0f };

			/*for (int i = 0; i < 28; i++)
			{
				float3 point1 = { joints[i].global_xform[12],joints[i].global_xform[13],joints[i].global_xform[14] };

				XMVECTOR Z = { joints[i].global_xform[8],joints[i].global_xform[9], joints[i].global_xform[10] };
				Z = XMVector3Normalize(Z);
				Z = XMVectorScale(Z, 0.2);

				XMVECTOR X = XMVector3Cross(UP, Z);
				X = XMVector3Normalize(X);
				X = XMVectorScale(X, 0.2);

				XMVECTOR Y = XMVector3Cross(Z, X);
				Y = XMVector3Normalize(Y);
				Y = XMVectorScale(Y, 0.2);

				float3 pointx = { X.m128_f32[0] + point1.x,X.m128_f32[1] + point1.y,X.m128_f32[2] + point1.z };
				float3 pointy = { Y.m128_f32[0] + point1.x,Y.m128_f32[1] + point1.y,Y.m128_f32[2] + point1.z };
				float3 pointz = { Z.m128_f32[0] + point1.x,Z.m128_f32[1] + point1.y,Z.m128_f32[2] + point1.z };

				debug_renderer::add_line(point1, pointx, Color1, ZEROS, ZEROS, zeronorm, zeronorm);
				debug_renderer::add_line(point1, pointy, Color2, ZEROS, ZEROS, zeronorm, zeronorm);
				debug_renderer::add_line(point1, pointz, Color3, ZEROS, ZEROS, zeronorm, zeronorm);
			}*/


			float3 point1;
			float3 point2;
			float3 pointx;
			float3 pointy;
			float3 pointz;

			if (0x80 != 0)
			{
				counter++;
			}
				

				if (counter >= 17)
				{
					counter = 0;
				}

				if (counter == 0)
				{
					counter = 1;
				}
			

			for (int i = 0; i < 28; i++)
			{
				if (animation.keyframes[counter].joints[i].parent_index == -1)
				{
					continue;
				}

				point1 = { animation.keyframes[counter].joints[i].global_xform[12],animation.keyframes[counter].joints[i].global_xform[13],animation.keyframes[counter].joints[i].global_xform[14] };

				point2 = { animation.keyframes[counter].joints[animation.keyframes[counter].joints[i].parent_index].global_xform[12], animation.keyframes[counter].joints[animation.keyframes[counter].joints[i].parent_index].global_xform[13], animation.keyframes[counter].joints[animation.keyframes[counter].joints[i].parent_index].global_xform[14] };

				debug_renderer::add_line(point1, point2, Color, ZEROS, ZEROS, zeronorm, zeronorm,zerofour,zerofour,zerofour,zerofour);
			}

			for (int i = 0; i < 28; i++)
			{

				point1 = { animation.keyframes[counter].joints[i].global_xform[12],animation.keyframes[counter].joints[i].global_xform[13],animation.keyframes[counter].joints[i].global_xform[14] };

				XMVECTOR Z = { animation.keyframes[counter].joints[i].global_xform[8],animation.keyframes[counter].joints[i].global_xform[9], animation.keyframes[counter].joints[i].global_xform[10] };
				Z = XMVector3Normalize(Z);
				Z = XMVectorScale(Z, 0.2);

				XMVECTOR X = XMVector3Cross(UP, Z);
				X = XMVector3Normalize(X);
				X = XMVectorScale(X, 0.2);

				XMVECTOR Y = XMVector3Cross(Z, X);
				Y = XMVector3Normalize(Y);
				Y = XMVectorScale(Y, 0.2);

				pointx = { X.m128_f32[0] + point1.x,X.m128_f32[1] + point1.y,X.m128_f32[2] + point1.z };
				pointy = { Y.m128_f32[0] + point1.x,Y.m128_f32[1] + point1.y,Y.m128_f32[2] + point1.z };
				pointz = { Z.m128_f32[0] + point1.x,Z.m128_f32[1] + point1.y,Z.m128_f32[2] + point1.z };

				debug_renderer::add_line(point1, pointx, Color1, ZEROS, ZEROS, zeronorm, zeronorm,zerofour,zerofour,zerofour,zerofour);
				debug_renderer::add_line(point1, pointy, Color2, ZEROS, ZEROS, zeronorm, zeronorm,zerofour,zerofour,zerofour,zerofour);
				debug_renderer::add_line(point1, pointz, Color3, ZEROS, ZEROS, zeronorm, zeronorm,zerofour,zerofour,zerofour,zerofour);
			}

			Scale = XMMatrixScaling(1, 1, 1);
			Rotate = XMMatrixRotationY(3.14);
			Translate = XMMatrixTranslation(5.0f, 0.0f, 0.0f);
			WORLD2 = Rotate * Scale * Translate;

			CB.mWorld = XMMatrixTranspose(WORLD2);
			CB.mView = camerapos;
			CB.mProjection = XMMatrixTranspose(v.Projection);
			

			context->IASetInputLayout(input_layout[1]);
			context->UpdateSubresource(constant_buffer[0], 0, nullptr, &CB, 0, 0);
			context->UpdateSubresource(vertex_buffer[0], 0, nullptr, debug_renderer::get_line_verts(), 0, 0);
			context->IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_LINELIST);
			context->VSSetShader(vertex_shader[1], nullptr, 0);
			context->PSSetShader(pixel_shader[1], nullptr, 0);
			
			context->VSSetConstantBuffers(0, 1, constant_buffer);
			context->PSSetConstantBuffers(0, 1, constant_buffer);
			
			context->Draw(debug_renderer::get_line_vert_count(), 0);

			//debug_renderer::clear_lines();
			swapchain->Present(0, 0);
		}

		~impl()
		{
			SAFE_RELEASE(render_target[VIEW_RENDER_TARGET::DEFAULT]);
			SAFE_RELEASE(depthStencilView[VIEW_DEPTH_STENCIL::DEFAULT]);
			SAFE_RELEASE(depthStencilState[0]);
			SAFE_RELEASE(vertex_buffer[VERTEX_BUFFER::COLORED_VERTEX]);
			SAFE_RELEASE(index_buffer[INDEX_BUFFER::COUNT]);
			SAFE_RELEASE(input_layout[INPUT_LAYOUT::COUNT]);
			SAFE_RELEASE(vertex_shader[VERTEX_SHADER::COUNT]);
			SAFE_RELEASE(constant_buffer[CONSTANT_BUFFER::MVP]);
			SAFE_RELEASE(pixel_shader[PIXEL_SHADER::COLORED_VERTEX]);
			SAFE_RELEASE(BATTLEMAGETexture[0]);
			SAFE_RELEASE(BATTLEMAGETexture[1]);
			SAFE_RELEASE(BATTLEMAGETexture[2]);
			SAFE_RELEASE(BATTLEMAGESamplerState);
			SAFE_RELEASE(TempResource);
			SAFE_RELEASE(rasterState[0]);
			SAFE_RELEASE(device);
			SAFE_RELEASE(context);
			SAFE_RELEASE(swapchain);
		}
	};
}