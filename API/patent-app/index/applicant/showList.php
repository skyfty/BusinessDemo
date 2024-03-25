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
$surface = $_POST['surface']; // 获取参数surface的值

// 根据参数值执行不同的查询语句
if ($surface === 'proposer') {
    $tableName = 'fa_proposer';
    $type = '申请人姓名';
    $name = 'proposer_name';
} elseif ($surface === 'inventor') {
    $tableName = 'fa_inventor';
    $type = '发明人姓名';
    $name = 'inventor_name';
} else {
    die("无效的参数值");
}

// 执行查询语句
$sql = "SELECT $name FROM $tableName";
$result = $conn->query($sql);

// 检查查询结果是否为空
if ($result->num_rows > 0) {
    // 将查询结果存储在数组中
    $names = array();
    while ($row = $result->fetch_assoc()) {
        $names[] = array(
            'name' => $row[$name],
            'type' => $type
        );
    }
    
    echo json_encode($names);
} else {
    echo "没有找到任何结果";
}

// 关闭数据库连接
$conn->close();