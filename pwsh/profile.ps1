function Get--PredictionViewStyle() {
    $height = (Get-Host).UI.RawUI.WindowSize.Height
    $width = (Get-Host).UI.RawUI.WindowSize.Width

    if ($height -ge 15 -and $width -ge 54) {
        return "ListView"
    } else {
        return "InlineView"
    }
}

$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
$ENV:SHOW_STARSHIP_DISTRO = $true

Invoke-Expression (&starship init powershell)

# Add auto complete (requires PSReadline 2.2.0-beta1+ prerelease)
Set-PSReadLineOption -PredictionSource History
#  set -PredictionViewStyle
Set-PSReadLineOption -PredictionViewStyle (Get--PredictionViewStyle)
Set-PSReadLineOption -EditMode Windows

# add icon in dir names
Import-Module -Name Terminal-Icons