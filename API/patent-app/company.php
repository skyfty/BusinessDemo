<?php

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
// $sql = "SELECT name,chinese_name,english_name,brand,signed,industry_model_id,phone,telephone,registerdate,registerfund,credit_code,type,acreage,unauthorized_appearance_patent,appearance_patent_granted,unauthorized_invention_patent,authorize_patent_count,not_authorize_patent_count,authorize_new_patent_count,register_bookmaking_count,apply_bookmaking_count,aptitude_state,business_licence,scale,hightech,trademark_cnt,ms_enterprises,enrolladdress,business_licence_code FROM fa_company WHERE name = '$name'";  
$sql = "SELECT name,chinese_name,english_name,brand,signed,industry_model_id,phone,telephone,registerdate,registerfund,credit_code,type,acreage,unauthorized_appearance_patent,appearance_patent_granted,unauthorized_invention_patent,authorize_patent_count,not_authorize_patent_count,authorize_new_patent_count,register_bookmaking_count,apply_bookmaking_count,aptitude_state,business_licence,scale,hightech,trademark_cnt,ms_enterprises,enrolladdress,business_licence_code FROM fa_company WHERE name = '$name'";  

$result = $conn->query($sql);  
$response_array = [];  
  
if ($result->num_rows > 0) {    
    while($row = $result->fetch_assoc()) {    
        $company = [  
            "name" => $row["name"],  
            "chinese_name" => $row["chinese_name"],    
            "english_name" => $row["english_name"],    
            "brand" => $row["brand"],    
            "signed" => $row["signed"],
            "industry_model_id" => $row["industry_model_id"], 
            "phone" => $row["phone"],
            "telephone" => $row["telephone"],
            "registerdate" => $row["registerdate"],
            "registerfund" => $row["registerfund"],
            "credit_code" => $row["credit_code"],
            "type" => $row["type"],
            "acreage" => $row["acreage"],
            "unauthorized_appearance_patent" => $row["unauthorized_appearance_patent"],
            "appearance_patent_granted" => $row["appearance_patent_granted"],
            "unauthorized_invention_patent" => $row["unauthorized_invention_patent"],
            "authorize_patent_count" => $row["authorize_patent_count"],
            "not_authorize_patent_count" => $row["not_authorize_patent_count"],
            "authorize_new_patent_count" => $row["authorize_new_patent_count"],
            "register_bookmaking_count" => $row["register_bookmaking_count"],
            "apply_bookmaking_count" => $row["apply_bookmaking_count"],
            "aptitude_state" => $row["aptitude_state"],
            "business_licence" => $row["business_licence"],
            "scale" => $row["scale"],
            "hightech" => $row["hightech"],
            "trademark_cnt" => $row["trademark_cnt"],
            "ms_enterprises" => $row["ms_enterprises"],
            "enrolladdress" => $row["enrolladdress"],
            "business_licence_code" => $row["business_licence_code"],
            // 添加其他需要的字段...  
        ];  
          
        array_push($response_array, $company);  
    }    
} else {    
    $response_array = "未找到匹配的数据";    
}    
  
echo json_encode($response_array); // 返回数据给前端（JSON格式）    
$conn->close(); // 关闭数据库连接
