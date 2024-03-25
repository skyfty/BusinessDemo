<?php

namespace app\admin\model\business;

use think\Model;
use app\admin\model\business\Company_information as FaCompany_information;
use app\admin\model\business\Personal_information as FaPersonal_information;

class Business extends Model
{
    // 表名
    protected $name = 'cms_addoncompany';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [];

//自定义同步更新
    protected static function init()
    {
        // 在数据插入后触发自定义逻辑
        self::afterInsert(function ($row) {
            if ($row['principalclass_model_id'] == 1) {
               
                $data = [
                    'business_name' => $row['business_name'],
                    'content' => $row['content']
                ];
                FaCompany_information::create($data);//插入数据
            } elseif ($row['principalclass_model_id'] == 2) {
                $data = [
                    'personal_name' => $row['business_name'],
                    'content' => $row['content']
                ];
                FaPersonal_information::create($data);
            }
        });
    
     // 在数据更新后触发自定义逻辑
     self::afterUpdate(function ($row) {
        if ($row['principalclass_model_id'] == 1) {
           
            FaCompany_information::where('business_name', $row['business_name']) 
                ->update(['content' => $row['content']]); // 更新 content 字段
        } elseif ($row['principalclass_model_id'] == 2) {
           
            FaPersonal_information::where('personal_name', $row['business_name'])
                ->update(['content' => $row['content']]); // 更新 content 字段
        }
    }); 

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
    public function correlation()
    {
        return $this->belongsTo('app\admin\model\business\Principalclass', 'principalclass_model_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }

    public function branchcorrelation()
    {
        return $this->belongsTo('app\admin\model\branch\Branch', 'branch_model_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
