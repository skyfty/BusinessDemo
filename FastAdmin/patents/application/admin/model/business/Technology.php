<?php

namespace app\admin\model\business;

use think\Model;


class Technology extends Model
{

    

    

    // 表名
    protected $name = 'technology';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名 
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    


    public function businesscorrelation()
    {
        return $this->belongsTo('app\admin\model\business\Business', 'client_name', 'id', [], 'LEFT')->setEagerlyType(0);
    }
    







}
