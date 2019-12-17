// SOURCE:  	unity
// TYPE:		fragment
// FUNCTION:	Cubemapped reflection using built-in worldRefl input. 
// 				It’s actually very similar to the built-in 
//				Reflective/Diffuse shader.
// 				NOTE:  Since below assigns the reflection color as 
//				Emission, we get a very shiny object!
Shader "!_custom/-unity/CubemapReflection"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white"{}
		_Cube("Cubemap", CUBE) = ""{}
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}

		CGPROGRAM
		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
			float3 worldRefl;
		};

		sampler2D _MainTex;
		samplerCUBE _Cube;

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * 0.5;
			o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
		}
		ENDCG
	}
	Fallback "Diffuse"
}