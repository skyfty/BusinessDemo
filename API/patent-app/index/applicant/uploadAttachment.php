<?php

// 获取传入的参数
$name = $_POST['name'];
$file = $_FILES['file'];

// 检查文件上传是否成功
if ($file['error'] === UPLOAD_ERR_OK) {
  // 获取文件信息
  $fileName = $file['name'];
  $fileType = $file['type'];
  $fileTmpName = $file['tmp_name'];

  // 指定保存文件的目录
  $uploadDir = '/path/to/upload/directory/';

  // 检查文件类型是否允许上传
  $allowedExtensions = ['jpg', 'png', 'pdf', 'docx'];
  $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
  if (in_array($fileExtension, $allowedExtensions)) {
    // 生成新的文件名，以防止文件名冲突
    $newFileName = uniqid() . '.' . $fileExtension;

    // 移动上传的文件到指定目录
    if (move_uploaded_file($fileTmpName, $uploadDir . $newFileName)) {
      // 文件上传成功，将文件路径保存到数据库

      // 使用适当的数据库连接信息连接到数据库服务器
      $servername = 'localhost';
      $username = 'root';
      $password = 'Fei.1234';
      $dbname = 'patent';

      // 创建数据库连接
      $conn = new mysqli($servername, $username, $password, $dbname);

      // 检查连接是否成功
      if ($conn->connect_error) {
        die('数据库连接失败：' . $conn->connect_error);
      }

      // 准备 SQL 查询语句
      $sql = "UPDATE fa_proposer SET attachment = '$uploadDir$newFileName' WHERE name = '$name'";

      // 执行 SQL 查询
      if ($conn->query($sql) === TRUE) {
        echo '文件上传成功，并已保存到数据库。';
      } else {
        echo '保存文件路径到数据库时出错：' . $conn->error;
      }

      // 关闭数据库连接
      $conn->close();
    } else {
      echo '文件上传失败。';
    }
  } else {
    echo '不允许上传此类型的文件。';
  }
} else {
  echo '文件上传过程中出错：' . $file['error'];
}