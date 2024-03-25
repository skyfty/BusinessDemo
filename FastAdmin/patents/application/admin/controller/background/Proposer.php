<?php

namespace app\admin\controller\background;

use app\common\controller\Backend;
use think\Db;
/**
 * proposer
 *
 * @icon fa fa-circle-o
 */
class Proposer extends Backend
{

    /**
     * Proposer模型对象
     * @var \app\admin\model\background\Proposer
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\background\Proposer;

    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

     public function view($id)
     {
        
         $row = Db::name('proposer')
             ->where('id', $id)
             ->find();
      
         // 渲染视图模板并传递数据
   
         return $this->fetch('background/proposer/view', ['row' => $row]);
     }

     public function saveProposerInfo($id)//修改企业主体信息
{


    $business = Db::name('proposer')->find($id);

    $data = $this->request->param();
  
    Db::name('proposer')
        ->where('id', $business['id'])
        ->update($data);

    
    $updatedBusiness = Db::name('proposer')->find($id);
    $updatedCompanyName = $updatedBusiness['proposer_name'];
    $row = Db::name('proposer')
    ->where('proposer_name',$updatedCompanyName)
    ->find();
    $this->success('保存成功', 'background/proposer/view', ['row' => $row]);
    // $this->redirect('background/proposer/view', ['id' =>  $id]);
   
}
    /**
     * 查看
     */
    public function index()
    {
        //当前是否为关联查询
        $this->relationSearch = false;
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();

            $list = $this->model
                    
                    ->where($where)
                    ->order($sort, $order)
                    ->paginate($limit);

            foreach ($list as $row) {
                $row->visible(['id','content','proposer_name','english_name','user_number','applicant_type','applicant_telephone']);
                
            }

            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        return $this->view->fetch();
    }

}
