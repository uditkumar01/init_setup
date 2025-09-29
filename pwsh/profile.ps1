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

# Starship
if (Test-Path "C:\Program Files\starship\bin\starship.exe") {
    Invoke-Expression (& "C:\Program Files\starship\bin\starship.exe" init powershell)
}

if (Get-Module -Name PSReadLine) {
    # Prediction and History
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle (Get--PredictionViewStyle)
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineOption -MaximumHistoryCount 4000
    
    # Enhanced Key Bindings
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteChar
    Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardDeleteWord
    Set-PSReadLineKeyHandler -Key Alt+d -Function DeleteWord
    Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
    Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
    
    # Modern Colors
    Set-PSReadLineOption -Colors @{
        Command            = '#00bfff'
        Parameter          = '#87ceeb'
        Operator           = '#ffffff'
        Variable           = '#32cd32'
        String             = '#ffd700'
        Number             = '#ff6347'
        Type               = '#4682b4'
        Comment            = '#228b22'
        Keyword            = '#1e90ff'
        Error              = '#ff4500'
        Selection          = '#4169e1'
        InlinePrediction   = '#696969'
    }
}

# add icon in dir names
Import-Module -Name Terminal-Icons

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
