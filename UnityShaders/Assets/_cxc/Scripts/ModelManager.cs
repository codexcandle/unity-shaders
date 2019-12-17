using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.UI;

public class ModelManager:MonoBehaviour
{
    #region VARS (private)
    [SerializeField] private AnimShaderSet[] animShaderSets;
    [SerializeField] private GameObject[] models;

    [SerializeField] private Text shaderNameText;
    [SerializeField] private Text shaderCountText;

    private PlayableGraph pGraph;
    private int modelIndex;
    private int listIndex;
    private int listCount;
    #endregion

    #region METHODS (public)
    public void LoadNext()
    {
        LoadShaderDemo(GetNextNavIndex(listIndex + 1));
    }

    public void LoadPrevious()
    {
        LoadShaderDemo(GetNextNavIndex(listIndex - 1));
    }

    public void LoadShaderDemo(int index)
    {
        AnimShaderSet set = animShaderSets[index];

        // set material & get shader name
        string shaderName = string.Empty;
        foreach (GameObject model in models)
        {
            Renderer[] rends = GetRends(model);
            if (rends != null)
            {
                // set materials
                foreach (Renderer rend in rends)
                {
                    // TODO - confirm if should used shared material?  can it harm SAVED material when in non-play mode?
                    // rend.sharedMaterial = materials[index];
                    rend.material = set.material;
                }

                // save shader name
                // TODO - confirm if should get shader "name" elsewhere instead
                shaderName = (rends[0] as Renderer).sharedMaterial.shader.name;
            }
        }

        // play anim
        Animator a = models[modelIndex].GetComponent<Animator>();
        PlayAnim(a, set.animClip);

        // set details
        SetDetails(shaderName, index + 1);

        // store index
        listIndex = index;
    }

    public void LoadModel(int index)
    {
        GameObject model = models[index];

        model.SetActive(!model.active);

        modelIndex = index;
    }
    #endregion

    #region METHODS (internal)
    void Awake()
    {
        // get # of shaders to demo
        listCount = animShaderSets.Length;
    }

    void Start()
    {
        LoadShaderDemo(0);
    }

    void OnDisable()
    {
        pGraph.Destroy();
    }
    #endregion

    #region METHODS (private) 
    private void PlayAnim(Animator a, AnimationClip clip)
    {
        if (a == null || clip == null)
        {
            Debug.Log("Error @ ModelManager @ PlayAnim.");

            return;
        }
        else
        {
            // Debug.Log("Clip name is: " + clip.name);
        }

        AnimationPlayableUtilities.PlayClip(a, clip, out pGraph);
    }

    private int GetNextNavIndex(int requestedIndex)
    {
        int newIndex = requestedIndex;
        int maxIndex = listCount - 1;

        if (requestedIndex < 0)
        {
            newIndex = maxIndex;
        }
        else if (requestedIndex > maxIndex)
        {
            newIndex = 0;
        }

        return newIndex;
    }

    private void SetDetails(string shaderName, int shaderCount)
    {
        // name
        shaderNameText.text = shaderName;

        // count
        shaderCountText.text = shaderCount + ".";
    }

    private Renderer[] GetRends(GameObject go)
    {
        // TODO - convert to call recursively!
        // 	(to allow infinite depth search for Renderers)
        // 	(... now only allows 2 levels deep!)

        Renderer[] rends = null;

        // check base level
        if (go.GetComponent<Renderer>())
        {
            rends = new Renderer[1];
            rends[0] = go.GetComponent<Renderer>();

            return rends;
        }

        // check child level
        if (go.GetComponentInChildren<Renderer>())
        {
            rends = go.GetComponentsInChildren<Renderer>();

            return rends;
        }

        // check child level #2
        if (go.GetComponentInChildren<GameObject>())
        {
            GameObject child = go.GetComponentInChildren<GameObject>();

            rends = child.GetComponentsInChildren<Renderer>();

            return rends;
        }

        return null;
    }
    #endregion
}