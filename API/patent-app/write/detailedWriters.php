<?php
$servername = "localhost";  // 数据库主机名
$username = "admin";  // 数据库用户名
$password = "Fei.1234";  // 数据库密码
$dbname = "newpatent";  // 数据库名
$conn = new mysqli($servername, $username, $password, $dbname);

// 检查连接是否成功
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}

$name = $_POST['name']; // 获取参数name的值
$token = $_POST['token']; // 获取参数token的值
// 执行查询语句
$sql = "SELECT * FROM fa_patentwrites WHERE write_name='$name'";
$result = $conn->query($sql);

// 检查查询结果是否为空
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();  
    $names[] = array(
        'name' => $row['write_name'],
        'writeUrl' => $row['words'],
        'now_status' => $row['now_status'],
        'idcode' => $row['idcode'],
    );  

    echo json_encode($names);
} else {
    echo "没有找到任何结果";
}

// 关闭数据库连接
$conn->close();