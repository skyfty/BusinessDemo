<?php

namespace app\admin\controller\business;

use app\common\controller\Backend;
use think\Db;
use think\Controller;
use think\Request;
/**
 * company
 *
 * @icon fa fa-circle-o
 */
class Business extends Backend
{

    /**
     * Business模型对象
     * @var \app\admin\model\business\Business
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\business\Business;

    } 

    public function view($name)//企业主体信息
{
   
    $row = Db::name('company_information')
        ->where('business_name', $name)
        ->find();
        return json($row);
    // 渲染视图模板并传递数据
    // return $this->fetch('business/business/view', ['row' => $row]);
}
public function saveCompanyInfo($id)//修改企业主体信息
{


    $business = Db::name('company_information')->find($id);

    $data = $this->request->param();
  
    Db::name('company_information')
        ->where('business_name', $business['business_name'])
        ->update($data);

    
    $updatedBusiness = Db::name('company_information')->find($id);
    $updatedCompanyName = $updatedBusiness['business_name'];
    $row = Db::name('personal_information')
    ->where('personal_name',$updatedCompanyName) 
    ->find();
    $this->success('保存成功', 'business/business/test', ['row' => $row]);
    // $this->redirect('business/business/view', ['name' =>  $updatedCompanyName]);
   
}
// public function myCustomPage()
// {
//     // 控制器方法的逻辑代码

//     // 绑定事件的代码
//     Controller::api()->bindevent('change', '[data-toggle="city-picker"]', 'callback');

//     // 控制器方法的其他代码
// }

public function test($name)//个人主体信息
{
   
    $row = Db::name('personal_information')
        ->where('personal_name', $name)
        ->find();
 
    // 渲染视图模板并传递数据
    return $this->fetch('business/business/test', ['row' => $row]);
}
public function savePersonalInfo($id)//修改个人主体信息
{
    // 根据 $id 获取对应的 business 数据
    $business = Db::name('personal_information')->find($id);

    // 获取提交的表单数据
    $data = $this->request->param();
 
    // 更新 personal_information 数据
    Db::name('personal_information')
        ->where('personal_name', $business['personal_name'])
        ->update($data);

    // 获取更新后的 personal_name 值
    $updatedBusiness = Db::name('personal_information')->find($id);
    $updatedPersonalName = $updatedBusiness['personal_name'];
    $row = Db::name('personal_information')
    ->where('personal_name',$updatedPersonalName)
    ->find();
    // // 重定向到查看页面，并将更新后的 personal_name 作为参数传递
    $this->success('保存成功', 'business/business/test', ['row' => $row]);
    // $this->redirect('business/business/test', ['name' => $updatedPersonalName]);
}
    
    //关联查询显示
    public function index()
    {
        //当前是否为关联查询
        $this->relationSearch = true;
        //设置过滤方法 
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();

            $list = $this->model
                    ->with(['correlation','branchcorrelation'])//关联查询
                    ->where($where)
                    ->order($sort, $order)
                    ->paginate($limit);

            foreach ($list as $row) {
                
                $row->getRelation('correlation')->visible(['class_name']);//关联查询
                $row->getRelation('branchcorrelation')->visible(['branch_name']);
            }

            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        return $this->view->fetch();
    }


    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}
