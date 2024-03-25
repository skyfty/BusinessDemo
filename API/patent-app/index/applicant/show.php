<?php

$name = $_POST['name'];
$surface = $_POST['surface'];

$servername = "localhost";  // 数据库主机名  
$username = "root";  // 数据库用户名  
$password = "Fei.1234";  // 数据库密码  
$dbname = "patents";  // 数据库名   

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}
if ($surface == 'proposer') {


    $sql = "SELECT proposer_name,english_name,user_number,applicant_type,certificate_type,id_number,nationality_region,place_residence,provience,street,postal_code,email,applicant_telephone,fee_reduction_request,pre_examination_record,general_committee_record FROM fa_proposer WHERE proposer_name = '$name'";

    $result = $conn->query($sql);
    $response_array = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $company = [
                "name" => $row["proposer_name"],
                "english_name" => $row["english_name"],
                "user_number" => $row["user_number"],
                "applicant_type" => $row["applicant_type"],
                "certificate_type" => $row["certificate_type"],
                "id_number" => $row["id_number"],
                "nationality_region" => $row["nationality_region"],
                "place_residence" => $row["place_residence"],
                "provience" => $row["provience"],
            
                "street" => $row["street"],
                "postal_code" => $row["postal_code"],
                "email" => $row["email"],
                "applicant_telephone" => $row["applicant_telephone"],
                "fee_reduction_request" => $row["fee_reduction_request"],
                "pre_examination_record" => $row["pre_examination_record"],
                "general_committee_record" => $row["general_committee_record"],

            ];

            array_push($response_array, $company);
        }
    } else {
        $response_array = "未找到匹配的数据";
    }

} elseif ($surface == 'inventor') {
    $sql = "SELECT inventor_name,english_name,state,idcards FROM fa_inventor WHERE inventor_name = '$name'";

    $result = $conn->query($sql);
    $response_array = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $company = [
                "name" => $row["inventor_name"],
                "english_name" => $row["english_name"],
                "state" => $row["state"],
                "idcard" => $row["idcards"],
            ];

            array_push($response_array, $company);
        }
    } else {
        $response_array = "未找到匹配的数据";
    }
}


echo json_encode($response_array); // 返回数据给前端（JSON格式）    
$conn->close(); // 关闭数据库连接
