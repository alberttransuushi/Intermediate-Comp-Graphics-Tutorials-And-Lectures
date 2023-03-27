using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using Unity.Mathematics;

public class PerlinNoise : MonoBehaviour
{
    public Texture2D noiseTexture;
    public Material material;
    public int width = 512;
    public int height = 512;
    public float scale = 1.0f;
    private int _nameCounter = 0;

    private void SaveTexturesToJPG(Texture2D textureToSave)
    {
        byte[] bytes = textureToSave.EncodeToJPG();
        string filepath = "./Assets/JPG_" + _nameCounter + ".jpg";
        _nameCounter++;
        File.WriteAllBytes(filepath, bytes);
    }

    [ContextMenu("Generate Texture")]
    private void GenerateTexture()
    {
        noiseTexture = new Texture2D(width, height, TextureFormat.RGBA32, true);
        for (int i = 0; i < width; i++)
        {
            for (int j = 0; j < height; j++)
            {
                float xOrg = 0;
                float yOrg = 0;

                float xCoord = xOrg + i / (float)width * scale;
                float yCoord = yOrg + j / (float)height * scale;
                float sample = Mathf.PerlinNoise(xCoord, yCoord);
                noiseTexture.SetPixel(i, j, new Color(sample, sample, sample));
            }
        }

        noiseTexture.Apply();

        SaveTexturesToJPG(noiseTexture);
    }


}
