# ダミーのフォルダ階層とファイルを作成する関数
function Create-DummyFoldersAndFiles {
    param (
        [string]$basePath,
        [int]$folderCount,
        [int]$fileCount
    )

    # 基本のパスを作成
    New-Item -Path $basePath -ItemType Directory -Force | Out-Null

    # フォルダを作成
    for ($i = 1; $i -le $folderCount; $i++) {
        $folderPath = Join-Path -Path $basePath -ChildPath "Folder$i"
        New-Item -Path $folderPath -ItemType Directory -Force | Out-Null

        # 各フォルダ内にGoファイルを作成
        for ($j = 1; $j -le $fileCount; $j++) {
            $filePathWithComment = Join-Path -Path $folderPath -ChildPath "dummy_file${j}_with_comment.go"
            $filePathNoComment = Join-Path -Path $folderPath -ChildPath "dummy_file${j}_no_comment.go"

            $contentWithComment = @("// dummy_file${j}_with_comment.go", "`npackage main", "`nfunc main() {", "`t// TODO: Implement", "`n}")
            $contentNoComment = @("package main", "`nfunc main() {", "`t// TODO: Implement", "`n}")

            Set-Content -Path $filePathWithComment -Value $contentWithComment
            Set-Content -Path $filePathNoComment -Value $contentNoComment
        }

        # サブフォルダも作成し、Goファイルを作成
        $subFolderPath = Join-Path -Path $folderPath -ChildPath "SubFolder"
        New-Item -Path $subFolderPath -ItemType Directory -Force | Out-Null
        for ($k = 1; $k -le $fileCount; $k++) {
            $filePathWithComment = Join-Path -Path $subFolderPath -ChildPath "dummy_subfile${k}_with_comment.go"
            $filePathNoComment = Join-Path -Path $subFolderPath -ChildPath "dummy_subfile${k}_no_comment.go"

            $contentWithComment = @("// dummy_subfile${k}_with_comment.go", "`npackage main", "`nfunc main() {", "`t// TODO: Implement", "`n}")
            $contentNoComment = @("package main", "`nfunc main() {", "`t// TODO: Implement", "`n}")

            Set-Content -Path $filePathWithComment -Value $contentWithComment
            Set-Content -Path $filePathNoComment -Value $contentNoComment
        }
    }
}

# メインスクリプト
$basePath = "DummyProject"
$folderCount = 3
$fileCount = 2

# ダミーのフォルダとファイルを作成
Create-DummyFoldersAndFiles -basePath $basePath -folderCount $folderCount -fileCount $fileCount

Write-Output "Dummy folders and Go files have been created successfully."