// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// SOURCE: https://en.wikibooks.org/wiki/Cg_Programming/Unity/RGB_Cube
// FUNCTION: place on a cube; RGB cube where the color of each point on the surface is determined by its coordinates; i.e., a point at position ( x , y , z ) {\displaystyle (x,y,z)} {\displaystyle (x,y,z)} has the color ( red , green , blue ) = ( x , y , z ).
Shader "RGB color cube" { 
   SubShader { 
      Pass { 
         CGPROGRAM 
 
         #pragma vertex vert // vert function is the vertex shader 
         #pragma fragment frag // frag function is the fragment shader
 
         // for multiple vertex output parameters an output structure 
         // is defined:
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 col : TEXCOORD0;
         };
 
         vertexOutput vert(float4 vertexPos : POSITION) 
            // vertex shader 
         {
            vertexOutput output; // we don't need to type 'struct' here
 
            output.pos =  UnityObjectToClipPos(vertexPos);
            output.col = vertexPos + float4(0.5, 0.5, 0.5, 0.0);
               // Here the vertex shader writes output data
               // to the output structure. We add 0.5 to the 
               // x, y, and z coordinates, because the 
               // coordinates of the cube are between -0.5 and
               // 0.5 but we need them between 0.0 and 1.0. 
            return output;
         }
 
         float4 frag(vertexOutput input) : COLOR // fragment shader
         {
            return input.col; 
               // Here the fragment shader returns the "col" input 
               // parameter with semantic TEXCOORD0 as nameless
               // output parameter with semantic COLOR.
         }
 
         ENDCG  
      }
   }
}