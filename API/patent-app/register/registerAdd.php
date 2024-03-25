<?php
//请求下拉数据
$servername = "localhost";  // 数据库主机名
$username = "admin";  // 数据库用户名
$password = "Fei.1234";  // 数据库密码
$dbname = "newpatent";  // 数据库名
$conn = new mysqli($servername, $username, $password, $dbname);

// 检查连接是否成功
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}

// 查询机构表
$sql = "SELECT branch_name FROM fa_cms_addonbranch";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // 创建一个数组用于存储所有的name值
    $names = array();

    // 遍历查询结果
    while ($row = $result->fetch_assoc()) {
        // 从每一行中提取name的值并添加到数组中
        $name = array('name' => $row["branch_name"]);
        $names[] = $name;
    }
} else {
    echo "没有查询到结果";
}
//查询部门表

//查询代理人表
$sql2 = "SELECT * FROM fa_admin";
$result2 = $conn->query($sql2);
if ($result2->num_rows > 0) {
    // 创建一个数组用于存储所有的agent值
    $agents = array();

    // 遍历查询结果
    while ($row2 = $result2->fetch_assoc()) {
        // 从每一行中提取agent的值并添加到数组中
      //查询部门
      if($row2['id'] > 2){
        $sql3 = "SELECT group_id FROM fa_auth_group_access WHERE uid = " . $row2['id'];
        $result3 = $conn->query($sql3);
        $row3 = $result3->fetch_assoc();
        $sql4 = "SELECT name,pid FROM fa_auth_group WHERE id = " . $row3['group_id'];
        $result4 = $conn->query($sql4);
        $row4 = $result4->fetch_assoc();//部门
        //机构
        $sql5 = "SELECT name FROM fa_auth_group WHERE id = " . $row4['pid'];
        $result5 = $conn->query($sql5);
        $row5 = $result5->fetch_assoc();
        

         $agent = array(
            'department' =>$row4['name'],//部门
            'agent_name' => $row2['nickname'],//代理人名字
            'telephone' => $row2["mobile"],//代理人电话
            'organization'=>$row5['name']//机构
        );
        
        $agents[] = $agent;
      }
    }
} else {
    echo "没有查询到结果";
}
//客户
$sql5 = "SELECT business_name FROM fa_cms_addoncompany";
$result5 = $conn->query($sql5);
if ($result5->num_rows > 0) {
    // 创建一个数组用于存储所有的agent值
    $companys = array();

    // 遍历查询结果
    while ($row5 = $result5->fetch_assoc()) {
        // 从每一行中提取agent的值并添加到数组中
        $company = array('company' => $row5["business_name"]);
        $companys[] = $company;
    }
} else {
    echo "没有查询到结果";
}

$sql6 = "SELECT technology_name,telephone,client_name FROM fa_technology";
$result6 = $conn->query($sql6);
if($result6->num_rows > 0){
    $technologys = array();
    while($row6 = $result6->fetch_assoc()){

        $sql7 = "SELECT business_name FROM fa_cms_addoncompany WHERE id = " . $row6['client_name'];
        $result7 = $conn->query($sql7);
        if ($result7->num_rows > 0) {
            $row7 = $result7->fetch_assoc();
            $row6['client_name'] = $row7["business_name"];
        }

        $technology = array(
            'technology_name' => $row6["technology_name"],
            'telephone' => $row6["telephone"],
            'client_name' => $row6["client_name"]
        );
        $technologys[] = $technology;
    }

}


$data = array(
    'agents' => $agents,
    'names' => $names,
    'companys' => $companys,
    'technologys' => $technologys
);

$json = json_encode($data);

echo $json;

// 关闭数据库连接
$conn->close();

?>