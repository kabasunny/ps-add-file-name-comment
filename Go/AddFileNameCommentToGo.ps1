param (
    [string]$folderPath
)

function Add-FileNameComment {
    param (
        [string]$filePath
    )

    # ファイル名を取得
    $fileName = [System.IO.Path]::GetFileName($filePath)
    $comment = "// $fileName"

    # ファイルの最初の行を取得
    $firstLine = Get-Content -Path $filePath -TotalCount 1

    # 既にコメントが存在しない場合のみ追記
    if ($firstLine -notmatch "^// ") {
        # コメントをファイルの最初に追記
        $fileContent = Get-Content -Path $filePath
        $newContent = @($comment) + $fileContent
        Set-Content -Path $filePath -Value $newContent
        Write-Output "Added comment to $filePath"
    }
}

# 指定されたフォルダ内および子フォルダすべてを再帰的に探索
Get-ChildItem -Path $folderPath -Recurse -Filter "*.go" | ForEach-Object {
    Add-FileNameComment -filePath $_.FullName
}

Write-Output "Process completed."
