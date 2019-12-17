// SOURCE:  	unity
// TYPE:		surface
// FUNCTION:	Custom data computed per-vertex (rainbow face!)
//				Using a vertex modifier function it is also possible 
// 				to compute custom data in a vertex shader, which then 
// 				will be passed to the surface shader function 
// 				per-pixel. The same compilation directive 
// 				vertex:functionName is used, but the function should 
//				take two parameters: inout appdata_full andout Input. 
//				You can fill in any Input member that is not a 
//				built-in value there.
//				Note: Custom Input members used in this way must not 
//				have names beginning with ‘uv’ or they won’t work 
//				properly.
//				The example below defines a custom float3 customColor 
//				member, which is computed in a vertex function.
Shader "!_custom/-unity/CustomVertexData"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white"{}
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		struct Input
		{
			float2 uv_MainTex;
			float3 customColor;
		};

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.customColor = abs(v.normal);
		}

		sampler2D _MainTex;

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Albedo *= IN.customColor;
		}
		ENDCG
	}
	Fallback "Diffuse"
}