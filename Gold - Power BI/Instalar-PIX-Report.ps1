# ============================================================
# Instalar-PIX-Report.ps1
# Copia os arquivos de páginas e visuais para o PIX.Report
# Execute no PowerShell como Administrador
# ============================================================
 
$reportBase = "C:\Users\Thiago\IBGE-BCB_ETL\Gold - Power BI\PIX.Report\definition"
 
# ── Garante que o pages.json já existe (edita o existente se já houver páginas)
$pagesJsonPath = Join-Path $reportBase "pages.json"
$pagesContent = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/pages/1.0.0/schema.json",
  "pageOrder": [
    "page001overview",
    "page002temporal",
    "page003geo"
  ],
  "activePageName": "page001overview"
}
'@
 
# Se já existe pages.json com páginas, faz merge do pageOrder
if (Test-Path $pagesJsonPath) {
    $existing = Get-Content $pagesJsonPath -Raw | ConvertFrom-Json
    $newPages = @("page001overview","page002temporal","page003geo")
    $merged = ($existing.pageOrder + $newPages) | Select-Object -Unique
    $existing.pageOrder = $merged
    $existing | ConvertTo-Json -Depth 10 | Set-Content $pagesJsonPath -Encoding UTF8
    Write-Host "✅ pages.json atualizado (merge)" -ForegroundColor Green
} else {
    $pagesContent | Set-Content $pagesJsonPath -Encoding UTF8
    Write-Host "✅ pages.json criado" -ForegroundColor Green
}
 
# ── Definição de todos os arquivos a criar ──────────────────
$files = @{
 
# ===== PÁGINA 1: VISÃO GERAL =====
"pages\page001overview\page.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/page/2.1.0/schema.json",
  "name": "page001overview",
  "displayName": "Visão Geral",
  "displayOption": "FitToPage",
  "height": 720,
  "width": 1280
}
'@
 
"pages\page001overview\visuals\p1v01\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v01",
  "position": { "x": 0, "y": 48, "z": 0, "height": 38, "width": 200, "tabOrder": 0 },
  "visual": {
    "visualType": "slicer",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ano" } }, "queryRef": "pix_statistics.Ano" }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Ano'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "false" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v02\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v02",
  "position": { "x": 210, "y": 48, "z": 0, "height": 38, "width": 280, "tabOrder": 1000 },
  "visual": {
    "visualType": "slicer",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Regiao" } }, "queryRef": "pix_statistics.Regiao" }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Região'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "false" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v03\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v03",
  "position": { "x": 0, "y": 93, "z": 0, "height": 100, "width": 207, "tabOrder": 2000 },
  "visual": {
    "visualType": "card",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'💰 Valor Total Transacionado'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v04\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v04",
  "position": { "x": 213, "y": 93, "z": 0, "height": 100, "width": 207, "tabOrder": 3000 },
  "visual": {
    "visualType": "card",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Quantidade_Transacoes" } }, "queryRef": "pix_statistics.Total_Quantidade_Transacoes", "active": true }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'🔢 Total de Transações'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v05\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v05",
  "position": { "x": 426, "y": 93, "z": 0, "height": 100, "width": 207, "tabOrder": 4000 },
  "visual": {
    "visualType": "card",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ticket_Medio_PF" } }, "queryRef": "pix_statistics.Ticket_Medio_PF", "active": true }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'👤 Ticket Médio PF'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v06\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v06",
  "position": { "x": 639, "y": 93, "z": 0, "height": 100, "width": 207, "tabOrder": 5000 },
  "visual": {
    "visualType": "card",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ticket_Medio_PJ" } }, "queryRef": "pix_statistics.Ticket_Medio_PJ", "active": true }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'🏢 Ticket Médio PJ'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v07\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v07",
  "position": { "x": 852, "y": 93, "z": 0, "height": 100, "width": 207, "tabOrder": 6000 },
  "visual": {
    "visualType": "card",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Percentual_PF" } }, "queryRef": "pix_statistics.Percentual_PF", "active": true }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'% Pessoa Física'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v08\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v08",
  "position": { "x": 1065, "y": 93, "z": 0, "height": 100, "width": 215, "tabOrder": 7000 },
  "visual": {
    "visualType": "card",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Crescimento_MoM" } }, "queryRef": "pix_statistics.Crescimento_MoM", "active": true }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'📈 Crescimento MoM'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v09\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v09",
  "position": { "x": 0, "y": 200, "z": 0, "height": 510, "width": 820, "tabOrder": 8000 },
  "visual": {
    "visualType": "lineChart",
    "query": { "queryState": {
      "Category": { "projections": [
        { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ano" } }, "queryRef": "pix_statistics.Ano" },
        { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Mes" } }, "queryRef": "pix_statistics.Mes" }
      ]},
      "Y": { "projections": [
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Valor_PagadorPF" } }, "queryRef": "pix_statistics.Valor_PagadorPF" },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Valor_PagadorPJ" } }, "queryRef": "pix_statistics.Valor_PagadorPJ" }
      ]}
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Evolução Mensal do Valor Transacionado'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v10\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v10",
  "position": { "x": 830, "y": 200, "z": 0, "height": 245, "width": 450, "tabOrder": 9000 },
  "visual": {
    "visualType": "donutChart",
    "query": { "queryState": {
      "Category": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Regiao" } }, "queryRef": "pix_statistics.Regiao" }] },
      "Y": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true }] }
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Valor por Região'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page001overview\visuals\p1v11\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p1v11",
  "position": { "x": 830, "y": 455, "z": 0, "height": 255, "width": 450, "tabOrder": 10000 },
  "visual": {
    "visualType": "stackedBarChart",
    "query": { "queryState": {
      "Category": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Regiao" } }, "queryRef": "pix_statistics.Regiao" }] },
      "Y": { "projections": [
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Valor_PagadorPF" } }, "queryRef": "pix_statistics.Valor_PagadorPF", "active": true },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Valor_PagadorPJ" } }, "queryRef": "pix_statistics.Valor_PagadorPJ" }
      ]}
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'PF vs PJ por Região'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
# ===== PÁGINA 2: ANÁLISE TEMPORAL =====
"pages\page002temporal\page.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/page/2.1.0/schema.json",
  "name": "page002temporal",
  "displayName": "Análise Temporal",
  "displayOption": "FitToPage",
  "height": 720,
  "width": 1280
}
'@
 
"pages\page002temporal\visuals\p2v01\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p2v01",
  "position": { "x": 0, "y": 48, "z": 0, "height": 38, "width": 300, "tabOrder": 0 },
  "visual": {
    "visualType": "slicer",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ano" } }, "queryRef": "pix_statistics.Ano" }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Filtrar por Ano'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "false" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page002temporal\visuals\p2v02\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p2v02",
  "position": { "x": 0, "y": 93, "z": 0, "height": 290, "width": 1280, "tabOrder": 1000 },
  "visual": {
    "visualType": "lineChart",
    "query": { "queryState": {
      "Category": { "projections": [
        { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ano" } }, "queryRef": "pix_statistics.Ano" },
        { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Mes" } }, "queryRef": "pix_statistics.Mes" }
      ]},
      "Y": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true }] },
      "Y2": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Crescimento_MoM" } }, "queryRef": "pix_statistics.Crescimento_MoM" }] }
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Valor Total e Crescimento MoM (%)'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page002temporal\visuals\p2v03\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p2v03",
  "position": { "x": 0, "y": 393, "z": 0, "height": 310, "width": 630, "tabOrder": 2000 },
  "visual": {
    "visualType": "clusteredColumnChart",
    "query": { "queryState": {
      "Category": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Mes" } }, "queryRef": "pix_statistics.Mes" }] },
      "Series": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ano" } }, "queryRef": "pix_statistics.Ano" }] },
      "Y": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true }] }
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Comparativo Ano a Ano por Mês (YoY)'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page002temporal\visuals\p2v04\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p2v04",
  "position": { "x": 640, "y": 393, "z": 0, "height": 310, "width": 640, "tabOrder": 3000 },
  "visual": {
    "visualType": "tableEx",
    "query": { "queryState": { "Values": { "projections": [
      { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ano" } }, "queryRef": "pix_statistics.Ano" },
      { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Mes" } }, "queryRef": "pix_statistics.Mes" },
      { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true },
      { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Quantidade_Transacoes" } }, "queryRef": "pix_statistics.Total_Quantidade_Transacoes" },
      { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Crescimento_MoM" } }, "queryRef": "pix_statistics.Crescimento_MoM" },
      { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Valor_Medio_Transacao" } }, "queryRef": "pix_statistics.Valor_Medio_Transacao" }
    ]}}} ,
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Detalhe por Ano e Mês'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page002temporal\visuals\p2v05\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p2v05",
  "position": { "x": 310, "y": 48, "z": 0, "height": 38, "width": 300, "tabOrder": 100 },
  "visual": {
    "visualType": "card",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Valor_YTD" } }, "queryRef": "pix_statistics.Valor_YTD", "active": true }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Valor YTD'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
# ===== PÁGINA 3: ANÁLISE GEOGRÁFICA =====
"pages\page003geo\page.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/page/2.1.0/schema.json",
  "name": "page003geo",
  "displayName": "Análise Geográfica",
  "displayOption": "FitToPage",
  "height": 720,
  "width": 1280
}
'@
 
"pages\page003geo\visuals\p3v01\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p3v01",
  "position": { "x": 0, "y": 48, "z": 0, "height": 38, "width": 300, "tabOrder": 0 },
  "visual": {
    "visualType": "slicer",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Regiao" } }, "queryRef": "pix_statistics.Regiao" }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Região'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "false" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page003geo\visuals\p3v02\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p3v02",
  "position": { "x": 310, "y": 48, "z": 0, "height": 38, "width": 200, "tabOrder": 100 },
  "visual": {
    "visualType": "slicer",
    "query": { "queryState": { "Values": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ano" } }, "queryRef": "pix_statistics.Ano" }] } } },
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Ano'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "false" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page003geo\visuals\p3v03\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p3v03",
  "position": { "x": 0, "y": 93, "z": 0, "height": 290, "width": 620, "tabOrder": 1000 },
  "visual": {
    "visualType": "clusteredBarChart",
    "query": { "queryState": {
      "Category": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Regiao" } }, "queryRef": "pix_statistics.Regiao" }] },
      "Y": { "projections": [
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Share_Regiao" } }, "queryRef": "pix_statistics.Share_Regiao" }
      ]}
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Valor Transacionado por Região'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page003geo\visuals\p3v04\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p3v04",
  "position": { "x": 640, "y": 93, "z": 0, "height": 290, "width": 640, "tabOrder": 2000 },
  "visual": {
    "visualType": "clusteredBarChart",
    "query": { "queryState": {
      "Category": { "projections": [{ "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Estado" } }, "queryRef": "pix_statistics.Estado" }] },
      "Y": { "projections": [{ "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true }] }
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Top Estados por Valor (aplique TopN no painel Filtros)'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
"pages\page003geo\visuals\p3v05\visual.json" = @'
{
  "$schema": "https://developer.microsoft.com/json-schemas/fabric/item/report/definition/visualContainer/2.7.0/schema.json",
  "name": "p3v05",
  "position": { "x": 0, "y": 393, "z": 0, "height": 310, "width": 1280, "tabOrder": 3000 },
  "visual": {
    "visualType": "matrix",
    "query": { "queryState": {
      "Rows": { "projections": [
        { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Regiao" } }, "queryRef": "pix_statistics.Regiao" },
        { "field": { "Column": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Estado" } }, "queryRef": "pix_statistics.Estado" }
      ]},
      "Values": { "projections": [
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Valor_Transacoes" } }, "queryRef": "pix_statistics.Total_Valor_Transacoes", "active": true },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Total_Quantidade_Transacoes" } }, "queryRef": "pix_statistics.Total_Quantidade_Transacoes" },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Share_Estado" } }, "queryRef": "pix_statistics.Share_Estado" },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ticket_Medio_PF" } }, "queryRef": "pix_statistics.Ticket_Medio_PF" },
        { "field": { "Measure": { "Expression": { "SourceRef": { "Entity": "pix_statistics" } }, "Property": "Ticket_Medio_PJ" } }, "queryRef": "pix_statistics.Ticket_Medio_PJ" }
      ]}
    }},
    "visualContainerObjects": {
      "title": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } }, "text": { "expr": { "Literal": { "Value": "'Detalhamento por Região e Estado'" } } } }}],
      "border": [{ "properties": { "show": { "expr": { "Literal": { "Value": "true" } } } }}]
    },
    "drillFilterOtherVisuals": true
  }
}
'@
 
}
 
# ── Cria todos os arquivos ──────────────────────────────────
$count = 0
foreach ($relativePath in $files.Keys) {
    $fullPath = Join-Path $reportBase $relativePath
    $dir = Split-Path $fullPath -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $files[$relativePath] | Set-Content $fullPath -Encoding UTF8
    $count++
}
 
Write-Host ""
Write-Host "✅ Reporting Build Complete" -ForegroundColor Green
Write-Host ""
Write-Host "  📄 page001overview  → 11 visuais (6 KPIs + Linha + Donut + Barras + 2 Slicers)"
Write-Host "  📄 page002temporal  → 5 visuais  (Linha MoM + Colunas YoY + Tabela + Slicer + Card YTD)"
Write-Host "  📄 page003geo       → 5 visuais  (Barras Região + Barras Estado + Matrix + 2 Slicers)"
Write-Host ""
Write-Host "  Total de arquivos gravados: $count" -ForegroundColor Cyan
Write-Host "  pages.json: atualizado ✅" -ForegroundColor Cyan
Write-Host ""
Write-Host "ℹ️  Feche e reabra o PIX.pbip no Power BI Desktop para ver as páginas." -ForegroundColor Yellow
Write-Host "ℹ️  Para TopN nos Estados: Filtros pane → arraste Estado → Top N → 10." -ForegroundColor Yellow