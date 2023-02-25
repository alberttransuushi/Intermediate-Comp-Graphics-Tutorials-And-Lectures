Shader "Custom/DisplacementTest"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _RotationSpeed("Rotation Speed", Float) = 2.0
        _RotationDegrees("Rotation Degrees", Float) = 0.0
        _DisplacementMap("DisMapInYouMouth", 2D) = "black" {}
        _DisplacmentStrength("DisStronkness", Range(0,100)) = 0.5
    }
        SubShader
        {
            Pass
            {

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #include "UnityCG.cginc"


            fixed4 _Color;
            sampler2D _MainTex;
            sampler2D _DisplacementMap;
            half _DisplacmentStrength;
            float _RotationSpeed;
            float4 _MainTex_ST;
            float4 _DisplacmentMap_ST;

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f {
                float2 uv :TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata v) {

                v2f o;

                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                o.uv.xy -= 0.5;
                float s = sin(_RotationSpeed * _Time) * 0.4;
                float c = cos(_RotationSpeed * _Time);
                float2x2 rotationMatrix = float2x2(c, -s, s, c);
                rotationMatrix *= 0.5;
                rotationMatrix += 0.5;
                rotationMatrix = rotationMatrix * 2 - 1;
                o.uv.xy = mul(v.vertex.xy, rotationMatrix);
                v.uv.xy = mul(v.vertex.xy, rotationMatrix);
                o.uv.xy += 0.5;

                float displacement = tex2Dlod(_DisplacementMap, float4(o.uv, 0, 0)).r;
                //float displacement = 0;
                float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
                temp.xyz += displacement * v.normal * _DisplacmentStrength;

                //temp.xyz += displacement * 1.0 * 1.0;

                o.vertex = UnityObjectToClipPos(temp);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target{

                fixed4 col = tex2D(_MainTex, i.uv) * _Color;
                return col;
            }
            ENDCG

            }

        }
           
}