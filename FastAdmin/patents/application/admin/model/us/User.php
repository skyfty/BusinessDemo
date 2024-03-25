<?php

namespace app\admin\model\us;

use think\Model;
use app\admin\model\Admin;

class User extends Model
{
    // 表名
    protected $name = 'app_user';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [];

    protected static function afterInsert($data)
    {
        // 获取新增的数据
        $faUsData = $data->getAttr();

        // 注册新的 FastAdmin 后台账号
        $adminModel = new Admin();
        $adminModel->username = $faUsData['username'];
        $adminModel->password = $faUsData['password'];
        // 设置其他字段...

        // 保存到 fa_admin 表
        $adminModel->save();
    }
}