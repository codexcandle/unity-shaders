﻿// SOURCE:  	unity
// TYPE:		surface
// FUNCTION:	Fog Linear. (see also "FogViaFinalColor" shader).
Shader "!_custom/-unity/FogLinear"
{
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white"{}
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert finalcolor:mycolor vertex:myvert

		sampler2D _MainTex;
		uniform half4 unity_FogColorCustom;
		uniform half4 unity_FogStart;
		uniform half4 unity_FogEnd;

		struct Input
		{
			float2 uv_MainTex;
			half fog;
		};

		void myvert(inout appdata_full v, out Input data)
		{
			UNITY_INITIALIZE_OUTPUT(Input, data);
			float pos = length(mul(UNITY_MATRIX_MV, v.vertex).xyz);
			float diff = unity_FogEnd.x - unity_FogStart.x;
			float invDiff = 1.0f / diff;
			data.fog = clamp((unity_FogEnd.x - pos) * invDiff, 0.0, 1.0);
		}

		void mycolor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			fixed3 fogColor = unity_FogColorCustom.rgb;
			#ifdef UNITY_PASS_FORWARDD
			fogColor = 0;
			#endif
			color.rgb = lerp(fogColor, color.rgb, IN.fog);
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}