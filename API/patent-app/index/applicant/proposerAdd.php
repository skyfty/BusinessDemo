<?php  

//// 连接到数据库
//$servername = "localhost";  // 数据库主机名
//$username = "root";  // 数据库用户名
//$password = "Fei.1234";  // 数据库密码
//$dbname = "patents";
//
//$conn = new mysqli($servername, $username, $password, $dbname);
//if ($conn->connect_error) {
//    die("连接失败: " . $conn->connect_error);
//}
//
//// 获取传递的参数
//$name = $_POST['name'];
//$english_name = $_POST['english_name'];
//$user_number = $_POST['user_number'];
//$applicant_type = $_POST['applicant_type'];
//$certificate_type = $_POST['certificate_type'];
//$id_number = $_POST['id_number'];
//$nationality_region = $_POST['nationality_region'];
//$place_residence = $_POST['place_residence'];
//$provience = $_POST['provience'];
////$city = $_POST['city'];
//$street = $_POST['street'];
//$postal_code = $_POST['postal_code'];
//$email = $_POST['email'];
//$applicant_telephone = $_POST['applicant_telephone'];
//$fee_reduction_request = $_POST['fee_reduction_request'];
//$pre_examination_record = $_POST['pre_examination_record'];
//$general_committee_record = $_POST['general_committee_record'];
//
////// 检查是否有文件上传
////if (isset($_FILES['file'])) {
////    $file = $_FILES['file'];
////    $fileName = $file['name'];
////    $fileType = $file['type'];
////    $fileTmpName = $file['tmp_name'];
////    $fileError = $file['error'];
////    $fileSize = $file['size'];
//
//    // 检查文件上传是否成功
////    if ($fileError === UPLOAD_ERR_OK) {
////        // 检查文件类型是否允许上传
////        $allowedExtensions = ['jpg', 'png', 'pdf', 'docx'];
////        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
////        if (in_array($fileExtension, $allowedExtensions)) {
////            // 指定保存文件的目录
////            $uploadDir = '/path/to/upload/directory/';
////
////            // 生成新的文件名，以防止文件名冲突
////            $newFileName = uniqid() . '.' . $fileExtension;
////
////            // 移动上传的文件到指定目录
////            if (move_uploaded_file($fileTmpName, $uploadDir . $newFileName)) {
//                // 构建插入语句
//                $sql = "INSERT INTO fa_proposer (proposer_name, english_name, user_number, applicant_type, certificate_type, id_number, nationality_region, place_residence, provience, street, postal_code, email, applicant_telephone, fee_reduction_request, pre_examination_record, general_committee_record, attachment) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?, ?, ?)";
//                $stmt = $conn->prepare($sql);
//
//                // 绑定参数并执行插入操作
//                if ($stmt) {
//                    $stmt->bind_param("sssssssssssssssss", $name, $english_name, $user_number, $applicant_type, $certificate_type, $id_number, $nationality_region, $place_residence, $provience,  $street, $postal_code, $email, $applicant_telephone, $fee_reduction_request, $pre_examination_record, $general_committee_record, $uploadDir . $newFileName);
//                    if ($stmt->execute()) {
//                        $response = [
//                            "success" => "添加成功",
//                        ];
//                    } else {
//                        $response = [
//                            "error" => "添加失败: " . $stmt->error,
//                        ];
//                    }
//                    $stmt->close();
//                } else {
//                    $response = [
//                        "error" => "添加失败: " . $conn->error,
//                    ];
//                }
////            } else {
////                $response = [
////                    "error" => "文件上传失败。",
////                ];
////            }
////        } else {
////            $response = [
////                "error" => "不允许上传此类型的文件。",
////            ];
////        }
////    } else {
////        $response = [
////            "error" => "文件上传过程中出错：" . $fileError,
////        ];
////    }
////} else {
////    $response = [
////        "error" => "未找到上传的文件。",
////    ];
////}
//
//// 返回响应
//header('Content-Type: application/json');
//echo json_encode($response);
//
//// 关闭数据库连接
//$conn->close();







// // 连接到数据库  
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
 $user_number = $_POST['user_number'];
 $applicant_type = $_POST['applicant_type'];
 $certificate_type = $_POST['certificate_type'];
 $id_number = $_POST['id_number'];
 $nationality_region = $_POST['nationality_region'];
 $place_residence = $_POST['place_residence'];
 $provience = $_POST['provience'];
// $city = $_POST['city'];
 $street = $_POST['street'];
 $postal_code = $_POST['postal_code'];
 $email = $_POST['email'];
 $applicant_telephone = $_POST['applicant_telephone'];
 $fee_reduction_request = $_POST['fee_reduction_request'];
 $pre_examination_record = $_POST['pre_examination_record'];
 $general_committee_record = $_POST['general_committee_record'];



  
// // 构建插入语句  
 $sql = "INSERT INTO  fa_proposer (proposer_name,english_name,user_number,applicant_type,certificate_type,id_number,nationality_region,place_residence,provience,street,postal_code,email,applicant_telephone,fee_reduction_request,pre_examination_record,general_committee_record) VALUES ( ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";  
 $stmt = $conn->prepare($sql);  
  
// // 绑定参数并执行插入操作  
 if ($stmt) {  
    $stmt->bind_param("ssssssssssssssss", $name, $english_name,$user_number,$applicant_type,$certificate_type,$id_number,$nationality_region,$place_residence,$provience,$street,$postal_code,$email,$applicant_telephone,$fee_reduction_request,$pre_examination_record,$general_committee_record);  
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
// // 关闭数据库连接  
 $conn->close();  