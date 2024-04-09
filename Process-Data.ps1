[CmdletBinding()]
Param()

$dataPath = Join-Path -Path $PSScriptRoot -ChildPath 'data'
$leaguePath = Join-Path -Path $dataPath -ChildPath 'leagues' -AdditionalChildPath '*.json'
$orgPath = Join-Path -Path $dataPath -ChildPath 'organizations' -AdditionalChildPath '*.json'

$outputPath = Join-Path -Path $PSScriptRoot -ChildPath 'output'
$mapPath = Join-Path -Path $outputPath -ChildPath 'maps'

function Get-Data {
    param(
        [ValidateScript({ Test-Path -Path $_ })]
        [string]$Path
    )

    $fileList = Get-ChildItem -Path $leaguePath -File
    foreach ( $file in $fileList ) {
        Get-Content $file.FullName | ConvertFrom-Json -Depth 99 -AsHashtable | Write-Output
    }
}

$leagueData = Get-Data -Path $leaguePath
$orgData = Get-Data -Path $orgPath

foreach ( $league in $leagueData ) {
    Write-Host "Processing League: $($league.name)"
    $mapFilePath = Join-Path -Path $mapPath -ChildPath ( '{0}.geojson' -f $league.name )
    
}

# $testResult = Invoke-RestMethod -Uri 'https://nominatim.openstreetmap.org/search?country=United%20States&format=geojson&polygon_geojson=1'