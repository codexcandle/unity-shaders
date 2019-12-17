// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// SOURCE:  	unity
// TYPE:		surface
// FUNCTION:	Fog via Final Color. (see also "FogLinear" shader).
//				Common use case for final color modifier would be 
// 				implementing completely custom Fog. Fog needs to 
//				affect the final computed pixel shader color, which 
//				is exactly what the finalcolor modifier does.
//				Here’s a shader that applies fog tint based on 
//				distance from screen center. This combines both the 
//				vertex modifier with custom vertex data (fog) and 
//				final color modifier. When used in forward rendering 
//				additive pass, Fog needs to fade to black color, and 
//				this example handles that as well with a check for 
//				UNITY_PASS_FORWARDADD.
Shader "!_custom/-unity/FogViaFinalColorLinear"
{
    Properties
    {
		_MainTex("Texture", 2D) = "white"{}
     	_FogColor("Fog Color", Color) = (0.3, 0.4, 0.7, 1.0)
    }
    SubShader
    {
      Tags
      {
      	"RenderType" = "Opaque"
      }
      CGPROGRAM
      #pragma surface surf Lambert finalcolor:mycolor vertex:myvert

      struct Input
      {
          float2 uv_MainTex;
          half fog;
      };

      void myvert(inout appdata_full v, out Input data)
      {
          UNITY_INITIALIZE_OUTPUT(Input,data);
          float4 hpos = UnityObjectToClipPos(v.vertex);
          data.fog = min(1, dot (hpos.xy, hpos.xy) * 0.1);
      }

      fixed4 _FogColor;
      void mycolor(Input IN, SurfaceOutput o, inout fixed4 color)
      {
          fixed3 fogColor = _FogColor.rgb;
          #ifdef UNITY_PASS_FORWARDADD
          fogColor = 0;
          #endif
          color.rgb = lerp(color.rgb, fogColor, IN.fog);
      }

      sampler2D _MainTex;
      void surf(Input IN, inout SurfaceOutput o)
      {
           o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
      }
      ENDCG
	} 
	Fallback "Diffuse"
}