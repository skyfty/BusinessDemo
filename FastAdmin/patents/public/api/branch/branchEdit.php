<?php  


$servername = "localhost";  // 数据库主机名  
$username = "Fei";  // 数据库用户名  
$password = "Fei.1234";  // 数据库密码  
$dbname = "patents";  // 数据库名   
  
$conn = new mysqli($servername, $username, $password, $dbname);  
if ($conn->connect_error) {  
    die("连接失败: " . $conn->connect_error);  
}  
  
// 获取传递的参数  
$branch_name = $_POST['branch_name'];//名称  
$content = $_POST['content'];  //内容
$telephone = $_POST['telephone'];//电话
$dianhua = $_POST['dianhua'];//固话
$idcode = $_POST['idcode'];//代号
$branch_image = $_POST['branch_image'];//图片
$address = $_POST['address'];//地址
$area = $_POST['area'];//详细地址

$sql = "UPDATE fa_cms_addonbranch SET content = ?,telephone = ?,dianhua = ?,idcode = ?,branch_image = ?,address = ?,area = ? WHERE branch_name = ?";
$stmt = $conn->prepare($sql);//预处理SQL语句

if ($stmt) {  
  $stmt->bind_param("ssssssss", $content,$telephone,$dianhua,$idcode,$branch_image,$address,$area,$branch_name);  
  
    if ($stmt->execute()) {  
        $company = [
            "success" => "更新成功",
        ];
       
    } else {  
        $company = [
            "error" => "更新失败: " . $stmt->error,
            "tima" => "失败",
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
