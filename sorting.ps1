# power shell
# 设置哈希文件路径（当前目录）
$hashFile = ".\310822771_hashes.txt"

# 读取哈希列表，去除 .0 后缀
$hashList = Get-Content $hashFile | ForEach-Object { $_ -replace '\.0$', '' }

# 获取当前文件夹中的所有文件（仅文件，不含目录）
$files = Get-ChildItem -File

# 计数器
$counter = 0

# 按列表顺序查找并重命名
foreach ($hash in $hashList) {
    $matchedFile = $files | Where-Object { $_.Name -match $hash }
    if ($matchedFile) {
        $counter++
        $newName = "{0:D3}_{1}" -f $counter, $matchedFile.Name
        Rename-Item -Path $matchedFile.FullName -NewName $newName
        Write-Host "已重命名: $($matchedFile.Name) -> $newName"
    } else {
        Write-Warning "未找到哈希: $hash"
    }
}

Write-Host "完成！共重命名 $counter 个文件。"
