<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 检查是否有上传的文件
    if ($_FILES['file']['error'] === UPLOAD_ERR_OK) {
        $tempFile = $_FILES['file']['tmp_name'];
        $targetPath = '../'; // 保存录音文件的目录

        // 生成一个唯一的文件名
        $fileName = uniqid('recording_') . '.wav';

        // 将临时文件移动到目标路径
        if (move_uploaded_file($tempFile, $targetPath . $fileName)) {
            // 文件移动成功，可以在此处进行其他处理，如数据库插入等
            // 返回录音文件的URL或其他数据给前端
            $response = [
                'success' => true,
                'recording_url' => 'https://81.141.186.125/testyuyin/' . $fileName,
            ];
            echo json_encode($response);
        } else {
            // 文件移动失败
            $response = [
                'success' => false,
                'error' => 'Failed to move the uploaded file.',
            ];
            echo json_encode($response);
        }
    } else {
        // 文件上传失败
        $response = [
            'success' => false,
            'error' => 'File upload failed.',
        ];
        echo json_encode($response);
    }
} else {
    // 不支持的请求方法
    $response = [
        'success' => false,
        'error' => 'Unsupported request method.',
    ];
    echo json_encode($response);
}