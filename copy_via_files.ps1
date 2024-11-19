# Set the root directory where the search should start
$rootDir = "C:\msys64\home\james\qmk_firmware\keyboards\keychron"

# Set the destination directory where the copied files will be placed
$destinationRoot = "C:\Users\james\workspace\keyboards\src\keychron"

# Get all the JSON files in any 'via_json' subdirectory under the root directory
Get-ChildItem -Path $rootDir -Recurse -Filter "*.json" | Where-Object {
    $_.DirectoryName -match "\\via_json$"
} | ForEach-Object {
    # Get the parent directory of the 'via_json' directory
    $parentDirName = Split-Path -Path $_.DirectoryName -Parent | Split-Path -Leaf

    # Create a corresponding directory under the destination root
    $destinationDir = Join-Path -Path $destinationRoot -ChildPath $parentDirName
    if (-Not (Test-Path -Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir
    }

    # Copy the JSON file to the corresponding destination directory
    Copy-Item -Path $_.FullName -Destination $destinationDir
}
