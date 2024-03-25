<?php

namespace app\admin\model\background;

use think\Model;


class Writes extends Model
{

    

    

    // 表名
    protected $name = 'patentwrites';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [ 

    ];


    public function departementcorrelation()
    {
        return $this->belongsTo('app\admin\model\AuthGroup', 'departement', 'id', [], 'LEFT')->setEagerlyType(0);//客户
    }
    public function organization()
    {
        return $this->belongsTo('app\admin\model\branch\Branch','organization','id',[],'LEFT')->setEagerlyType(0);
    }
    public function agent()
    {
        return $this->belongsTo('app\admin\model\Admin','agent','id','LEFT')->setEagerlyType(0);
    }

  

    







}
