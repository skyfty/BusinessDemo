<?php

namespace app\admin\model\branch;

use think\Model;


class Agent extends Model
{

    

    

    // 表名
    protected $name = 'agent';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    

    protected static function init()
    { 
//设置默认值
self::afterInsert(function ($row) {
    // 获取插入后生成的 id 值
    $id = $row->id;
    $defaultIdCode = 'MD000' . $id;
    // 更新数据行的 idcode 字段值
    $row->idcode = $defaultIdCode;
    $row->save();
});


}



//关联查询

public function branchcorrelation()
{
    return $this->belongsTo('app\admin\model\branch\Branch', 'organization', 'id', [], 'LEFT')->setEagerlyType(0);
}






}
