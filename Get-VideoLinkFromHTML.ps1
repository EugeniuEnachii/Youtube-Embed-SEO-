param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV
)

$Content = Import-Csv -Path $PathCSV -Delimiter ';'

$Content

#$Invocation = Invoke-WebRequest -Uri "URL"
#
#$HTMLFromInvocation = $Invocation.Content
#
#$VideoLinkRegexPattern = '"label":\s*"1080p".*?"source":\s*"([^"]+)"'
#
#[regex]::Matches($html, $pattern, 'Singleline') | ForEach-Object { $_.Groups[1].Value }