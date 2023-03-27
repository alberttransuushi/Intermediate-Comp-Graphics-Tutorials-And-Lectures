using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    public float x;
    public float y;
    public float z;

    public float spin = 0.5f;
    // Update is called once per frame
    void Update()
    {
        Vector3 rotation = new Vector3(x, y, z);
        transform.Rotate(rotation * Time.deltaTime * spin);
    }
}
