using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class SwitchMat : MonoBehaviour
{
    public Material[] materials;
    private MeshRenderer meshRender;
    // Start is called before the first frame update
    void Start()
    {
        meshRender = GetComponent<MeshRenderer>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            meshRender.material = materials[0];
            Debug.Log("Yeehaw");
        }
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            meshRender.material = materials[1];
        }
        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            meshRender.material = materials[2];
        }
        if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            meshRender.material = materials[3];
        }
        if (Input.GetKeyDown(KeyCode.Alpha5))
        {
            meshRender.material = materials[4];
        }
        if (Input.GetKeyDown(KeyCode.Alpha6))
        {
            meshRender.material = materials[5];
        }
    }
}
