$folderPath = "C:\Users\aymar\Documents\Godot\Projects\ShroomJam2025\shroom-jam-2025\Build_Windows"

# Vérifie si le chemin existe
if (-not (Test-Path -Path $folderPath -PathType Container)) {
    Write-Error "Le chemin spécifié n'existe pas ou n'est pas un dossier."
    exit 1
}

# Exécute la commande butler push
$butlerCommand = "butler push `"$folderPath `" laurenoutang/duckbuster:windows"
Write-Host "Exécution de la commande : $butlerCommand"
Invoke-Expression $butlerCommand