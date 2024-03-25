<?php
header('Access-Control-Allow-Origin: *');  

header("Content-Type: application/json; charset=UTF-8");  
// 连接数据库，替换为你的数据库信息
$servername = "localhost";
$username = "admin";
$password = "Fei.1234";
$dbname = "newpatent";

// 创建数据库连接
$conn = new mysqli($servername, $username, $password, $dbname);

// 检查连接是否成功
if ($conn->connect_error) {
    die("数据库连接失败: " . $conn->connect_error);
}

// 获取传入的 phone 参数
$phone = $_POST['phone'];

// 构建 SQL 查询语句
$sql = "SELECT * FROM fa_admin WHERE mobile = '$phone'";

// 执行查询
$result = $conn->query($sql);

// 检查查询结果
if ($result->num_rows > 0) {
    // 登录成功
    $row = $result->fetch_assoc();
    $uid = $row['id'];
    $sql2 = "SELECT group_id FROM fa_auth_group_access WHERE uid = '$uid'";
    $result2 = $conn->query($sql2);
    $row2 = $result2->fetch_assoc();
    $groupid=$row2['group_id'];
    $sql3 = "SELECT * FROM fa_auth_group WHERE id = '$groupid'";
    $result3 = $conn->query($sql3);
    $row3 = $result3->fetch_assoc();
    $response = array('status' => 'success', 'message' => '登录成功','token'=>$row['username'],'people_type' => $row3['name'],'nick' => $row['nickname'],);
} else {
    // 登录失败
    $response = array('status' => 'failure', 'message' => '登录失败');
}

// 将响应数据转换为 JSON 格式
$jsonResponse = json_encode($response);

// 设置响应的 Content-Type 为 JSON
header('Content-Type: application/json');

// 输出 JSON 响应
echo $jsonResponse;

// 关闭数据库连接
$conn->close();

?>