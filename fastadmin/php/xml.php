<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <title>XML文件翻译</title>
    <script>
        function showPopup() {
            // 显示弹窗
            document.getElementById("popup").style.display = "block";
        }

        function hidePopup() {
            // 关闭弹窗
            document.getElementById("popup").style.display = "none";
        }

        function handleTranslationError() {
            // 关闭弹窗
            hidePopup();
            alert("网络错误，请重试或联系管理员。");
            // 刷新页面
            location.reload();
        }
    </script>
    <style>
        /* 初始隐藏弹窗样式 */
        #popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>

<body>
    <h1>XML文件翻译</h1>
    <form method="POST" enctype="multipart/form-data">
        <input type="file" name="xmlFile" accept=".xml">
        <button type="submit" name="submit" onclick="showPopup()">上传并翻译</button>
    </form>
    <div id="popup">
        <p>正在处理，请稍等...</p>
    </div>
    <?php
    set_time_limit(0); // 设置为0表示没有时间限制
    $apiKey = '20230816001782539';
    $apiSecret = 'o62WRa4ThGYCNntmaqT9';

    if (isset($_POST['submit']) && isset($_FILES['xmlFile'])) {
        $translatedFiles = array(); // 存储已翻译文件的路径
    
        $xmlFilePath = $_FILES['xmlFile']['tmp_name'];
        $xmlString = file_get_contents($xmlFilePath);
        $xml = simplexml_load_string($xmlString);

        $targetLanguages = [
            'zh',
            'en',
            'ara',
            'fra',
            'de',
            'id',
            'it',
            'jp',
            'kor',
            'per',
            'pl',
            'pt',
            'ru',
            'spa',
            'th',
            'tr',
            'vie',
            'cht'
        ];
        // 'en','ara','fra','de'
        // 创建临时文件夹来存储翻译后的文件
        $tempFolder = 'translated_files_' . time();
        mkdir($tempFolder);
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "fastadmin"; // 数据库名称
        $conn = new mysqli($servername, $username, $password, $dbname);
        $conn->set_charset("utf8");
        if ($conn->connect_error) {
            die("数据库连接失败: " . $conn->connect_error);
        }
        // 遍历目标语言数组
        foreach ($targetLanguages as $targetLanguage) {

            $tempXml = clone $xml; // 创建一个临时副本用于翻译
    
            // 遍历XML文件中的String标签
            foreach ($tempXml->Dictionary->String as $string) {
                $value = (string) $string['Value'];

                try {
                    // 查询数据库是否已有翻译
    

                    $sql = "SELECT `$targetLanguage` FROM translate WHERE value = '$value'";
                    $result = @$conn->query($sql);

                    if ($result !== false) {
                        if ($result->num_rows > 0) {
                            // 从查询结果中获取翻译的值
                            $row = $result->fetch_assoc();
                            $translatedValue = $row[$targetLanguage];
                        } else {
                            // 参数在数据表中不存在的处理逻辑
                            $translatedValue = translateString($value, $targetLanguage, $apiKey, $apiSecret);
                        }
                    }

                    $string['Value'] = $translatedValue; // 更新String标签的Value值
                } catch (Exception $e) {
                    echo '<script>handleTranslationError();</script>';
                    exit;
                }
            }

            // 生成新的XML文件名
            $newXmlFilePath = '';

            if ($targetLanguage == 'zh') {
                $newXmlFilePath = $tempFolder . '/ChineseSimplified.xml';
            } elseif ($targetLanguage == 'en') {
                $newXmlFilePath = $tempFolder . '/English.xml';
            } elseif ($targetLanguage == 'ara') {
                $newXmlFilePath = $tempFolder . '/Arabic.xml';
            } elseif ($targetLanguage == 'fra') {
                $newXmlFilePath = $tempFolder . '/French.xml';
            } elseif ($targetLanguage == 'de') {
                $newXmlFilePath = $tempFolder . '/German.xml';
            } elseif ($targetLanguage == 'id') {
                $newXmlFilePath = $tempFolder . '/Indonesian.xml';
            } elseif ($targetLanguage == 'it') {
                $newXmlFilePath = $tempFolder . '/Italian.xml';
            } elseif ($targetLanguage == 'jp') {
                $newXmlFilePath = $tempFolder . '/Japanese.xml';
            } elseif ($targetLanguage == 'kor') {
                $newXmlFilePath = $tempFolder . '/Korean.xml';
            } elseif ($targetLanguage == 'per') {
                $newXmlFilePath = $tempFolder . '/Persian.xml';
            } elseif ($targetLanguage == 'pl') {
                $newXmlFilePath = $tempFolder . '/Polish.xml';
            } elseif ($targetLanguage == 'pt') {
                $newXmlFilePath = $tempFolder . '/PortuguesePortugal.xml';
            } elseif ($targetLanguage == 'ru') {
                $newXmlFilePath = $tempFolder . '/Russian.xml';
            } elseif ($targetLanguage == 'spa') {
                $newXmlFilePath = $tempFolder . '/Spanish.xml';
            } elseif ($targetLanguage == 'th') {
                $newXmlFilePath = $tempFolder . '/Thai.xml';
            } elseif ($targetLanguage == 'tr') {
                $newXmlFilePath = $tempFolder . '/Turkish.xml';
            } elseif ($targetLanguage == 'vie') {
                $newXmlFilePath = $tempFolder . '/Vietnamese.xml';
            } elseif ($targetLanguage == 'cht') {
                $newXmlFilePath = $tempFolder . '/ChineseTraditional.xml';
            } else {

                $newXmlFilePath = $tempFolder . '/translated_' . $targetLanguage . '.xml'; // 处理其他语言的情况
            }
            // 保存更新后的XML文件
            $updatedXmlString = $tempXml->asXML();
            file_put_contents($newXmlFilePath, $updatedXmlString);

            // 将文件路径添加到已翻译文件数组中
            $translatedFiles[] = $newXmlFilePath;

            // 提供下载链接
            // echo '翻译完成。';
            // echo '<a href="download.php?file=' . $newXmlFilePath . '">点击此处下载翻译后的文件</a>';
            // echo '<br>';
        }

        // 生成整个文件夹的压缩包
        $zipFileName = 'translated_files_' . time() . '.zip';
        $zip = new ZipArchive();
        if ($zip->open($zipFileName, ZipArchive::CREATE | ZipArchive::OVERWRITE) === true) {
            foreach ($translatedFiles as $file) {
                $zip->addFile($file, basename($file));
            }
            $zip->close();

            // 提供整个文件夹的下载链接
            echo '翻译完成。';
            echo '<a href="download.php?file=' . $zipFileName . '">点击此处下载整个文件夹</a>';
            echo '<br>';

            // 删除临时文件夹
            if (file_exists($tempFolder)) {
                array_map('unlink', glob($tempFolder . '/*'));
                rmdir($tempFolder);
            }
        } else {
            echo '创建ZIP文件失败。';
        }


        echo '<script>hidePopup();</script>';
    }

    /**
     * 使用百度翻译API翻译字符串
     */
    function translateString($text, $targetLanguage, $apiKey, $apiSecret)
    {
        $salt = time();
        $sign = generateSign($text, $salt, $apiKey, $apiSecret);

        $url = 'http://api.fanyi.baidu.com/api/trans/vip/translate';
        $params = array(
            'q' => $text,
            'from' => 'auto',
            'to' => $targetLanguage,
            'appid' => $apiKey,
            'salt' => $salt,
            'sign' => $sign
        );

        $url .= '?' . http_build_query($params);

        $response = file_get_contents($url);

        if ($response) {
            $jsonResponse = json_decode($response, true);
            $translation = isset($jsonResponse['trans_result'][0]['dst']) ? $jsonResponse['trans_result'][0]['dst'] : '百度翻译错误';
            return $translation;
        } else {
            throw new Exception('网络错误');
        }
    }

    /**
     * 生成签名
     */
    function generateSign($text, $salt, $apiKey, $apiSecret)
    {
        $signStr = $apiKey . $text . $salt . $apiSecret;
        return md5($signStr);
    }
    ?>
</body>

</html>