<?php

// 获取请求参数
$token = $_POST['token'];
$name = $_POST['name'];
$status = $_POST['status'];

// 连接数据库
$servername = "localhost";  // 数据库主机名
$username = "admin";  // 数据库用户名
$password = "Fei.1234";  // 数据库密码
$dbname = "newpatent";  // 数据库名
$conn = new mysqli($servername, $username, $password, $dbname);
$aStatus ='代理人已确认';
$bStatus ='撰写中';
// 检查连接是否成功
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}

// 查询add表，获取满足条件的id值
$sql = "SELECT id FROM fa_admin WHERE username = '$token'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    // 遍历查询结果
    while ($row = $result->fetch_assoc()) {
        $id = $row['id'];

        // 根据id和name更新fa_register表中满足条件的记录的now_status字段值
        $updateSql = "UPDATE fa_register SET now_status = '$aStatus' WHERE agent = '$id' AND register_name = '$name'";
        $conn->query($updateSql);

        // 判断更新是否成功
        if ($conn->affected_rows > 0) {
  

            // 查询fa_register表，获取更新后的状态和代理人名称
            $sql1 = "SELECT * FROM fa_register WHERE register_name = '$name'";
            $result1 = $conn->query($sql1);
            if ($result1->num_rows > 0) {
                $row1 = $result1->fetch_assoc();
                $write_name = $row1['register_name'];//撰写交底书名称
                $now_status = '第一次撰写';//当前状态
                $organization = $row1['organization'];//代理机构
                $department = $row1['department'];//代理部门
                $agent = $row1['agent'];//代理人
                $agent_phone = $row1['agent_phone'];//代理人电话

                $sql2 = "INSERT INTO fa_patentwrites (write_name,now_status,organization,departement,agent,agent_phone) VALUES ('$write_name','$now_status','$organization','$department','$agent','$agent_phone')";
                $conn->query($sql2);
                if ($conn->affected_rows > 0) {
                    $company = [
                        "success" => "更新成功",
                    ];
                } else {
                    $company = [
                        "success" => "更新失败",
                        "agent_phone" => $agent_phone,
                        "agent" => $agent,
                        "department" => $department,
                    ];
                }

                // $status = $row1['now_status'];
                // $agentId = $row1['agent'];

                // 查询fa_agent表，获取代理人名称
                // $sql2 = "SELECT agent_name FROM fa_agent WHERE id = '$agentId'";
                // $result2 = $conn->query($sql2);
                // if ($result2->num_rows > 0) {
                //     $row2 = $result2->fetch_assoc();
                //     $agentName = $row2['agent_name'];
                //     $company["status"] = $status;
                //     $company["token"] = $agentName;
                // }
            }
        } else {
            $company = [
                "success" => "更新失败",
                "id"=>$id,
                "register_name"=>$name,
                "status"=>$status,
            ];
          
        }
    }
} else {
    $company = [
        "success" => "更新失败，请稍后再试",
    ];
}

// 输出JSON响应
echo json_encode($company);

// 关闭数据库连接
$conn->close();
?>