using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LsdShaderTrigger : MonoBehaviour
{
  float timer;
  [SerializeField] float scaleUpTime = 1;
  [SerializeField] float upTime = 1;
  [SerializeField] float scaleDownTime = 1;
  bool triggered;
  bool scaleUp;
  bool isUp;
  bool scaleDown;
  public Material material;
  [SerializeField]  bool cycle;
  private void Update() {
    if ((Input.GetKeyDown(KeyCode.E) || cycle) && !triggered) {
      triggered = true;
      scaleUp = true;
      timer = 0;
    }
    if (triggered) {
      timer += Time.deltaTime;
    } else {
      material.SetFloat("_Contribution", 0f);
    }
    if (timer > scaleUpTime && scaleUp && triggered) {
      timer = 0;
      scaleUp = false;
      isUp = true;
    }
    if (timer > upTime && isUp && triggered) {
      timer = 0;
      isUp = false;
      scaleDown = true;
    }
    if (timer > scaleDownTime && scaleDown && triggered) {
      timer = 0;
      scaleDown = false;
      triggered = false;
    }
    if (scaleUp) {
      material.SetFloat("_Contribution", ScalingEquation(scaleUpTime));
    }
    if (isUp) {
      material.SetFloat("_Contribution", 1f);
    }
    if (scaleDown) {
      material.SetFloat("_Contribution", 1 - ScalingEquation(scaleDownTime));
    }
  }
    float ScalingEquation(float scaleTime)
    {
        float num = Mathf.Pow((timer/scaleTime) - 1, 3) + 1;
        return num;
    }
}
