Shader "Custom/ToonRamp"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _RampTex ("Ramp Texture", 2D) = "white" {}
        _RotationSpeed("Rotation Speed", Float) = 2.0
        _RotationDegrees("Rotation Degrees", Float) = 0.0
    }
        SubShader
    {
        Tags {"RenderType" = "Opaque"}
        LOD 200

        CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members texcoord)
        #pragma exclude_renderers d3d11
        #pragma surface surf ToonRamp vertex:vert

        sampler2D _MainTex;
        sampler2D _RampTex;
        float4 _MyData;

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
            float4 _myData;
        };

        struct appData
        {
            float4 vertex : POSITION;
            float3 normal: NORMAL;
        };
        
        struct v2f {
            //float3 texcoord;
            float4 vertex : SV_POSITION;
            float4 myData : TEXCOORD0;
        };

        float _RotationSpeed;
        v2f vert(inout appData v) {
            /*v.texcoord.xy -= 0.5;
            float s = sin(_RotationSpeed * _Time);
            float c = cos(_RotationSpeed * _Time);
            float2x2 rotationMatrix = float2x2(c, -s, s, c);
            rotationMatrix *= 0.5;
            rotationMatrix += 0.5;
            rotationMatrix = rotationMatrix * 2 - 1;
            v.texcoord.xy = mul(v.texcoord.xy, rotationMatrix);
            v.texcoord.xy += 0.5;

            v.texcoord.x = 0.5;
            v.texcoord.y = 0.5;*/


            v2f o;

            //o.vertex = UnityObjectClipToPos(v.vertex);
            o.myData = float4(1, 0, 0, 1);
            return o;
        }
    
        void surf (Input IN, inout SurfaceOutput o)
        {
            //_MyData = IN._myData;
            //half4 c = tex2D(_MainTex, IN.uv_MainTex);
            //o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            //o.Albedo = c.rgb;
            //o.Alpha = c.a;

            //o.Albedo = _MyData;
            o.Albedo = float4(0.05, 1.0, 0.0, 1.0);

        }
        ENDCG
    }
    FallBack "Diffuse"
}
