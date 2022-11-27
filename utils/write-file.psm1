function Write-File ([string]$Path, [string]$Content) {
    if (Test-Path $Path) {
        Write-Warning "File $Path already exists"
        $promptText = @(
            "Which action do you want to take for $Path?`n"
            "1. Overwrite"
            "2. Append"
            "3. Skip"
        )
        $appendOrOverwrite = Read-Host -Prompt (Write-Color $promptText -Color White, DarkGray, DarkGray, DarkGray -Separator "`n")
        switch ($appendOrOverwrite) {
            1 {
                Write-Color "Overwriting $Path..." -Color DarkGray
                Set-Content -Path $Path -Value $Content
            }
            2 {
                # add a newline to the end of the file
                $Content = "`n$Content"
                Write-Color "Appending to $Path..." -Color DarkGray
                Add-Content $Path $Content
            }
            default {
                Write-Color "Skipping $Path..." -Color DarkGray
            }
        }
    } else {
        New-Item -Path $Path -ItemType File -Force | Out-Null
        Set-Content -Path $Path -Value $Content

        Write-Color "Created $Path" -Color DarkGray
    }
}

Export-ModuleMember -Function Write-File