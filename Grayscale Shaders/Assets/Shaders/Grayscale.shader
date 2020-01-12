// Grayscale shader for 3D
// Resources: https://answers.unity.com/questions/31823/how-do-i-make-a-texture-turn-greyscael.html 
Shader "Custom/Grayscale" {

 Properties {
        _MainTex ("Base (RGB) Diffuse Texture", 2D) = "white" {}
        _EffectAmount ("Effect Amount", Range (0, 1)) = 1.0      
        _BumpTex ("Normal Map", 2D) = "bump" {}
    }

    SubShader {    
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        uniform float _EffectAmount;         
        sampler2D _BumpTex;    
    
        struct Input {
            float2 uv_MainTex;
            float2 uv_BumpTex;
        };
    
        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);            
            //o.Albedo = (c.r + c.g + c.b)/3;
            o.Albedo = lerp(c.rgb, dot(c.rgb, float3(0.3, 0.59, 0.11)), _EffectAmount);
            o.Alpha = c.a;         
            o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
        }
     
        ENDCG
     } 
     FallBack "Diffuse"
}