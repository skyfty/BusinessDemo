<?php

namespace app\admin\controller\background;

use app\common\controller\Backend;
use think\Db;
use think\Log;
/**
 * register
 *
 * @icon fa fa-circle-o
 */
class Register extends Backend
{ 

    /**
     * Register模型对象
     * @var \app\admin\model\background\Register
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\background\Register;

    }

//传机构返回部门
    public function getAgents($organization)
    {
        // $organization = input('get.organization');

        // 根据organization参数查询数据库或者其他数据源，获取对应的Agents数据
        // 这里只是一个示例，你需要根据你的实际情况修改
        // $agentIds = Db::name('cms_addonbranch')->where('branch_name', $organization)->column('id');
        // $agents = Db::name('agent')->whereIn('organization', $agentIds)->select();
        // $agentsJson = json_encode($agents);




         $agentIds = Db::name('auth_group')->where('name', $organization)->column('id');
        $agents = Db::name('auth_group')->whereIn('pid', $agentIds)->select();
        $agentsJson = json_encode($agents);

        // 返回 JSON 格式的代理数据
        return $agentsJson;
        // 返回Agents数据
        // return $this->fetch('background/register/add',['agent'=>$agents]);
    }
//传部门返回代理人

public function getAgentss($organization,$department)
{
    // $organization,机构
    // $department,部门id
    // $organization = input('get.organization');

    // 根据organization参数查询数据库或者其他数据源，获取对应的Agents数据
    // 这里只是一个示例，你需要根据你的实际情况修改
    // $agentIds = Db::name('cms_addonbranch')->where('branch_name', $organization)->column('id');
    // $agents = Db::name('agent')->whereIn('organization', $agentIds)->select();
    // $agentsJson = json_encode($agents);




     $departmentIds = Db::name('auth_group_access')->where('group_id', $department)->column('uid');
    $agents = Db::name('admin')->whereIn('id',$departmentIds)->select();
    $agentsJson = json_encode($agents);

    // 返回 JSON 格式的代理数据
    return $agentsJson;
    // 返回Agents数据
    // return $this->fetch('background/register/add',['agent'=>$agents]);
}
//电话
public function getPhone($agent)
{
    // $organization,机构
    // $department,部门id
    // $organization = input('get.organization');

    // 根据organization参数查询数据库或者其他数据源，获取对应的Agents数据
    // 这里只是一个示例，你需要根据你的实际情况修改
    // $agentIds = Db::name('cms_addonbranch')->where('branch_name', $organization)->column('id');
    // $agents = Db::name('agent')->whereIn('organization', $agentIds)->select();
    // $agentsJson = json_encode($agents);




    //  $departmentIds = Db::name('admin')->where('id', $agent)->column('uid');
    $agents = Db::name('admin')->whereIn('id',$agent)->select();
    $agentsJson = json_encode($agents);

    // 返回 JSON 格式的代理数据
    return $agentsJson;
    // 返回Agents数据
    // return $this->fetch('background/register/add',['agent'=>$agents]);
}









    //客户
    public function gettechnology($technology)
    {
        // $technology = input('get.technology');

        // 根据technology参数查询数据库或者其他数据源，获取对应的Agents数据
        // 这里只是一个示例，你需要根据你的实际情况修改
        $Ids = Db::name('cms_addoncompany')->where('business_name', $technology)->column('id');
        $agents = Db::name('technology')->whereIn('client_name', $Ids)->select();
        $agentsJson = json_encode($agents);

        // 返回 JSON 格式的代理数据
        return $agentsJson;
        // 返回Agents数据
        // return $this->fetch('background/register/add',['agent'=>$agents]);
    }



// public  function kket(){
//     $branchNames = Db::name('cms_addonbranch')->column('branch_name');
//     $hier = Db::name('agent')->select();
//     foreach ($hier as &$rowaa) {
//         $organizationId = $rowaa['organization'];
    
//         $branch = Db::name('cms_addonbranch')
//             ->where('id', $organizationId)
//             ->find();
    
//         if ($branch) {
//             $rowaa['organization'] = $branch['branch_name'];
//         }
//     }
//     print_r($branchNames);
//     return $this->fetch('background/register/view', ['branchNames' => $branchNames,'hier'=>$hier]);
// }

    public function view($id)//企业主体信息
    {
       
        $row = Db::name('register')
            ->where('id', $id)
            ->find();
        $rowdd = Db::name('cms_addonbranch')
        ->where('id',$row['organization'])
        ->find();
      
     $row['organization'] = $rowdd['branch_name'];
     $rowee = Db::name('agent')
     ->where('id',$row['agent'])
     ->find();
     $row['agent'] = $rowee['agent_name'];


     $branchNames = Db::name('cms_addonbranch')->column('branch_name');//机构
     $allAgents = Db::name('agent')->column('agent_name');//代理人

     
     $hier = Db::name('agent')->select();

     foreach ($hier as &$rowaa) {
         $organizationId = $rowaa['organization'];
     
         $branch = Db::name('cms_addonbranch')
             ->where('id', $organizationId)
             ->find();
     
         if ($branch) {
             $rowaa['organization'] = $branch['branch_name'];
         }
     }
    
    //  print_r($hier);
        // 渲染视图模板并传递数据
        return $this->fetch('background/businessPatent/register/view', ['row' => $row,'branchNames' => $branchNames,'allAgents' => $allAgents,'hier'=>$hier]);
    }


    public function saveRegisterInfo($id)
{
    $business = Db::name('register')->find($id);
    $data = $this->request->param();

    // 获取对应的 id 值
    $branchId = Db::name('cms_addonbranch')
        ->where('branch_name', $data['organization'])
        ->value('id');
        $agentId = Db::name('agent')
        ->where('agent_name', $data['agent'])
        ->value('id');
    // 将 $data['organization'] 的值替换为对应的 id 值
    $data['organization'] = $branchId;
$data['agent']=$agentId;
    Db::name('register')->where('id', $business['id'])->update($data);

    $updatedBusiness = Db::name('register')->find($id);
    $updatedCompanyName = $updatedBusiness['register_name'];
    $row = Db::name('register')
        ->where('register_name', $updatedCompanyName)
        ->find();
    $this->success('保存成功', 'background/businessPatent/register/view', ['row' => $row]);
}
    // public function saveRegisterInfo($id)
    // {
       
    //         $business = Db::name('register')->find($id);
    
    //         $data = $this->request->param();
    
    //         Db::name('register')
    //             ->where('id', $business['id']) 
    //             ->update($data);
    
    //         $updatedBusiness = Db::name('register')->find($id);
    //         $updatedCompanyName = $updatedBusiness['register_name'];
    //         $row = Db::name('register')
    //             ->where('register_name', $updatedCompanyName)
    //             ->find();
    //         $this->success('保存成功', 'background/register/view', ['row' => $row]);
        
    // }

    public function yourAction()
    {
        // 查询 cms_addonbranch 表中的 branch_name 值
        $branchNames = Db::name('cms_addonbranch')->column('branch_name');
    
        // 将查询结果传递给视图
        $this->assign('branchNames', $branchNames);
    print($branchNames);
        // 渲染视图
        return $this->fetch('background/businessPatent/register/view');
    }






    public function index()
    {
      $tt =$this->auth->getUserInfo();
// echo $tt['username'];


        //当前是否为关联查询
        $this->relationSearch = true;
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);//过滤
        // $this->request->get(["agent"=>"3"]);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
    
            // $list = $this->model
            //         ->with(['branchcorrelation','agent','clientcorrelation','technologycorrelation','department'])//关联查询
            //         ->where($where)
            //         ->where('agent',$tt['id'])
            //         ->order($sort, $order) 
            //         ->paginate($limit); 
            $list = $this->model
            ->with(['branchcorrelation', 'agent', 'clientcorrelation', 'technologycorrelation', 'department'])//关联查询
            ->where($where);
        
        if ($tt['id'] !== 1 && $tt['id'] !== 2) {
            $list = $list->where('agent', $tt['id']);
        }
        
        $list = $list->order($sort, $order)
            ->paginate($limit);
            foreach ($list as $row) {
                
               
                $row->getRelation('branchcorrelation')->visible(['branch_name']);
                $row->getRelation('agent')->visible(['nickname']);
                $row->getRelation('agent')->visible(['mobile']);
                $row->getRelation('department')->visible(['name']);
                $row->getRelation('clientcorrelation')->visible(['business_name']);
                $row->getRelation('technologycorrelation')->visible(['technology_name']);
            }

            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        return $this->view->fetch();
    }
 



    public function edit($ids = null)
    {
        $row = $this->model->get($ids);
      
        $departments = Db::name('auth_group')->where('id', $row['department'])->column('name');
     
        $row['departments'] =  $departments[0];
        $agents = Db::name('admin')->where('id', $row['agent'])->column('nickname');
     
        $row['agents'] =  $agents[0];
        $agent_phones = Db::name('admin')->where('id', $row['agent_phone'])->column('mobile');
     
        $row['agent_phones'] =  $agent_phones[0];
        
        
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds) && !in_array($row[$this->dataLimitField], $adminIds)) {
            $this->error(__('You have no permission'));
        }
        if (false === $this->request->isPost()) {
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);
        $result = false;
        Db::startTrans();
        try {
            //是否采用模型验证
            if ($this->modelValidate) {
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : $name) : $this->modelValidate;
                $row->validateFailException()->validate($validate);
            }
            $result = $row->allowField(true)->save($params);
            //自定义
            if ($row->now_status === '代理人已确认') {
                // 创建新记录
                $newRecord = [
                    'content' => $row->content,
                    'write_name'=>$row->register_name,
                    'organization'=>$row->organization,
                    'departement'=>$row->department,
                    'agent'=>$row->agent,
                    'agent_phone'=>$row->agent_phone,
                    'idcode'=>$row->idcode,

                    // 添加其他需要的字段
                ];
                Db::name('patentwrites')->insert($newRecord);
            }
            Db::commit();
        } catch (ValidateException|PDOException|Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if (false === $result) {
            $this->error(__('No rows were updated'));
        }
        $this->success();
    }

    /** 
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}
