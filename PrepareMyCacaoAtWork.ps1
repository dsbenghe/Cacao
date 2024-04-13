# Description: Boxstarter Script  
# Author: Laurent Kempé
# Dev settings for my app development

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
    iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "Browsers.ps1";
executeScript "WindowsTools.ps1";
executeScript "WorkTools.ps1";

executeScript "HyperV.ps1";
RefreshEnv
executeScript "WSL.ps1";
RefreshEnv
executeScript "Docker.ps1";
executeScript "AzureDevops.ps1";

#--- Visual Studio ---
choco install -y visualstudio2022enterprise
choco install -y visualstudio2022-workload-manageddesktop
choco install -y visualstudio2022-workload-python
choco install -y visualstudio2022-workload-netweb
choco install -y visualstudio2022-workload-azure 
choco install -y visualstudio2022-workload-visualstudioextension 
choco install -y visualstudio2022-workload-data

choco install -y resharper-ultimate-all
choco install -y jetbrains-rider

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
