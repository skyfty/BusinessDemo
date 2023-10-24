<?php
// 数据库连接配置
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "fastadmin";// 数据库名称

// 创建数据库连接
$conn = new mysqli($servername, $username, $password, $dbname);

// 检查数据库连接是否成功
if ($conn->connect_error) {
    die("数据库连接失败: " . $conn->connect_error);
}

// 检查请求方法是否为POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 获取参数
    $parameter = $_POST['auto'];

    // 准备SQL查询语句
    $sql = "SELECT zh, en FROM translate WHERE value = '$parameter'";

    // 执行查询
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // 获取查询结果的第一行数据
        $row = $result->fetch_assoc();

        // 设置响应头为JSON格式
        header('Content-Type: application/json');

        // 返回JSON格式的数据
        echo json_encode($row);
    } else {
        // 设置响应头为JSON格式
        header('Content-Type: application/json');

        // 返回空数组表示未找到匹配的数据
        echo json_encode(array());
    }
} else {
    // 设置响应状态码为405（方法不允许）
    http_response_code(405);
    echo "Method Not Allowed";
}

// 关闭数据库连接
$conn->close();
?>