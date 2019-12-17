// SOURCE:  	Unity5 Shader Book
// TYPE:		surface
// FUNCTION:	Normals!
Shader "!_custom/ebook-unity5shaders/c2/4/normals"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		_MainTex("Albedo (RGB)", 2D) = "white"{}
		_BumpTex("Normal Map", 2D) = "bump"{}
		_BumpIntensity("Normal Intensity", Range(0, 1)) = 1
		_Glossiness("Smoothness", Range(0, 1)) = 0.5
		_Metallic("Metallic", Range(0, 1)) = 0.0
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;

		sampler2D _BumpTex;
		fixed _BumpIntensity;

		struct Input
		{
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;

			fixed4 n = tex2D(_BumpTex, IN.uv_MainTex) * _BumpIntensity;
			o.Normal = UnpackNormal(n).rgb;

			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	fallback "Diffuse"
}