using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotator:MonoBehaviour
{
	[Range(-10, 10)]
	public int speed = -3;

	void Update()
	{
		transform.Rotate(0f, (float)(speed * 10) * Time.deltaTime, 0f);
	}
}