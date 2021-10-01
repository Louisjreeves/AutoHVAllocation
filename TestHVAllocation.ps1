#Diag-V-master.zip

#C:\Users\Administrator.Corp\AppData\Local\Temp
#C:\Program Files (x86)\WindowsPowerShell\Modules

Write-Host " Hello Person. This installs the Diag-V agent from Github. This will run Test-HyperVAllocation. Please Return the results to your`
support team" -ForegroundColor Green
start-sleep 5

cls
$mydomain = Read-host "what is the Full Name of your domain? "
Write-host " Now enabling WSMAN from this server. You will need to manually run these on the other nodes, if they are not setup for CredSSP.The commands as Follows"
Write-host " Enable-WSManCredSSP -Role "Client" -DelegateComputer "*.$mydomain"" -ForegroundColor Green
write-host " Enable-WSManCredSSP -Role "Server" " -ForegroundColor Green
Write-host "Set-Item WSMan:\localhost\Client\TrustedHosts * -force"  -ForegroundColor Green
Write-host "Set-executionpolicy -executionpolicy remotesigned -force"  -ForegroundColor Green
Write-host "Netsh ADVFirewall Set Allprofiles State Off"  -ForegroundColor Green

$fullname=  "*.$mydomain"
Enable-WSManCredSSP -Role "Client" -DelegateComputer $fullname
Enable-WSManCredSSP -Role "Server" 
Set-Item WSMan:\localhost\Client\TrustedHosts * -force
Set-executionpolicy -executionpolicy remotesigned -force
Netsh ADVFirewall Set Allprofiles State Off

write-host "now checking for admin. if not admin - will restart as admin. Hit cancel and make sure your running on a cluster node!!"
Start-Sleep 2

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

$cred = Get-Credential

$ans1 = Read-host "Would you like to download and install or do you have the file pre-downloaded? 1=Proceed online 2=I have the file "

If ($ans1 -ieq "1") { 

$MyTemp=(Get-Item $env:temp).fullname
 $src = 'src'
$downloada = 'diag-v-master'
 $module = 'Diag-V'; $branch = 'master'

try
 {
   $response = Invoke-WebRequest -Uri https://github.com/Louisjreeves/Diag-V/archive/refs/heads/master.zip -OutFile $MyTemp\$branch.zip
   $StatusCode = $Response.StatusCode
 } catch 
 {
    $StatusCode = $_.Exception.Response.StatusCode.value__
  }

  $fullpath= "C:\Users\*\AppData\Local\Temp\master.zip"

#$GetFile = $mytemp # diag-v-master.zip
$getDIagVFol = (split-path $fullpath -Leaf).Split(".")[0]  #diag-v-master
$getDiagpath = (split-path $fullpath -parent)  #C:\Users\Administrator.Corp\Desktop

$md = "$env:ProgramFiles\WindowsPowerShell\Modules"
$final= "c:\ProgramFiles\WindowsPowerShell\Modules\Diag-V-master\src\"
$final2= "c:\Program Files\WindowsPowerShell\Modules\Diag-V-master\src\diag-v"
$extractedDiag= "Diag-v-master"
$finalFile= "diag-V"
Expand-Archive -Path $getdiagpath\$getDIagVFol.zip -DestinationPath $md -Force
#cp -Recurse $getfile $md -Force -ErrorAction Stop
cp -Recurse $final2 $md -Force -ErrorAction stop
Import-module -Verbose $md\$finalfile -Force
start-sleep 5
Write-Host "Beginning to run Test-HypevAllocation. It will return basics about the VM Resources and storage" -ForegroundColor Green
Start-Sleep 2
Test-HyperVAllocation -Credential $cred

}
If ($ans1 -ieq "2") { 


Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false # Multiple files can be chosen
	Filter = 'Images (*.zip, *.zip)|*.zip;*.zip' # Specified file types
}
 
[void]$FileBrowser.ShowDialog()

$file = $FileBrowser.FileName;

If($FileBrowser.FileNames -like "*\*") {

	# Do something 
	# $FileBrowser.FileName #Lists selected files (optional)
$GetFile = $FileBrowser.FileName # diag-v-master.zip
$getDIagVFol = (split-path $GetFile -Leaf).Split(".")[0]  #diag-v-master
$getDiagpath = (split-path $GetFile -parent)  #C:\Users\Administrator.Corp\Desktop

$md = "$env:ProgramFiles\WindowsPowerShell\Modules"
$final= "c:\ProgramFiles\WindowsPowerShell\Modules\Diag-V-master\src\"
$final2= "c:\Program Files\WindowsPowerShell\Modules\Diag-V-master\src\diag-v"
$extractedDiag= "Diag-v-master"
$finalFile= "diag-V"
Expand-Archive -Path $getdiagpath\$getDIagVFol.zip -DestinationPath $md -Force
#cp -Recurse $getfile $md -Force -ErrorAction Stop
cp -Recurse $final2 $md -Force -ErrorAction stop
Import-module -Verbose $md\$finalfile -Force
Start-sleep 5
Write-Host "Beginning to run Test-HypevAllocation. It will return basics about the VM Resources and storage" -ForegroundColor Green

Test-HyperVAllocation -Credential $cred

}


else {
    Write-Host "Cancelled by user"
}




}

Read-Host -Prompt "Press Enter to exit"


<#https://codeload.github.com/techthoughts2/Diag-V/zip/master.zip
https://github.com/techthoughts2/Diag-V/archive/refs/heads/master.zip
https://github.com/techthoughts2/Diag-V/archive/master.zip
https://github.com/techthoughts2/Diag-V/archive/zip/master.zip
https://github.com/Louisjreeves/Diag-V/archive/refs/heads/master.zip
https://github.com/Louisjreeves/Diag-V/archive/refs/heads/master.zip#>
