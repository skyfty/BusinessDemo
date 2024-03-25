<?php

 $servername = "localhost";  // 数据库主机名  
 $username = "admin";  // 数据库用户名  
 $password = "Fei.1234";  // 数据库密码  
 $dbname = "newpatent"; 
  
 $conn = new mysqli($servername, $username, $password, $dbname);  
 if ($conn->connect_error) {  
     die("连接失败: " . $conn->connect_error);  
 }  
  
 // 获取传递的参数  
 $token = $_POST['token'];
 $register_name = $_POST['register_name'];  //交底书名称
 $case_type = $_POST['case_type'];  //案件类型
 $case_time = $_POST['case_time'];//立案日期
//  $my_case_number = $_POST['my_case_number'];//我方案号
 $other_case_number = $_POST['other_case_number'];//对方案号
 $fast = $_POST['fast'];//是否加快
 $organization = $_POST['organization'];//代理机构
 $department = $_POST['department'];//代理部门
 $agent = $_POST['agent'];//代理人
 $agent_phone = $_POST['agent_phone'];//代理人电话

 $client_name = $_POST['client_name'];//客户名称
 $technology = $_POST['technology'];//技术人员
 $technology_phone = $_POST['technology_phone'];//技术人员电话
 $invent_open = $_POST['invent_open'];//发明是否提前公开
 $copyright_type = $_POST['copyright_type'];//版权类型
 $register_cycle = $_POST['register_cycle'];//立案周期

$xx = $_POST['my_case_number'];
 $aa = '';

 $sql2 = "SELECT id,idcode FROM fa_cms_addoncompany WHERE business_name = '$client_name'";
    $result2 = $conn->query($sql2);
    if ($result2->num_rows > 0) {
        $row2 = $result2->fetch_assoc();
            $client_name = $row2["id"];
$row2['idcode'];
//取最后三位数字
$aa = substr($row2['idcode'],-3);
    } 
//生成两位随机数
$bb = rand(10,99);
//生成当前年月，如2401是24年01月
$cc = date('y').date('m');
//生成最终编号
$my_case_number = $xx.$cc.$bb.$aa.$copyright_type;

$sql3 = "SELECT id FROM fa_cms_addonbranch WHERE branch_name = '$organization'";//代理机构
    $result3 = $conn->query($sql3);
    if ($result3->num_rows > 0) {
        $row3 = $result3->fetch_assoc();
        $organization = $row3["id"];
       
    }
$sql6 = "SELECT id FROM fa_auth_group WHERE name = '$department'";//代理部门
    $result6 = $conn->query($sql6);
    if ($result6->num_rows > 0) {
        $row6 = $result6->fetch_assoc();
        $department = $row6["id"];
       
    }

    $sql4 = "SELECT id FROM fa_admin WHERE nickname = '$agent'";//代理人
    $result4 = $conn->query($sql4);
    if ($result4->num_rows > 0) {
        $row4 = $result4->fetch_assoc();
        $agent = $row4["id"];
       
    }
//代理人电话
$sql7 = "SELECT mobile FROM fa_admin WHERE id = '$agent'";//代理人电话
    $result7 = $conn->query($sql7);
    if ($result7->num_rows > 0) {
        $row7 = $result7->fetch_assoc();
        $agent_phone = $row7["mobile"];
       
    }

    $sql5 = "SELECT id FROM fa_technology WHERE technology_name = '$technology'";//技术人员
    $result5 = $conn->query($sql5);
    if ($result5->num_rows > 0) {
        $row5 = $result5->fetch_assoc();
        $technology = $row5["id"];
       
    }

  
// // 构建插入语句  

   $sql = "INSERT INTO fa_register (register_name, case_type, case_time, my_case_number, other_case_number, fast, organization,department, agent, agent_phone, client_name, technology, technology_phone, invent_open, copyright_type, period) VALUES (?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);

if ($stmt) {
  $stmt->bind_param("ssssssssssssssss", $register_name, $case_type, $case_time, $my_case_number, $other_case_number, $fast, $organization,$department, $agent, $agent_phone, $client_name, $technology, $technology_phone, $invent_open, $copyright_type, $register_cycle);

  try {
    if ($stmt->execute()) {
      $company = [
        "success" => "添加成功",
      ];
    } else {
      $company = [
        "error" => "添加失败1: " . $stmt->error,
      ];
    }
  } catch (Exception $e) {
    $company = [
      "error" => "添加失败2: " . $e->getMessage(),
    ];
  }

  $stmt->close();
} else {
  $company = [
    "error" => "添加失败3: " . $conn->error,
  ];
}
  
 echo json_encode($company);
// // 关闭数据库连接  
 $conn->close();  


?>