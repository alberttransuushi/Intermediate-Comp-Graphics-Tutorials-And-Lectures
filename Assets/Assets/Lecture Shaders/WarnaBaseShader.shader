// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'



Shader "Custom/WarnaBaseShader"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _RampTex("Ramp Texture", 2D) = "white" {}
        _GeoRes("Geometric Resolution", Float) = 10.0
    }
        SubShader
        {
            
                Tags {"RenderType" = "Opaque"}
                LOD 200

                CGPROGRAM

                #include "UnityCG.cginc"

                #pragma surface surf ToonRamp vertex:vert

                sampler2D _MainTex;
                sampler2D _Tex;
                float4 _MainTex_ST;
                sampler2D _RampTex;
                float _GeoRes;
                float _RimPower;


                float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
                {
                    float diff = dot(s.Normal, lightDir);
                    float h = diff * 0.5 + 0.5;
                    float2 rh = h;
                    float3 ramp = tex2D(_RampTex, rh).rgb;

                    float4 t;
                    t.rgb = s.Albedo * _LightColor0.rgb * (ramp);
                    t.a = s.Alpha;
                    return t;
                }


                struct Input
                {
                    float2 uv_MainTex;
                    float2 uv_RampTex;
                    float2 uv_MainTex_ST;
                    float2 uv_Tex;
                    float3 viewDir;
                    float3 rez;
                };


                void vert(inout appdata_full v, out Input o)
                {
                    UNITY_INITIALIZE_OUTPUT(Input, o);
                  

                    float4 wp = mul(UNITY_MATRIX_MV, v.vertex);
                    wp.xyz = floor(wp.xyz * _GeoRes) / _GeoRes;
                    
                    float4 sp = mul(UNITY_MATRIX_P, wp);
                    (v.vertex).xyzw = sp;

                    float2 uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.rez = float3(uv * sp.w, sp.w);
    
                }


                void surf(Input IN, inout SurfaceOutput o)
                {
                    float2 uv = IN.rez.xy / IN.rez.z;
                    half4 c = tex2D(_MainTex, uv);
                    o.Albedo = c.rgb;
                    o.Alpha = c.a;

                }

            
            ENDCG
        }
            FallBack "Diffuse"
}
