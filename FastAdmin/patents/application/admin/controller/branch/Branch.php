<?php

namespace app\admin\controller\branch;

use app\common\controller\Backend;
use think\Db;

/**
 * branch
 *
 * @icon fa fa-circle-o
 */
class Branch extends Backend
{

    /**
     * Branch模型对象
     * @var \app\admin\model\branch\Branch
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\branch\Branch;
    }

    /**
     * 查看分支详细信息
     */
    // public function view($id)
    // {
    //     // 根据$id获取详细信息数据
    //     $data = Db::name('cms_addonbranch')->find($id);

    //     // 渲染视图模板并传递数据
    //     $this->view->assign('data', $data);
    //     return $this->view->fetch('branch/branch/view');
    // }

    /**
     * 编辑分支信息
     */

     public function view($id)
     {
         // 根据$id获取详细信息数据
         $row = Db::name('cms_addonbranch')->find($id);
     
         // 渲染视图模板并传递数据
         return $this->fetch('branch/branch/view', ['row' => $row]);
     }
     
     /**
      * 编辑分支信息
      */
     public function edits($id)
     {
         // 根据$id获取详细信息数据
         $data = Db::name('cms_addonbranch')->find($id);
     
         // 渲染视图模板并传递数据
         return $this->fetch('branch/branch/edit', ['data' => $data]);
     }
     
     /**
      * 保存分支信息
      */
     public function save($ids)
     {
         // 获取表单数据
         $branchName = $this->request->post('branchName');
         $content = $this->request->post('content');
         $telephone = $this->request->post('telephone');
     
         // 更新数据库中的相关记录
         $result = Db::name('cms_addonbranch')
             ->where('id', $ids)
             ->update([
                 'branch_name' => $branchName,
                 'content' => $content,
                 'telephone' => $telephone,
             ]);
     
         if ($result === false) {
             // 保存失败
             return json(['status' => 'error', 'message' => 'Save failed']);
         } else {
             // 保存成功
             return json(['status' => 'success', 'message' => 'Save successful']);
         }
     }

    // 其他默认生成的控制器方法...

}