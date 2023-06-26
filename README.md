# AutoHVAllocation
Automation tool for Diag-V

Crediting the original content of the wrtiers of their respective scripts. Thank you to Jim Gandy Tommy Paulk Luis Acosta and Mark Henderson for their help in
powershell. Allso thank you to Jake Morrison who wrote the Module which does the actual work. I am no scripter, but If I can do this, you can certainly do this. 

Keep every bit of code you come across and use everything you know and use every bit of code you have to find examples of what works. 

## AutoHVAllocation
   ![TestHVAlloc](https://user-images.githubusercontent.com/79279019/135662153-0427ecb2-332a-40bb-90d8-5f2f65864487.png)
   
   
   This tool
 uses diag-v to query cluster node hyper-v for vms and returns the resource ballance between nodes with test-hypervAllocaiton within the diag-v module
   
   ![alt text](https://user-images.githubusercontent.com/79279019/135662153-0427ecb2-332a-40bb-90d8-5f2f65864487.png))
   
   How To Use: 
      From PowerShell as admin execute the following and follow the prompts:
```Powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="TestHVAAllocation";$repo="PowershellScripts"'+(new-object System.net.webclient).DownloadString('https://raw.githubusercontent.com/Louisjreeves/AutoHVAllocation/main/3TestHypervAllocation.ps1'));Invoke-AutoHVAllocation
```

