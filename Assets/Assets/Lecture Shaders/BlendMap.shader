Shader "Custom/BlendMap"

    {
        Properties{
            _TileTextureR("TileTexture R (RGB)", 2D) = "w$$anonymous$$te" {}
            _TileTextureG("TileTexture G (RGB)", 2D) = "w$$anonymous$$te" {}
            _TileTextureB("TileTexture B (RGB)", 2D) = "w$$anonymous$$te" {}
            _TileTextureA("TileTexture A (RGB)", 2D) = "w$$anonymous$$te" {}
            _RedColor("Red", Color) = (1,1,1,1)
            _BlueColor("Blue", Color) = (1,1,1,1)
            _GreenColor("Green", Color) = (1,1,1,1)
            _AlphaColor("Alpha", Color) = (1,1,1,1)
            _BlendTex("Blend (RGB)", 2D) = "red" {}
        }
        
            SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 200

                CGPROGRAM
                // Physically based Standard lighting model, and enable shadows on all light types
                #pragma surface surf Standard fullforwardshadows

                // Use shader model 3.0 target, to get nicer looking lighting
                #pragma target 3.0

                sampler2D _TileTextureR;
                sampler2D _TileTextureG;
                sampler2D _TileTextureB;
                sampler2D _TileTextureA;
                sampler2D _BlendTex;
                fixed4 _RedColor;
                fixed4 _BlueColor;
                fixed4 _GreenColor;
                fixed4 _AlphaColor;

                struct Input {
                    float2 uv_TileTextureR;
                    float2 uv_TileTextureA;
                    float2 uv_BlendTex;
                };



                void surf(Input IN, inout SurfaceOutputStandard o)
                {
                    fixed4 blend = tex2D(_BlendTex, IN.uv_BlendTex);

                    //blendmaps with textures
                    fixed4 c =
                    tex2D(_TileTextureR, IN.uv_TileTextureR) * blend.r +
                    tex2D(_TileTextureG, IN.uv_TileTextureR) * blend.g +
                    tex2D(_TileTextureB, IN.uv_TileTextureR) * blend.b +
                    tex2D(_TileTextureA, IN.uv_TileTextureA) * abs(1 - blend.a);

                    //blendmaps with color
                    //fixed4 c = _RedColor * blend.r + _BlueColor * blend.b + _GreenColor * blend.g + _AlphaColor * abs(1 - blend.a);
                    o.Albedo = c.rgb;
                }
        ENDCG
    }
        FallBack "Diffuse"
}