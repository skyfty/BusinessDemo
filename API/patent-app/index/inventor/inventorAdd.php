<?php  
// 连接到数据库  
$servername = "localhost";  // 数据库主机名  
$username = "root";  // 数据库用户名  
$password = "Fei.1234";  // 数据库密码  
$dbname = "patents"; 
  
$conn = new mysqli($servername, $username, $password, $dbname);  
if ($conn->connect_error) {  
    die("连接失败: " . $conn->connect_error);  
}  
  
// 获取传递的参数  
$name = $_POST['name'];  
$english_name = $_POST['english_name'];  
$state = $_POST['state'];
$idcard = $_POST['idcard'];


  
// 构建插入语句  
$sql = "INSERT INTO  fa_inventor (inventor_name,english_name,state,idcards) VALUES (?, ?, ?,?)";  
$stmt = $conn->prepare($sql);  
  
// 绑定参数并执行插入操作  
if ($stmt) {  
    $stmt->bind_param("ssss", $name, $english_name,$state,$idcard,);  
    if ($stmt->execute()) {  
        $company = [
            "success" => "添加成功",
        ]; 
    } else {  
        $company = [
            "error" => "添加失败: " . $stmt->error,
        ];
    }  
    $stmt->close();  
} else {  
    $company = [
        "error" => "添加失败: " . $conn->error,
    ];
          
}  
  
echo json_encode($company);
// 关闭数据库连接  
$conn->close();  