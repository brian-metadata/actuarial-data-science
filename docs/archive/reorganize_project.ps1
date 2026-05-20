# Safe project reorganization script
# Moves actuarial-inventory files to subfolder and creates lakehouse-gap-analysis folder

$ErrorActionPreference = "Stop"

Write-Host "Starting project reorganization..." -ForegroundColor Green

# Define file lists
$actuarialFiles = @(
    "actuarial_impact_analysis.ipynb",
    "Actuarial_Inventory_Overview_Slide1.ipynb_generated.pptx",
    "ACTUARIAL_INVENTORY_SUMMARY.md",
    "Actuarial-Inventory.ipynb",
    "actuarial-inventory2-clean.html",
    "actuarial-inventory2-presentation.html",
    "actuarial-inventory2-slides.html",
    "actuarial-inventory2.html",
    "actuarial-inventory2.ipynb",
    "actuarial-inventory2.pdf",
    "Exec_KPI.ipynb",
    "flowchart TB.mmd"
)

$actuarialFolders = @(
    "charts",
    "output",
    "context-engineering",
    "presentation-planning",
    "actuarial-inventory"  # Already exists
)

$lakehouseFiles = @(
    "notebooks\ingestion-impact-plan.ipynb",
    "notebooks\readme-plan.md",
    "notebooks\Metadata_Master_Sheet_v2_2026.xlsx",
    "notebooks\generate_master_sheet.py",
    "notebooks\update_notebook_cell.py",
    "notebooks\EXCEL_FILE_GENERATED.md",
    "notebooks\NOTEBOOK_IMPROVEMENTS.md"
)

# Create directories
Write-Host "`nCreating directories..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "actuarial-inventory" | Out-Null
New-Item -ItemType Directory -Force -Path "lakehouse-gap-analysis" | Out-Null
New-Item -ItemType Directory -Force -Path "lakehouse-gap-analysis\notebooks" | Out-Null

# Move actuarial files
Write-Host "`nMoving actuarial-inventory files..." -ForegroundColor Yellow
foreach ($file in $actuarialFiles) {
    if (Test-Path $file) {
        Write-Host "  Moving: $file" -ForegroundColor Cyan
        Move-Item -Path $file -Destination "actuarial-inventory\" -Force
    } else {
        Write-Host "  Not found (skipping): $file" -ForegroundColor Gray
    }
}

# Move actuarial folders
Write-Host "`nMoving actuarial-inventory folders..." -ForegroundColor Yellow
foreach ($folder in $actuarialFolders) {
    if ($folder -eq "actuarial-inventory") {
        Write-Host "  Skipping: $folder (destination folder)" -ForegroundColor Gray
        continue
    }
    if (Test-Path $folder) {
        Write-Host "  Moving: $folder" -ForegroundColor Cyan
        Move-Item -Path $folder -Destination "actuarial-inventory\" -Force
    } else {
        Write-Host "  Not found (skipping): $folder" -ForegroundColor Gray
    }
}

# Move lakehouse files
Write-Host "`nMoving lakehouse-gap-analysis files..." -ForegroundColor Yellow
foreach ($file in $lakehouseFiles) {
    if (Test-Path $file) {
        # Extract just the filename (remove notebooks\ prefix for destination)
        $fileName = Split-Path -Leaf $file
        Write-Host "  Moving: $file -> lakehouse-gap-analysis\notebooks\$fileName" -ForegroundColor Cyan
        Move-Item -Path $file -Destination "lakehouse-gap-analysis\notebooks\$fileName" -Force
    } else {
        Write-Host "  Not found (skipping): $file" -ForegroundColor Gray
    }
}

# Clean up temporary files in notebooks if any
Write-Host "`nCleaning up temporary files..." -ForegroundColor Yellow
$tempFiles = @(
    "notebooks\cell3_content.txt",
    "notebooks\~$Metadata_Master_Sheet_v2_2026.xlsx"
)
foreach ($file in $tempFiles) {
    if (Test-Path $file) {
        Write-Host "  Removing: $file" -ForegroundColor Cyan
        Remove-Item -Path $file -Force
    }
}

# Check if notebooks folder is now empty and remove it
if (Test-Path "notebooks") {
    $remaining = Get-ChildItem -Path "notebooks" -Force
    if ($remaining.Count -eq 0) {
        Write-Host "`nRemoving empty notebooks folder..." -ForegroundColor Yellow
        Remove-Item -Path "notebooks" -Force
    } else {
        Write-Host "`nNotebooks folder still contains:" -ForegroundColor Yellow
        $remaining | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Gray }
    }
}

Write-Host "`nReorganization complete!" -ForegroundColor Green
Write-Host "`nNew structure:" -ForegroundColor Cyan
Write-Host "  actuarial-inventory/     - All actuarial inventory files" -ForegroundColor White
Write-Host "  lakehouse-gap-analysis/  - All lakehouse gap analysis files" -ForegroundColor White
Write-Host "  (root)                   - Shared config files (pyproject.toml, etc.)" -ForegroundColor White

