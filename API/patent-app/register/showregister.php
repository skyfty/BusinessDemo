<?php
$servername = "localhost";  // 数据库主机名
$username = "admin";  // 数据库用户名
$password = "Fei.1234";  // 数据库密码
$dbname = "newpatent";  // 数据库名
$conn = new mysqli($servername, $username, $password, $dbname);

// 检查连接是否成功
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}
$token = $_POST['token']; // 获取参数token的值
$register_name = $_POST['register_name']; // 获取参数surface的值

// 根据参数值执行不同的查询语句


// 执行查询语句
$sql = "SELECT * FROM fa_register Where register_name = '$register_name'";
$result = $conn->query($sql);

// 检查查询结果是否为空
if ($result->num_rows > 0) {
    // 将查询结果存储在数组中
    $names = array();
    $row = $result->fetch_assoc();

    $sql2 = "SELECT * FROM fa_admin Where id =" . $row['agent'];
    $result2 = $conn->query($sql2);
    $row2 = $result2->fetch_assoc();
        //代理机构
    $sql3 = "SELECT branch_name FROM fa_cms_addonbranch Where id =" . $row['organization'];
    $result3 = $conn->query($sql3);
    $row3 = $result3->fetch_assoc();
    //客户
    $sql4 = "SELECT business_name FROM fa_cms_addoncompany Where id =" . $row['client_name'];
    $result4 = $conn->query($sql4);
    $row4 = $result4->fetch_assoc();
    //技术
    $sql5 = "SELECT technology_name FROM fa_technology Where id =" . $row['technology'];
    $result5 = $conn->query($sql5);
    $row5 = $result5->fetch_assoc();

        $names[] = array(
            'name' => $row['register_name'],//交底书名称
            'time' => $row['case_time'],//创建时间
            'status' => $row['now_status'],//当前状态
            
            'case_type' =>$row['case_type'],//案件类型
         'now_status' => $row['now_status'],//当前状态
         'period' => $row['period'],//立案周期
         'other_case_number' => $row['other_case_number'],//对方案号
         'fast' => $row['fast'],//是否加快
         'copyright_type' => $row['copyright_type'],//版权类型
         'organization' => $row3['branch_name'],//代理机构
         'department'=> $row['department'],//代理部门
         'agent' => $row2['nickname'],//代理人
         'agent_phone' => $row2['mobile'],//代理人电话
         'client_name' => $row4['business_name'],//客户
         'technology' => $row5['technology_name'],//技术人员
         'technology_phone' => $row['technology_phone'],//技术人员电话
         'invent_open' => $row['invent_open'],//发明专利是否提前公开
        );
    
    
    echo json_encode($names);
} else {
    echo "没有找到任何结果";
}

// 关闭数据库连接
$conn->close();