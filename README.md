# AutoHVAllocation
Automation tool for Diag-V

## AutoHVAllocation
   ![TestHVAlloc](https://user-images.githubusercontent.com/79279019/135662153-0427ecb2-332a-40bb-90d8-5f2f65864487.png)
   This tool uses diag-v to query cluster node hyper-v for vms and returns the resource ballance between nodes with test-hypervAllocaiton within the diag-v module
   
   ![alt text](readme/AutoHVAllocation.jpg)
   
   How To Use: 
      From PowerShell as admin execute the following and follow the prompts:
```Powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="LogCollector";$repo="PowershellScripts"'+(new-object System.net.webclient).DownloadString('https://raw.githubusercontent.com/LouisJReeves/AutoHVAllocation/main/AutoHVAllocation.ps1'));Invoke-AutoHVAllocation
```

