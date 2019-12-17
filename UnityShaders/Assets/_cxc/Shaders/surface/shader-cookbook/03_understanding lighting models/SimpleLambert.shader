// SOURCE:      Unity5 Shader Book
// TYPE:        surface
// FUNCTION:    simple lambert.
Shader "!_custom/ebook-unity5shaders/c3/1/simple-lambert"
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
        #pragma surface surf SimpleLambert

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }

        half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            half NdotL = dot(s.Normal, lightDir);

            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten * 1);
            c.a = s.Alpha;

            return c;
        }
        ENDCG
    }
    Fallback "Diffuse"
}