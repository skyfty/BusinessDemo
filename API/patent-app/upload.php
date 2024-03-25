<?php

if ($_FILES['file'] && isset($_POST['name'])) {
    $file = $_FILES['file'];
    $name = $_POST['name'];
    $targetDir = '../patent-app/';

    // 生成唯一的文件名
    $fileName = uniqid() . '_' . basename($file['name']);

    // 将文件移动到目标文件夹
    $targetPath = $targetDir . $fileName;
    move_uploaded_file($file['tmp_name'], $targetPath);

    // 连接数据库
    $servername = "localhost";
    $username = "root";
    $password = "Fei.1234";
    $dbname = "patent";
    $conn = new mysqli($servername, $username, $password, $dbname);
    if ($conn->connect_error) {
        die("连接失败: " . $conn->connect_error);
    }

    // 检查数据库中是否已存在相同名称的记录
    $checkQuery = "SELECT * FROM fa_company WHERE name = ?";
    $checkStmt = $conn->prepare($checkQuery);
    $checkStmt->bind_param("s", $name);
    $checkStmt->execute();
    $result = $checkStmt->get_result();

    if ($result->num_rows > 0) {
        // 如果存在匹配的记录，则更新数据库记录
        $sql = "UPDATE fa_company SET brand = ? WHERE name = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $fileName, $name);
        if ($stmt->execute()) {
            // 更新成功
            $response = [
                'name' => $fileName,
                'message' => '文件上传成功，并更新数据库记录'
            ];
        } else {
            // 更新失败
            $response = [
                'error' => '文件上传成功，但更新数据库记录失败'
            ];
        }
    } else {
        // 如果不存在匹配的记录，则创建新的数据库记录
        $sql = "INSERT INTO fa_company (name, brand) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $name, $fileName);
        if ($stmt->execute()) {
            // 创建成功
            $response = [
                'name' => $fileName,
                'message' => '文件上传成功，并创建新的数据库记录'
            ];
        } else {
            // 创建失败
            $response = [
                'error' => '文件上传成功，但创建新的数据库记录失败'
            ];
        }
    }

    // 关闭数据库连接
    $stmt->close();
    $conn->close();

    // 返回 JSON 响应
    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    // 如果请求中没有文件或 name 参数，则返回错误响应
    $response = [
        'error' => 'No file uploaded or "name" parameter missing'
    ];

    // 返回 JSON 响应
    header('Content-Type: application/json');
    echo json_encode($response);
}