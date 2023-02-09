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
                sampler2D _RampTex;
                float _GeoRes;


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

                struct v2f
                {
                    float4 position : SV_POSITION;
                    float3 texcoord : TEXCOORD;
                };

                struct Input
                {
                    float2 uv_MainTex;
                    float2 uv_RampTex;
                };

                v2f vert(appdata_base v)
                {
                    v2f o;

                    float4 wp = mul(UNITY_MATRIX_MV, v.vertex);
                    wp.xyz = floor(wp.xyz * _GeoRes) / _GeoRes;

                    float4 sp = mul(UNITY_MATRIX_P, wp);
                    o.position = sp;

                    float2 uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.texcoord = float3(uv * sp.w, sp.w);

                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    float2 uv = i.texcoord.xy / i.texcoord.z;
                    return tex2D(_MainTex, uv) * _Color * 2;
                }

                void surf(Input IN, inout SurfaceOutput o)
                {
                    half4 c = tex2D(_MainTex, IN.uv_MainTex);
                    //o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
                    o.Albedo = c.rgb;
                    o.Alpha = c.a;

                }

            
            ENDCG
        }
            FallBack "Diffuse"
}
