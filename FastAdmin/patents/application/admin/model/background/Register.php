<?php

namespace app\admin\model\background;

use think\Model;
use think\Db;
use fast\Pinyin;


class Register extends Model
{

    

    

    // 表名
    protected $name = 'register';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'case_time_text'
    ];
    
    protected static function init()
    {
        self::afterInsert(function ($row) {
            // 获取插入后生成的 id 值
            $id = $row->id; 
            $formattedId = mt_rand(10, 99);//两位数
            $jg = $row ->organization;//机构
           $kh =$row ->client_name;//客户
           $clientidcode =DB::name('cms_addoncompany')
           ->where('id', $kh)
           ->value('idcode');//取客户ID
           $lastThreeDigits = substr($clientidcode, -3);//取客户ID后三位需拼接

            $branchName = DB::name('cms_addonbranch')
            ->where('id', $jg)
            ->value('branch_name');
            $initials = Pinyin::get($branchName, false); // 获取完整拼音字符串
            $initials = mb_substr($initials, 0, 1, 'UTF-8'); // 截取第一个汉字
            $initials = mb_strtoupper($initials, 'UTF-8'); // 转换为大写首字母
          
            $secondChar = mb_substr($branchName, 1, 1, 'UTF-8'); // 获取第二个汉字
            $initialsss = Pinyin::get($secondChar, false);
            $initialsss = mb_substr($initialsss, 0, 1, 'UTF-8'); // 截取第一个汉字
            $initialsss = mb_strtoupper($initialsss, 'UTF-8');
$initial = mb_strtoupper($initialsss, 'UTF-8'); // 转换为大写首字母

// 提取前两个汉字的首字母
$firstTwoInitials = $initials;

// 获取当前年份和月份
$currentYear = date('y'); // 获取后两位年份
$currentMonth = date('m'); // 获取两位数的月份

//版权类型
$copyrightName = $row -> copyright_type;
           
            $defaultIdCode = $firstTwoInitials.$initial.$currentYear.$currentMonth.$formattedId.$lastThreeDigits.$copyrightName;
            // 更新数据行的 idcode 字段值

 $row->my_case_number = $defaultIdCode;
            $row->save();
        });




            //设置idcode唯一标识
    self::afterInsert(function ($row) {
        // 获取插入后生成的 id 值
        $id = $row->id;
        $defaultIdCode = 'PB000' . $id;
        // 更新数据行的 idcode 字段值
        $row->idcode = $defaultIdCode;
        $row->save();
    });




    }
    


 
    public function getCaseTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['case_time']) ? $data['case_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setCaseTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }
    public function branchcorrelation()
    {
        return $this->belongsTo('app\admin\model\branch\Branch', 'organization', 'id', [], 'LEFT')->setEagerlyType(0);
    }
    public function agent()
    {
        return $this->belongsTo('app\admin\model\Admin', 'agent', 'id', [], 'LEFT')->setEagerlyType(0);
    }
    public function department()
    {
        return $this->belongsTo('app\admin\model\AuthGroup', 'department', 'id', [], 'LEFT')->setEagerlyType(0);
    }
    public function clientcorrelation()
    {
        return $this->belongsTo('app\admin\model\business\Business', 'client_name', 'id', [], 'LEFT')->setEagerlyType(0);//客户
    }
    public function technologycorrelation()
    {
        return $this->belongsTo('app\admin\model\business\Technology', 'technology', 'id', [], 'LEFT')->setEagerlyType(0);//客户
    }
    
 
 

}
