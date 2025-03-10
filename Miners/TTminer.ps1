﻿using module ..\Modules\Include.psm1

param(
    [PSCustomObject]$Pools,
    [Bool]$InfoOnly
)

if (-not $IsWindows -and -not $IsLinux) {return}

$ManualUri = "https://bitcointalk.org/index.php?topic=5025783.0"
$Port = "333{0:d2}"
$DevFee = 1.0
$Cuda = "11.8"
$Version = "2023.1.1"

if ($IsLinux) {
    $Path = ".\Bin\NVIDIA-TTminer\TT-Miner"
    $Uri = "https://github.com/RainbowMiner/miner-binaries/releases/download/v2023.1.1-ttminer/TT-Miner-2023.1.1.tar.gz"

} else {
    $Path = ".\Bin\NVIDIA-TTminer\TT-Miner.exe"
    $Uri = "https://github.com/RainbowMiner/miner-binaries/releases/download/v2023.1.1-ttminer/TT-Miner-2023.1.1.zip"
}

if (-not $Global:DeviceCache.DevicesByTypes.NVIDIA -and -not $InfoOnly) {return} # No NVIDIA present in system

$Commands = [PSCustomObject[]]@(
    [PSCustomObject]@{MainAlgorithm = "Ethash"        ; DAG = $true; MinMemGB = 3;   Params = "-a ETHASH";        ExtendInterval = 2; ExcludePoolName = "MiningRigRentals"} #Ethash 
    [PSCustomObject]@{MainAlgorithm = "Ethash2g"      ; DAG = $true; MinMemGB = 1;   Params = "-a ETHASH";        ExtendInterval = 2; ExcludePoolName = "MiningRigRentals"} #Ethash 
    [PSCustomObject]@{MainAlgorithm = "Ethash3g"      ; DAG = $true; MinMemGB = 2;   Params = "-a ETHASH";        ExtendInterval = 2; ExcludePoolName = "MiningRigRentals"} #Ethash 
    [PSCustomObject]@{MainAlgorithm = "Ethash4g"      ; DAG = $true; MinMemGB = 3;   Params = "-a ETHASH";        ExtendInterval = 2; ExcludePoolName = "MiningRigRentals"} #Ethash 
    [PSCustomObject]@{MainAlgorithm = "Ethash5g"      ; DAG = $true; MinMemGB = 4;   Params = "-a ETHASH";        ExtendInterval = 2; ExcludePoolName = "MiningRigRentals"} #Ethash 
    [PSCustomObject]@{MainAlgorithm = "Etchash"       ; DAG = $true; MinMemGB = 3;   Params = "-a ETCHASH";       ExtendInterval = 2; ExcludePoolName = "MiningRigRentals"} #Etchash 
    [PSCustomObject]@{MainAlgorithm = "EthashLowMemory" ; DAG = $true; MinMemGB = 2;   Params = "-a ETHASH";      ExtendInterval = 2; ExcludePoolName = "MiningRigRentals"} #Ethash for low memory coins
    [PSCustomObject]@{MainAlgorithm = "EvrProgPow"    ; DAG = $true; MinMemGB = 3;   Params = "-a EvrProgPow";    ExtendInterval = 2} #EvrProgPow
    [PSCustomObject]@{MainAlgorithm = "FiroPow"       ; DAG = $true; MinMemGB = 3;   Params = "-a FiroPow";       ExtendInterval = 2} #FiroPow
    [PSCustomObject]@{MainAlgorithm = "Take2"         ;              MinMemGB = 1;   Params = "-a Ghostrider";    ExtendInterval = 2; DevFee = 2.0} #Ghostrider
    [PSCustomObject]@{MainAlgorithm = "KawPow"        ; DAG = $true; MinMemGB = 3;   Params = "-a KawPow";        ExtendInterval = 2} #KAWPOW (RVN,ZELS)
    [PSCustomObject]@{MainAlgorithm = "Mike"          ;              MinMemGB = 1;   Params = "-a Mike";          ExtendInterval = 2; DevFee = 2.0} #Mike
    [PSCustomObject]@{MainAlgorithm = "ProgPoWEPIC"   ; DAG = $true; MinMemGB = 3;   Params = "-coin EPIC";       ExtendInterval = 2; DevFee = 2.0} #ProgPoW (only EPIC left)
    [PSCustomObject]@{MainAlgorithm = "ProgPoWSERO"   ; DAG = $true; MinMemGB = 3;   Params = "-coin SERO";       ExtendInterval = 2} #ProgPoWSero (SERO)
    [PSCustomObject]@{MainAlgorithm = "ProgPoWVEIL"   ; DAG = $true; MinMemGB = 3;   Params = "-coin VEIL";       ExtendInterval = 2} #ProgPoWSero (VEIL)
    [PSCustomObject]@{MainAlgorithm = "ProgPoWZ"      ; DAG = $true; MinMemGB = 3;   Params = "-coin ZANO";       ExtendInterval = 2} #ProgPoWZ (ZANO)
    [PSCustomObject]@{MainAlgorithm = "SHA256dt"      ; DAG = $true; MinMemGB = 3;   Params = "-a Sha256dt";      ExtendInterval = 2} #SHA256dt
    [PSCustomObject]@{MainAlgorithm = "SHA512256d"    ; DAG = $true; MinMemGB = 3;   Params = "-a Sha512256d";    ExtendInterval = 2} #Sha512256d
    [PSCustomObject]@{MainAlgorithm = "UbqHash"       ;              MinMemGB = 2.4; Params = "-a UBQHASH";       ExtendInterval = 2} #Ubqhash
    [PSCustomObject]@{MainAlgorithm = "vProgPoW"      ; DAG = $true; MinMemGB = 3;   Params = "-a vProgPow";      ExtendInterval = 2} #ProgPoWSero (VBK)
)

$CoinSymbols = @("ETC","CLO","EXP","ETP","UBQ","SERO","EPIC","ZANO","EVOX","VBK","VEIL","FIRO","EVR","RVN","NEOX","ARL","KAW","PRCO","SATO","HVQ","TTM","MEOW","REDE","VTE","LAB","RTM","BTRM","BUT","YERB","JGC","FITA","BBC","NAPI","THOON","GSPC","LTRM","VKAX","MIKE")

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

if ($InfoOnly) {
    [PSCustomObject]@{
        Type      = @("NVIDIA")
        Name      = $Name
        Path      = $Path
        Port      = $Miner_Port
        Uri       = $Uri
        DevFee    = $DevFee
        ManualUri = $ManualUri
        Commands  = $Commands
    }
    return
}

if (-not (Confirm-Cuda -ActualVersion $Session.Config.CUDAVersion -RequiredVersion $Cuda -Warning $Name)) {return}

$Global:DeviceCache.DevicesByTypes.NVIDIA | Select-Object Vendor, Model -Unique | ForEach-Object {
    $Miner_Model = $_.Model
    $Device = $Global:DeviceCache.DevicesByTypes."$($_.Vendor)".Where({$_.Model -eq $Miner_Model})

    $Commands.ForEach({
        $First = $True
        $Algorithm_Norm_0 = Get-Algorithm $_.MainAlgorithm
        $Miner_Fee = if ($_.DevFee -ne $null) {$_.DevFee} else {$DevFee}

        $MinMemGB = if ($_.DAG) {Get-EthDAGSize -CoinSymbol $Pools.$Algorithm_Norm_0.CoinSymbol -Algorithm $Algorithm_Norm_0 -Minimum $_.MinMemGb} else {$_.MinMemGb}

        $Miner_Device = $Device | Where-Object {Test-VRAM $_ $MinMemGB}
        
		foreach($Algorithm_Norm in @($Algorithm_Norm_0,"$($Algorithm_Norm_0)-$($Miner_Model)","$($Algorithm_Norm_0)-GPU")) {
			if ($Pools.$Algorithm_Norm.Host -and (-not $_.ExcludePoolName -or $Pools.$Algorithm_Norm.Host -notmatch $_.ExcludePoolName) -and (-not $_.Coins -or $_.Coins -icontains $Pools.$Algorithm_Norm.CoinSymbol) -and $Miner_Device) {
                if ($First) {
                    $Miner_Port = $Port -f ($Miner_Device | Select-Object -First 1 -ExpandProperty Index)
                    $Miner_Name = (@($Name) + @($Miner_Device.Name | Sort-Object) | Select-Object) -join '-'
                    $Miner_Protocol = "stratum$(if ($Pools.$Algorithm_Norm_0.EthMode -eq "ethproxy" -and ($Pools.$Algorithm_Norm_0.Host -notmatch "MiningRigRentals" -or $Algorithm_Norm_0 -ne "ProgPow")) {"1"})+$(if ($Pools.$Algorithm_Norm_0.SSL) {"ssl"} else {"tcp"})://"
                    $DeviceIDsAll = $Miner_Device.Type_Vendor_Index -join ' '
                    $First = $False
                }
				$Pool_Port = if ($Pools.$Algorithm_Norm.Ports -ne $null -and $Pools.$Algorithm_Norm.Ports.GPU) {$Pools.$Algorithm_Norm.Ports.GPU} else {$Pools.$Algorithm_Norm.Port}

                $Pass = "$($Pools.$Algorithm_Norm.Pass)"
                if ($Pass -and $Pools.$Algorithm_Norm.Host -match "C3pool|MoneroOcean") {
                    $Pass = $Pass -replace ":[^:]+~","~"
                }

				[PSCustomObject]@{
					Name           = $Miner_Name
					DeviceName     = $Miner_Device.Name
					DeviceModel    = $Miner_Model
					Path           = $Path
					Arguments      = "--api-bind 127.0.0.1:`$mport -d $($DeviceIDsAll)$(if ($_.DAG) {" -dag-2disk -daginfo"}) -P $($Miner_Protocol)$($Pools.$Algorithm_Norm.User)$(if ($Pass) {":$($Pass)"})@$($Pools.$Algorithm_Norm.Host):$($Pools.$Algorithm_Norm.Port)$(if ($Pools.$Algorithm_Norm.Worker -and $Pools.$Algorithm_Norm.User -notmatch "{workername") {" -w $($Pools.$Algorithm_Norm.Worker)"})$(if ($_.Params -notmatch "-coin" -and $Pools.$Algorithm_Norm.CoinSymbol -and $CoinSymbols -icontains $Pools.$Algorithm_Norm.CoinSymbol) {" -coin $($Pools.$Algorithm_Norm.CoinSymbol)"}) $($_.Params)"
					HashRates      = [PSCustomObject]@{$Algorithm_Norm = $($Global:StatsCache."$($Miner_Name)_$($Algorithm_Norm_0)_HashRate".Week)}
					API            = "Claymore"
					Port           = $Miner_Port                
					Uri            = $Uri
                    FaultTolerance = $_.FaultTolerance
					ExtendInterval = $_.ExtendInterval
                    Penalty        = 0
					DevFee         = $Miner_Fee
					ManualUri      = $ManualUri
                    Version        = $Version
                    PowerDraw      = 0
                    BaseName       = $Name
                    BaseAlgorithm  = $Algorithm_Norm_0
                    Benchmarked    = $Global:StatsCache."$($Miner_Name)_$($Algorithm_Norm_0)_HashRate".Benchmarked
                    LogFile        = $Global:StatsCache."$($Miner_Name)_$($Algorithm_Norm_0)_HashRate".LogFile
                    ExcludePoolName= $_.ExcludePoolName
				}
			}
		}
    })
}