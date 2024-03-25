<?php

namespace app\admin\controller\background;


use app\common\controller\Backend;
use think\Db;
/**
 * patent_writes
 *
 * @icon fa fa-circle-o
 */
class Writes extends Backend
{
 
    /**
     * Writes模型对象
     * @var \app\admin\model\background\Writes
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\background\Writes;

    } 



    public function index()
    {
     
        $tt =$this->auth->getUserInfo();
        $tts =$tt['id'];
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
    
            $list = $this->model
                    ->with(['departementcorrelation','organization','agent'])//关联查询
                    ->where($where);
                    if ($tt['id'] !== 1 && $tt['id'] !== 2) {
                        $list = $list->where('agent', $tt['id']);
                        // $list = $list->select('content'); // 排除content字段，只选择需要的字段
                    }
                  
                    $list = $list->order($sort, $order)
                    ->paginate($limit);
             
 
            foreach ($list as $row) { 
                
               
                $row->getRelation('departementcorrelation')->visible(['name']); 
                $row->getRelation('organization')->visible(['branch_name']); 
                $row->getRelation('agent')->visible(['nickname']); 
                $row->getRelation('agent')->visible(['mobile']);
               
            }

            $result = array("total" => $list->total(), "rows" => $list->items());//渲染

            return json($result);//渲染
        }//渲染
        return $this->view->fetch();//渲染
    }




    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


     //编辑
     public function edit($ids = null)
     {
        
         
         
   

     
         $row = $this->model->get($ids);
 // 判断角色
 $user = $this->auth->getUserInfo();
 // 检查当前登录用户是否具有显示 Content 字段的权限
 if ($user['id'] == 1 || $user['id'] == 2) {
    if($row['now_status']=='放弃'){
        $showContentField = false;
    }else{
        $showContentField = true;
    }
     
 } else {
     $showContentField = false;
 }

 $this->view->assign('showContentField', $showContentField);

         //上传权限
         if($user['id']>2){
            if($row['now_status']=='第一次撰写中'||$row['now_status']=='第二次撰写中'||$row['now_status']=='第三次撰写中'||$row['now_status']=='第四次撰写中'||$row['now_status']=='第五次撰写中'||$row['now_status']=='第六次撰写中'){
                $upFile = true;
             }else{
                $upFile =false;
             }
         }else{
            $upFile = true;
         }
         
         $this->view->assign('upFile', $upFile);
      
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
             // 是否采用模型验证
             if ($this->modelValidate) {
                 $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                 $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : $name) : $this->modelValidate;
                 $row->validateFailException()->validate($validate);
             }
     
             // 检查 words 字段是否发生变化
             if (isset($params['words']) && $params['words'] != $row['words']) {
                $nowStatus = $row['now_status'];
                $statusMapping = [
                    '第一次撰写中' => '待客户第一次返稿',
                    '第二次撰写中' => '待客户第二次返稿',
                    '第三次撰写中' => '待客户第三次返稿',
                    '第四次撰写中' => '待客户第四次返稿',
                    '第五次撰写中' => '待客户第五次返稿',
                    '第六次撰写中' => '完成',
                ];
            
                if (isset($statusMapping[$nowStatus])) {
                    $params['now_status'] = $statusMapping[$nowStatus];
                }
            }
        
             //判断更新状态
             if ($params['now_status'] == '返稿') {
                switch ($row['now_status']) {
                    case '待客户第一次返稿':
                        $params['now_status'] = '第二次撰写中';
                        break;
                    case '待客户第二次返稿':
                        $params['now_status'] = '第三次撰写中';
                        break;
                    case '待客户第三次返稿':
                        $params['now_status'] = '第四次撰写中';
                        break;
                    case '待客户第四次返稿':
                        $params['now_status'] = '第五次撰写中';
                        break;
                    case '待客户第五次返稿':
                        $params['now_status'] = '第六次撰写中';
                        break;
                   
                    default:                       
                        break;
                }
            }
          
     
             $result = $row->allowField(true)->save($params);
             Db::commit();
         } catch (ValidateException | PDOException | Exception $e) {
             Db::rollback();
             $this->error($e->getMessage());
         }
     
         if (false === $result) {
             $this->error(__('No rows were updated'));
         }
     
         $this->success();
     }


}
