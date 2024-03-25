<?php  
// 连接到数据库  
$servername = "localhost";  // 数据库主机名  
$username = "root";  // 数据库用户名  
$password = "Fei.1234";  // 数据库密码  
$dbname = "patent";  // 数据库名   
  
$conn = new mysqli($servername, $username, $password, $dbname);  
if ($conn->connect_error) {  
    die("连接失败: " . $conn->connect_error);  
}  
  
// 获取传递的参数  
$name = $_POST['name'];  
$idcard = $_POST['idcard'];  
$sex = $_POST['sex'];  
$educational = $_POST['educational'];  
$service_talents = $_POST['service_talents'];  
$scientist = $_POST['scientist'];  


// 构建更新语句  
$sql = "UPDATE fa_persion SET idcard =?,sex =?,educational =?,service_talents =?,scientist =?  WHERE name = ?";  
$stmt = $conn->prepare($sql);  
  
// 绑定参数并执行更新  
if ($stmt) {  
    $stmt->bind_param("sssss", $idcard,$sex,$educational,$service_talents,$scientist);  
    if ($stmt->execute()) {  
        $company = [
            "success" => "更新成功",
        ];
       
    } else {  
        $company = [
            "error" => "更新失败: " . $stmt->error,
        ];
       
    }  
    $stmt->close();  
} else {  
    $company = [
        "error" => "更新失败: " . $conn->error,
    ];
    
}  
echo json_encode($company);
  
// 关闭数据库连接  
$conn->close();  
