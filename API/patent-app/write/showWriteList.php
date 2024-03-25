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

// 执行查询语句
$sql = "SELECT id FROM fa_admin WHERE username='$name'";
$result = $conn->query($sql);

// 检查查询结果是否为空
if ($result->num_rows > 0) {
    // 将查询结果存储在数组中
    $names = array();
    
     
    while ($row = $result->fetch_assoc()) {
      
         $agentId = $row['id'];
        
        // 查询fa_register_name表中与agent字段值相同的记录的register_name值
        $registerNamesSql = "SELECT * FROM fa_patentwrites WHERE agent='$agentId'";
        $registerNamesResult = $conn->query($registerNamesSql);
        
        if ($registerNamesResult->num_rows > 0) {
            while ($registerNamesRow = $registerNamesResult->fetch_assoc()) {
            	
                $names[] = array(
                    'name' => $registerNamesRow['write_name'],
                    'type' => $type,
                    'status' =>$registerNamesRow['now_status'],
                );
            }
        }else{
        
        	}
        
    }
    
    echo json_encode($names);
} else {
    echo "没有找到任何结果";
}

// 关闭数据库连接
$conn->close();