// SOURCE:  	Unity5 Shaders Cookbook
// TYPE:		surface
// FUNCTION:	Simple Diffuse shader.
// NOTE:  		For Non-photorealistic effect, use "Lambert" & "SurfaceOutput".
Shader "!_custom/ebook-unity5shaders/c2/1/diffuse"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags
		{
			"RenderType"="Opaque"
		}
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		// #pragma surface surf Lambert fullforwardshadows
		#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o)
 		// void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}