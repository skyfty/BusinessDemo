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
$user_number = $_POST['user_number'];
$applicant_type = $_POST['applicant_type'];
$certificate_type = $_POST['certificate_type'];
$id_number = $_POST['id_number'];
$nationality_region = $_POST['nationality_region'];
$place_residence = $_POST['place_residence'];
$provience = $_POST['provience'];
//$city = $_POST['city'];
$street = $_POST['street'];
$postal_code = $_POST['postal_code'];
$email = $_POST['email'];
$applicant_telephone = $_POST['applicant_telephone'];
$fee_reduction_request = $_POST['fee_reduction_request'];
$pre_examination_record = $_POST['pre_examination_record'];
$general_committee_record = $_POST['general_committee_record'];


$sql = "UPDATE fa_proposer SET english_name = ?,user_number = ?,applicant_type = ?,certificate_type = ?,id_number = ?,nationality_region =?,place_residence =?,provience = ?,street =?,postal_code =?,email =?,applicant_telephone =?,fee_reduction_request =?,pre_examination_record = ?,general_committee_record =? WHERE proposer_name = ?";
$stmt = $conn->prepare($sql);

if ($stmt) {  
  $stmt->bind_param("ssssssssssssssss", $english_name,$user_number,$applicant_type,$certificate_type,$id_number,$nationality_region,$place_residence,$provience,$street,$postal_code,$email,$applicant_telephone,$fee_reduction_request,$pre_examination_record,$general_committee_record,$name);  
  
    if ($stmt->execute()) {  
        $company = [
            "success" => "更新成功",
        ];
       
    } else {  
        $company = [
            "error" => "更新失败1: " . $stmt->error,
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
