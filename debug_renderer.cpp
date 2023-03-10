#include "debug_renderer.h"
#include <array>

// Anonymous namespace
namespace
{
	// Declarations in an anonymous namespace are global BUT only have internal linkage.
	// In other words, these variables are global but are only visible in this source file.

	// Maximum number of debug lines at one time (i.e: Capacity)
	constexpr size_t MAX_LINE_VERTS = 400960; 

	// CPU-side buffer of debug-line verts
	// Copied to the GPU and reset every frame.
	size_t line_vert_count = 0;
	std::array< end::colored_vertex, MAX_LINE_VERTS> line_verts;
}

namespace end
{
	namespace debug_renderer
	{
		void add_line(float3 point_a, float3 point_b, float4 color_a,float2 UVA,float2 UVB,float3 norm1,float3 norm2,float4 indices1, float4 indices2, float4 weights1, float4 weights2)
		{
			// Add points to debug_verts, increments debug_vert_count

			line_verts[line_vert_count].pos = point_a;
			line_verts[line_vert_count].color = color_a;
			line_verts[line_vert_count].UV = UVA;
			line_verts[line_vert_count].Norm = norm1;
			line_verts[line_vert_count].Indices = indices1;
			line_verts[line_vert_count].Weights = weights1;

			
			
			line_vert_count++;
			line_verts[line_vert_count].pos = point_b;
			line_verts[line_vert_count].color = color_a;
			line_verts[line_vert_count].UV = UVB;
			line_verts[line_vert_count].Norm = norm2;
			line_verts[line_vert_count].Indices = indices2;
			line_verts[line_vert_count].Weights = weights2;
			
			line_vert_count++;

		}

		void clear_lines()
		{	
			line_vert_count = 0;
		}

		const colored_vertex* get_line_verts()
		{ 
			// Does just what it says in the name

			return line_verts.data();
		}

		size_t get_line_vert_count() 
		{ 
			// Does just what it says in the name
			return line_vert_count;
		}

		size_t get_line_vert_capacity()
		{
			// Does just what it says in the name
			return MAX_LINE_VERTS;
		}
	}
}