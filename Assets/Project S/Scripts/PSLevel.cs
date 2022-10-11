using System;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PSLevel : MonoBehaviour
{
    [SerializeField] private String _sceneName;
    [SerializeField] private String _mainMenuSceneName;

    public void LoadLevel()
    {
        SceneManager.LoadScene(_sceneName);
    }

    public void CompleteLevel()
    {
        Debug.Log("Hamada");
        SceneManager.LoadScene(_mainMenuSceneName);
    }
    
    
}