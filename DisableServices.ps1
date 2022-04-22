function DisableServices
{
    $listservices = "ALG", "AppVClient", "Browser", "BthAvctpSvc", "bthserv", "BTAGService", "Fhsvc", "HvHost", "iphlpsvc", "LanmanServer", "Ifsvc", "MSiSCSI", "NcbService", "NetTcpPortSharing", "p2pimsvc", "p2psvc", "PNRPAutoReg", "PNRPsvc", "RemoteAccess", "RemoteRegistry", "RetailDemo", "RpcLocator", "SharedAccess", "shpamsvc", "smphost", "SmsRouter", "SNMPTRAP", "SSDPSRV", "TermService", "tzautoupdate", "UevAgentService", "vmicguestinterface", "vmicheartbeat", "vmickvpexchange", "vmicrdv", "vmicshutdown", "vmictimesync", "vmicvmsession", "vmiccvss", "WalletService", "wercplsupport", "WerSvc", "WinRM", "WMPNetworkSvc", "workfolderssvc", "WpnService", "wuauserv", "XblAuthManager", "XblGameSave", "XboxNetApiSvc", "SEMgrSvc", "WFDSConMgrSvc", "WpcMonSvc", "XboxGipSvc", "WbioSrvc", "icssvc", "NaturalAuthentication", "p2pimsvc"

    Foreach ($service in $listservices) {
        Stop-service -Name $service
        Set-Service $service -StartupType Disabled
    }
}

function DisableLLDPProvider
{
    Set-NetAdapterBinding -Name "*" -ComponentID "ms_lldp" -Enabled ${False}
    Set-NetAdapterBinding -Name "*" -ComponentID "ms_rspndr" -Enabled ${False}
    Set-NetAdapterBinding -Name "*" -ComponentID "ms_lltdio" -Enabled ${False}
    Set-NetAdapterBinding -Name "*" -ComponentID "ms_server" -Enabled ${False}
    Set-NetAdapterBinding -Name "*" -ComponentID "ms_tcpip6" -Enabled ${False}
    Get-NetAdapterBinding -InterfaceAlias "*" ms_lldp, ms_rspndr, ms_lltdio | ForEach-Object {
        if ($_.Enabled -eq ${True}) {
            Write-Output("[x] Failed to disable $($_.Name)")
            return
        } else {
            Write-Output("[i] Successfully disabled $(($_.Name))")
            return
        }
    }
}

function DisableOptionalFeatures
{
    Disable-WindowsOptionalFeature -Online -FeatureName WindowsMediaPlayer, SmbDirect, MediaPlayBack, WCF-TCP-PortSharing45, WCF-Services45, WorkFolders-Client, Printing-Foundation-InternetPrinting-Client
}
