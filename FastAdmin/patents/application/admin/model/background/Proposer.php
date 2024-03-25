<?php

namespace app\admin\model\background;

use think\Model;


class Proposer extends Model
{

    

    

    // 表名
    protected $name = 'proposer';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    
protected static function init(){
    self::afterInsert(function ($row) {
        // 获取插入后生成的 id 值
        $id = $row->id;
        $defaultIdCode = 'ACN000' . $id; 
        // 更新数据行的 idcode 字段值
        $row->user_number = $defaultIdCode;
        $row->save();
    });

}
    







}
