<?php



// // 接收前端参数  
// $name = $_GET['name'];  
  
  
// // // 数据库连接信息  
// $servername = "localhost";  // 数据库主机名  
// $username = "dmf";  // 数据库用户名  
// $password = "Fei.1234";  // 数据库密码  
// $dbname = "patent";  // 数据库名   
  
// // 创建数据库连接  
// $conn = new mysqli($servername, $username, $password, $dbname);  
// if ($conn->connect_error) {  
//     die("连接失败: " . $conn->connect_error);  
// }  
  
// // 查询语句  
// $sql = "SELECT idcode, status, type, phone FROM fa_company WHERE name = '$name'";  
// $result = $conn->query($sql);  
// if ($result->num_rows > 0) {  
//     while($row = $result->fetch_assoc()) {  
//         $idcode = $row["idcode"];  
//         $status = $row["status"];  
//         $type = $row["type"];  
//         $phone = $row["phone"];  
//         $response = "idcode: $idcode, status: $status, type: $type, phone: $phone";  
//     }  
// } else {  
//     $response = "未找到匹配的数据";  
// }  
// echo json_encode($response); // 返回数据给前端（JSON格式）  
// $conn->close(); // 关闭数据库连接  

// 接收前端参数  
$name = $_POST['name'];  
  
// 数据库连接信息  
$servername = "localhost";  // 数据库主机名  
$username = "root";  // 数据库用户名  
$password = "Fei.1234";  // 数据库密码  
$dbname = "patent";  // 数据库名   
  
// 创建数据库连接  
$conn = new mysqli($servername, $username, $password, $dbname);  
if ($conn->connect_error) {  
    die("连接失败: " . $conn->connect_error);  
}  
  
// 查询语句  
$sql = "SELECT name,idcard,sex,educational,service_talents,scientist FROM fa_persion WHERE name = '$name'";  
$result = $conn->query($sql);  
$response_array = [];  
  
if ($result->num_rows > 0) {    
    while($row = $result->fetch_assoc()) {    
        $company = [  
            "name" => $row["name"],  
            "idcard" => $row["idcard"],    
            
            "sex" => $row["sex"],    
            "educational" => $row["educational"],
            "service_talents" => $row["service_talents"],
            "scientist" => $row["scientist"],
            
            // 添加其他需要的字段...  
        ];  
          
        array_push($response_array, $company);  
    }    
} else {    
    $response_array = "未找到匹配的数据";    
}    
  
echo json_encode($response_array); // 返回数据给前端（JSON格式）    
$conn->close(); // 关闭数据库连接
