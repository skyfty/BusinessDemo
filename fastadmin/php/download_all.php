
<?php
if (isset($_POST['downloadAll']) && isset($_POST['files'])) {
    $zip = new ZipArchive();
    $zipFileName = 'translated_files_' . time() . '.zip';

    if ($zip->open($zipFileName, ZipArchive::CREATE | ZipArchive::OVERWRITE) === true) {
        $files = $_POST['files'];
    
        foreach ($files as $file) {
            if (file_exists($file)) {
                $zip->addFile($file, basename($file));
            } else {
                echo '文件不存在：' . $file;
            }
        }
    
        $zip->close();
    
        // 删除临时ZIP文件
register_shutdown_function(function () use ($zipFileName) {
    if (file_exists($zipFileName)) {
        unlink($zipFileName);
    }
});

// 提供下载链接
header('Content-Type: application/zip');
header('Content-Disposition: attachment; filename=' . $zipFileName);
header('Content-Length: ' . filesize($zipFileName));
readfile($zipFileName);
exit;
    } else {
        echo '创建ZIP文件失败。';
    }
} else {
    echo '无效的下载请求。';
}
?>