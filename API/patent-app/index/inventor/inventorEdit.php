<?php  


$servername = "localhost";  // 数据库主机名  
$username = "root";  // 数据库用户名  
$password = "Fei.1234";  // 数据库密码  
$dbname = "patents";  // 数据库名   
  
$conn = new mysqli($servername, $username, $password, $dbname);  
if ($conn->connect_error) {  
    die("连接失败: " . $conn->connect_error);  
}  
  
// 获取传递的参数  
$name = $_POST['name'];  
$english_name = $_POST['english_name'];  
$state = $_POST['state'];
$idcard = $_POST['idcard'];

$sql = "UPDATE fa_inventor SET english_name = ?,state = ?,idcards = ? WHERE inventor_name = ?";
$stmt = $conn->prepare($sql);

if ($stmt) {  
  $stmt->bind_param("ssss", $english_name, $state,$idcard,$name);  
  
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
