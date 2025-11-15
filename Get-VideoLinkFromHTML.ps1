function Get-1080pLink {
    param([string]$Url)
    $r = Invoke-WebRequest $Url
    $pattern = '"label":\s*"1080p".*?"source":\s*"([^"]+)"'
    [regex]::Matches($r.Content, $pattern, 'Singleline') |
    ForEach-Object { $_.Groups[1].Value }
}

Get-1080pLink "https://milwaukeetool.widen.net/s/vjzmzmqszg/milwaukeer-m18trade-mark-sign-milwaukeer-redlithiumtrade-mark-sign-forgetrade-mark-sign-hd12"