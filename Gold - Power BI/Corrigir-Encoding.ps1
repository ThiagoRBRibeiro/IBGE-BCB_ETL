# Corrige encoding UTF-8 BOM -> UTF-8 sem BOM em todos os JSONs
$reportBase = "C:\Users\Thiago\IBGE-BCB_ETL\Gold - Power BI\PIX.Report\definition"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

Get-ChildItem -Path $reportBase -Recurse -Filter "*.json" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    [System.IO.File]::WriteAllText($_.FullName, $content, $utf8NoBom)
    Write-Host "OK $($_.FullName)" -ForegroundColor Green
}
Write-Host ""
Write-Host "Pronto! Reabra o PIX.pbip no Power BI Desktop." -ForegroundColor Cyan