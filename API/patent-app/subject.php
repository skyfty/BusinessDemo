<?php  
$servername = "localhost";  // 数据库主机名  
$username = "root";  // 数据库用户名  
$password = "Fei.1234";  // 数据库密码  
$dbname = "patent";  // 数据库名  
  
// 创建数据库连接  
$conn = new mysqli($servername, $username, $password, $dbname);  
  
// 检查连接是否成功  
if ($conn->connect_error) {  
    die("连接失败: " . $conn->connect_error);  
}  
  
// 执行查询语句  
$sql = "SELECT name FROM fa_company";  
$result = $conn->query($sql);  
  
// 检查查询结果是否为空  
if ($result->num_rows > 0) {  
    // 将查询结果存储在数组中  
    $names = array();  
    while ($row = $result->fetch_assoc()) {  
        $names[] = $row['name'];  
    }  
    // 将数组转换为JSON格式并返回结果  
    echo json_encode($names);  
} else {  
    echo "没有找到任何结果";  
}  
  
// 关闭数据库连接  
$conn->close();  

