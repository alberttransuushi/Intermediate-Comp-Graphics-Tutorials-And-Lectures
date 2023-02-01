using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class RealTimeReflectionProbe : MonoBehaviour
{
    [MenuItem("ReflectionProbe/CreateRealtimeProbe")]
    public static void RealtimeProbe()
    {
        // Add a GameObject with a ReflectionProbe component
        GameObject probeGameObject = new GameObject("Realtime Reflection Probe");
        ReflectionProbe probeComponent = probeGameObject.AddComponent<ReflectionProbe>();

        // The probe will contribute to reflections inside a box of size 10x10x10 centered on the position of the probe
        probeComponent.size = new Vector3(10, 10, 10);

        // Set the type to realtime and refresh the probe every frame
        probeComponent.mode = UnityEngine.Rendering.ReflectionProbeMode.Realtime;
        probeComponent.refreshMode = UnityEngine.Rendering.ReflectionProbeRefreshMode.EveryFrame;
    }
}
