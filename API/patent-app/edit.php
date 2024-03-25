<?php  
// // 连接到数据库  
// $servername = "localhost";  // 数据库主机名  
// $username = "dmf";  // 数据库用户名  
// $password = "Fei.1234";  // 数据库密码  
// $dbname = "patent";  // 数据库名   
  
// $conn = new mysqli($servername, $username, $password, $dbname);  
// if ($conn->connect_error) {  
//     die("连接失败: " . $conn->connect_error);  
// }  
  
// // 获取传递的参数  
// $name = $_POST['name'];  
// $chinese_name = $_POST['chinese_name'];  
// $english_name = $_POST['english_name'];  
// $brand = $_POST['brand'];
// $signed = $_POST['signed'];
// $industry_model_id = $_POST['industry_model_id'];
// $phone = $_POST['phone'];
// $telephone = $_POST['telephone'];
// $registerdate = $_POST['registerdate'];
// $registerfund = $_POST['registerfund'];
// $credit_code = $_POST['credit_code'];
// $type = $_POST['type'];
// $acreage = $_POST['acreage'];
// // $unauthorized_appearance_patent = $_POST['unauthorized_appearance_patent'];
// // $appearance_patent_granted = $_POST['appearance_patent_granted'];
// // $unauthorized_invention_patent = $_POST['unauthorized_invention_patent'];
// // $authorize_patent_count = $_POST['authorize_patent_count'];
// // $not_authorize_patent_count = $_POST['not_authorize_patent_count'];
// // $authorize_new_patent_count = $_POST['authorize_new_patent_count'];
// // $register_bookmaking_count = $_POST['register_bookmaking_count'];
// // $apply_bookmaking_count = $_POST['apply_bookmaking_count'];
// // $aptitude_state = $_POST['aptitude_state'];
// $business_licence = $_POST['business_licence'];
// $scale = $_POST['scale'];
// $hightech = $_POST['hightech'];
// // $trademark_cnt = $_POST['trademark_cnt'];
// $ms_enterprises = $_POST['ms_enterprises'];
// $enrolladdress = $_POST['enrolladdress'];
// $business_licence_code = $_POST['business_licence_code'];

// // 构建更新语句  
// // chinese_name = ?, english_name = ?,brand =?,signed =?,industry_model_id =?,phone =?,telephone =?,registerdate =?,registerfund =?,credit_code =?,type =?,acreage =?,unauthorized_appearance_patent =?,appearance_patent_granted =?,unauthorized_invention_patent =?,authorize_patent_count =?,not_authorize_patent_count =?,authorize_new_patent_count =?,register_bookmaking_count =?,apply_bookmaking_count =?,aptitude_state =?,business_licence =?,scale =?,hightech =?,trademark_cnt =?,ms_enterprises =?,enrolladdress =?,business_licence_code =?   WHERE name = ?";  
// $sql = "UPDATE fa_company SET chinese_name = ?, english_name = ?,brand =?,signed =?,industry_model_id =?,phone =?,telephone =?,registerdate =?,registerfund =?,credit_code =?,type =?,acreage =?,business_licence =?,scale =?,hightech =?,ms_enterprises =?,enrolladdress =?,business_licence_code =?   WHERE name = ?";  
// $stmt = $conn->prepare($sql);  
  
// // 绑定参数并执行更新  
// if ($stmt) {  
//     // $stmt->bind_param("sssssssssssssssssssssssssssss", $chinese_name, $english_name, $name, $brand, $signed, $industry_model_id, $phone, $telephone, $registerdate, $registerfund, $credit_code, $type, $acreage, $unauthorized_appearance_patent, $appearance_patent_granted, $unauthorized_invention_patent, $authorize_patent_count, $not_authorize_patent_count, $authorize_new_patent_count, $register_bookmaking_count, $apply_bookmaking_count, $aptitude_state, $business_licence, $scale, $hightech, $trademark_cnt, $ms_enterprises, $enrolladdress, $business_licence_code);  
//     $stmt->bind_param("sssssssssssssssssss", $chinese_name, $english_name, $name, $brand, $signed, $industry_model_id, $phone, $telephone, $registerdate, $registerfund, $credit_code, $type, $acreage,  $business_licence, $scale, $hightech,$ms_enterprises, $enrolladdress, $business_licence_code);  
  
//     if ($stmt->execute()) {  
//         $company = [
//             "success" => "更新成功",
//         ];
       
//     } else {  
//         $company = [
//             "error" => "更新失败: " . $stmt->error,
//         ];
       
//     }  
//     $stmt->close();  
// } else {  
//     $company = [
//         "error" => "更新失败: " . $conn->error,
//     ];
    
// }  
// echo json_encode($company);
  
// // 关闭数据库连接  
// $conn->close();  
// 连接到数据库  
// $brand = $_POST['brand'];
// $signed = $_POST['signed'];
// $industry_model_id = $_POST['industry_model_id'];
// $phone = $_POST['phone'];
// $telephone = $_POST['telephone'];
// $registerdate = $_POST['registerdate'];
// $registerfund = $_POST['registerfund'];
// $credit_code = $_POST['credit_code'];
// $type = $_POST['type'];
// $acreage = $_POST['acreage'];

// $business_licence = $_POST['business_licence'];
// $scale = $_POST['scale'];
// $hightech = $_POST['hightech'];

// $ms_enterprises = $_POST['ms_enterprises'];
// $enrolladdress = $_POST['enrolladdress'];
// $business_licence_code = $_POST['business_licence_code'];
// ,brand =?,signed =?,industry_model_id =?,phone =?,telephone =?,registerdate =?,registerfund =?,credit_code =?,type =?,acreage =?,business_licence =?,scale =?,hightech =?,ms_enterprises =?,enrolladdress =?,business_licence_code =?  

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
$chinese_name = $_POST['chinese_name'];  
$english_name = $_POST['english_name'];  
$brand = $_POST['brand'];
$signed = $_POST['signed'];
$industry_model_id = $_POST['industry_model_id'];
$phone = $_POST['phone'];
$telephone = $_POST['telephone'];
$registerdate = $_POST['registerdate'];
$registerfund = $_POST['registerfund'];
$credit_code = $_POST['credit_code'];
$type = $_POST['type'];
$acreage = $_POST['acreage'];

$business_licence = $_POST['business_licence'];
$scale = $_POST['scale'];
$hightech = $_POST['hightech'];

$ms_enterprises = $_POST['ms_enterprises'];
$enrolladdress = $_POST['enrolladdress'];
$business_licence_code = $_POST['business_licence_code'];
$sql = "UPDATE fa_company SET chinese_name = ?, english_name = ? ,brand =?,signed =?,industry_model_id =?,phone =?,telephone =?,registerdate =?,registerfund =?,credit_code =?,type =?,acreage =?,business_licence =?,scale =?,hightech =?,ms_enterprises =?,enrolladdress =?,business_licence_code =? WHERE name = ?";
$stmt = $conn->prepare($sql);

if ($stmt) {  
  $stmt->bind_param("sssssssssssssssssss", $chinese_name, $english_name, $brand, $signed, $industry_model_id, $phone, $telephone, $registerdate, $registerfund, $credit_code, $type, $acreage,  $business_licence, $scale, $hightech,$ms_enterprises, $enrolladdress, $business_licence_code,$name);  
  
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
// 绑定参数并执行更新  
//  $brand, $signed, $industry_model_id, $phone, $telephone, $registerdate, $registerfund, $credit_code, $type, $acreage,  $business_licence, $scale, $hightech,$ms_enterprises, $enrolladdress, $business_licence_code