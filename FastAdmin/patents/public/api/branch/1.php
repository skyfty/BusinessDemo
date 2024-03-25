<?php
$servername = "localhost";  // 数据库主机名
$username = "root";  // 数据库用户名
$password = "Fei.1234";  // 数据库密码
$dbname = "patents";  // 数据库名
$conn = new mysqli($servername, $username, $password, $dbname);

// 检查连接是否成功
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}
$token = $_POST['token']; // 获取参数token的值
$register_name = $_POST['register_name']; // 获取参数surface的值

// 根据参数值执行不同的查询语句


// 执行查询语句
$sql = "SELECT register_name,case_time,now_status,agent FROM fa_register Where register_name = '$register_name'";
$result = $conn->query($sql);

// 检查查询结果是否为空
if ($result->num_rows > 0) {
    // 将查询结果存储在数组中
    $names = array();
    $row = $result->fetch_assoc();

    $sql2 = "SELECT agent_name FROM fa_agent Where id =" . $row['agent'];
    $result2 = $conn->query($sql2);
    $row2 = $result2->fetch_assoc();

        $names[] = array(
            'name' => $row['register_name'],
            'time' => $row['case_time'],
            'status' => $row['now_status'],
            'agent' => $row2['agent_name']
        );
    
    
    echo json_encode($names);
} else {
    echo "没有找到任何结果";
}

// 关闭数据库连接
$conn->close();