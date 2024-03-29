#Diag-V-master.zip

#C:\Users\Administrator.Corp\AppData\Local\Temp
#C:\Program Files (x86)\WindowsPowerShell\Modules

Write-Host " Hello Person. This installs the Diag-V agent from Github. This will run Test-HyperVAllocation. Please Return the results to your`
support team" -ForegroundColor Green
start-sleep 5


$mydomain = Read-host "what is the Full Name of your domain? "
Write-host " Now enabling WSMAN from this server. This script is mostly silent. just choose yes for every answer" -forgroungcolor green
 

$fullname=  "*.$mydomain"
Enable-WSManCredSSP -Role "Client" -DelegateComputer $fullname
Enable-WSManCredSSP -Role "Server" 
Set-Item WSMan:\localhost\Client\TrustedHosts * -force
Set-executionpolicy -executionpolicy remotesigned -force
Netsh ADVFirewall Set Allprofiles State Off


If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

 
   
  
 $global:mydom = $env:USERDOMAIN
$global:myuser = $Env:Username
 
$global:creds = Get-Credential -UserName $mydom\$myuser -Message "Pop Creds for OMIMSWAC $Env:Username"

##get file 

$MyTemp = (Get-Item $env:PUBLIC).fullname
$myloc1 = Set-Location -Path $mytemp
 $src = 'src'
$downloada = 'diag-v-master'
 $module = 'Diag-V'; $branch = 'master'

try
 {
   $response = Invoke-WebRequest -Uri https://github.com/Louisjreeves/Diag-V/archive/refs/heads/master.zip -OutFile $mytemp\$branch.zip -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
   $StatusCode = $Response.StatusCode
 } catch 
 {
    $StatusCode = $_.Exception.Response.StatusCode.value__
  }

#### get file
$fullpath = "$mytemp\master.zip"
### move and extract 

 

$getDIagVFol = (split-path $fullpath -Leaf).Split(".")[0]  #diag-v-master
#$getDiagpath = (split-path $fullpath -parent)  #C:\Users\Administrator.Corp\Desktop
$getDiagPath = $fullpath | Split-Path -Parent
$md = "$env:ProgramFiles\WindowsPowerShell\Modules"
$final= "c:\ProgramFiles\WindowsPowerShell\Modules\Diag-V-master\src\"
$final2= "c:\Program Files\WindowsPowerShell\Modules\Diag-V-master\src\diag-v"
$extractedDiag= "Diag-v-master"
$finalFile= "diag-V"



Expand-Archive -Path "$getDiagPath\$getDIagVFol.zip" -DestinationPath $md -Force

#cp -Recurse $getfile $md -Force -ErrorAction Stop
cp -Recurse $final2 $md -Force -ErrorAction stop
Import-module -Verbose $md\$finalfile -Force
start-sleep 5
Write-Host "Beginning to run Auto-HypevAllocation. It will return basics about the VM Resources and storage" -ForegroundColor Green
Start-Sleep 2
Test-HyperVAllocation -Credential $cred







<#https://codeload.github.com/techthoughts2/Diag-V/zip/master.zip
https://github.com/techthoughts2/Diag-V/archive/refs/heads/master.zip
https://github.com/techthoughts2/Diag-V/archive/master.zip
https://github.com/techthoughts2/Diag-V/archive/zip/master.zip
https://github.com/Louisjreeves/Diag-V/archive/refs/heads/master.zip
https://github.com/Louisjreeves/Diag-V/archive/refs/heads/master.zip#>
