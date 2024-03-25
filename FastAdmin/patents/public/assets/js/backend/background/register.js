define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

  var Controller = {
    index: function () {
      // 初始化表格参数配置
      Table.api.init({
        extend: {
          index_url: 'background/register/index' + location.search,
          add_url: 'background/register/add',
          edit_url: 'background/register/edit',
          del_url: 'background/register/del',
          multi_url: 'background/register/multi',
          import_url: 'background/register/import',
          table: 'register',
        }
      });

      var table = $("#table");

      // 初始化表格
      table.bootstrapTable({
        url: $.fn.bootstrapTable.defaults.extend.index_url,
        pk: 'id',
        sortName: 'id',
        fixedColumns: true,
        fixedRightNumber: 1,
        columns: [
          [
            { checkbox: true },
            {field:'idcode',title:__('唯一标识')},
            { field: 'register_name', title: __('Register_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
            { field: 'clientcorrelation.business_name', title: __('客户名称'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
            // { field: 'case_type', title: __('Case_type'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//案件类型
            // { field: 'copyright_type', title: __('版权类型'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//版权类型
            { field: 'now_status', title: __('状态'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },

            // { field: 'my_case_number', title: __('My_case_number'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//我方案号
            // { field: 'other_case_number', title: __('Other_case_number'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//对方案号

            { field: 'branchcorrelation.branch_name', title: __('Organization'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//代理部门
            { field: 'department.name', title: __('代理部门'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
            { field: 'agent.nickname', title: __('Agent'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
            { field: 'agent.mobile', title: __('代理人联系方式'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//代理人电话

            // { field: 'technologycorrelation.technology_name', title: __('Technology'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//技术联系人

            {
              field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate,

              buttons: [
                {
                  name: 'view',
                  title: function (row) {//这里的row是当前行的数据
                    return row.id;
                  },
                  classname: 'btn btn-xs  btn-success btn-magic btn-addtabs btn-view',
                  icon: 'fa fa-folder-o',
                  url: function (row) { // 使用函数动态构建URL    


                    return 'background/register/view?id=' + row.id;

                  }
                }
              ],
              formatter: function (value, row, index) {


                var that = $.extend({}, this);


                var table = $(that.table).clone(true);


                // $(table).data("operate-edit", null);


                // $(table).data("operate-del", null);


                that.table = table;


                return Table.api.formatter.operate.call(that, value, row, index);
              }
            }


          ]
        ]
        
        
      });

      // 为表格绑定事件
      Table.api.bindevent(table);
    },
    add: function () {
      Controller.api.bindevent();

      //客户名称
      var client_nameSelect = $("#cclient_name");
      var cctechnologySelect = $("#cctechnology");
      client_nameSelect.on("change", function () {
        var selectedClient_name = $(this).val();

        console.log(selectedClient_name);
        $.ajax({
          url: 'background/register/gettechnology',
          data: {
            technology: selectedClient_name
          },
          dataType: 'json',
          success: function (data) {
            console.log(data);
            var parsedData = JSON.parse(data);
            console.log(parsedData);
            cctechnologySelect.empty();
            if (Array.isArray(parsedData)) {
              parsedData.forEach(function (agent) {
                var option = $("<option>").val(agent.id).text(agent.technology_name
                );
                cctechnologySelect.append(option);
                console.log(agent.id);
              });
            }
          }
        }); 
      });


//机构名称
      // var organizationSelect = $("#corganization");
      // var agentSelect = $("#cagent");

      // organizationSelect.on("change", function () {
      //   var selectedOrganization = $(this).val();
      //   console.log(selectedOrganization);
      //   $.ajax({
      //     url: 'background/register/getAgents',
      //     data: {
      //       organization: selectedOrganization
      //     },
      //     dataType: 'json',
      //     success: function (data) {
      //       console.log(data);
      //       var parsedData = JSON.parse(data);
      //       console.log(parsedData);
      //       agentSelect.empty();
      //       if (Array.isArray(parsedData)) {
      //         parsedData.forEach(function (agent) {
      //           var option = $("<option>").val(agent.id).text(agent.agent_name);
      //           agentSelect.append(option);
      //           console.log(agent.id);
      //         });
      //       }
      //     }
      //   });
      // });
      var organizationSelect = $("#corganization");
      var agentSelect = $("#cagent");

     
      var dd ='';
      organizationSelect.on("change", function () {
        var selectedOrganization = $(this).val();
        dd = selectedOrganization;
      
        $.ajax({
          url: 'background/register/getAgents',
          data: {
            organization: selectedOrganization
          },
          dataType: 'json',
          success: function (data) {
     
            var parsedData = JSON.parse(data);
        
            agentSelect.empty();
            if (Array.isArray(parsedData)) {
              parsedData.forEach(function (agent) {
                var option = $("<option>").val(agent.id).text(agent.name);
                agentSelect.append(option);
              
              });
            }
          }
        });
      });
      //部门
      var departmentSelects = $("#cagent");
      var agentSelects = $("#cdagent");
      var PhoneSelects = $("#agentphone");
      departmentSelects.on("change", function () {
        var selectDepartment = $(this).val();
        console.log(selectDepartment);//部门id
      
        $.ajax({
          url: 'background/register/getAgentss',
          data: {
            organization: dd,
            department: selectDepartment,
          },
          dataType: 'json',
          success: function (data) {
            console.log(data);
            var parsedData = JSON.parse(data);
          
      
            console.log(parsedData[0]['username']);
            agentSelects.empty();
            if (Array.isArray(parsedData)) {
              parsedData.forEach(function (agent) {
                var option = $("<option>").val(agent.id).text(agent.username);
                agentSelects.append(option);
                
              });
            }

            PhoneSelects.empty();
            if(Array.isArray(parsedData)){
              parsedData.forEach(function(agent){
                var option = $("<option>").val(agent.id).text(agent.mobile);
                PhoneSelects.append(option);
              });
 
            }


          }
        });
      });


      // //电话
      // var aagentSelects = $("#cdagent");
      // var PhoneSelects = $("#agentphone");

      // aagentSelects.on("change", function () {
      //   var selectaagent = $(this).val();
      
      
      //   $.ajax({
      //     url: 'background/register/getPhone',
      //     data: {
           
      //       agent: selectaagent,
      //     },
      //     dataType: 'json',
      //     success: function (data) {
      //       console.log(data);
      //       var parsedData = JSON.parse(data);
          
      
           
      //       PhoneSelects.empty();
      //       if (Array.isArray(parsedData)) {
      //         parsedData.forEach(function (agent) {
      //           var option = $("<option>").val(agent.id).text(agent.mobile);
      //           PhoneSelects.append(option);
                
      //         });
      //       }
      //     }
      //   });
      // });

    },
    view: function () {
      Controller.api.bindevent();

    },
    edit: function () {
      Controller.api.bindevent();


      var organizationSelect = $("#c-organization");
      var departmentSelect = $("#c-department");

     
      var dd ='';
      organizationSelect.on("change", function () {
        var selectedOrganization = $(this).val();
        dd = selectedOrganization;
      
        $.ajax({
          url: 'background/register/getAgents',
          data: {
            organization: selectedOrganization
          },
          dataType: 'json',
          success: function (data) {
     
            var parsedData = JSON.parse(data);
        
            departmentSelect.empty();
            if (Array.isArray(parsedData)) {
              parsedData.forEach(function (agent) {
                var option = $("<option>").val(agent.id).text(agent.name);
                departmentSelect.append(option);
              
              });
            }
          }
        });
      });




      //
      var departmentSelects = $("#c-department");
      var agentSelects = $("#c-agent");
      var PhoneSelects = $("#c-agent_phone");
      departmentSelects.on("change", function () {
        var selectDepartment = $(this).val();
        console.log(selectDepartment);//部门id
      
        $.ajax({
          url: 'background/register/getAgentss',
          data: {
            organization: dd,
            department: selectDepartment,
          },
          dataType: 'json',
          success: function (data) {
            console.log(data);
            var parsedData = JSON.parse(data);
          
      
            console.log(parsedData[0]['username']);
            agentSelects.empty();
            if (Array.isArray(parsedData)) {
              parsedData.forEach(function (agent) {
                var option = $("<option>").val(agent.id).text(agent.nickname);
                agentSelects.append(option);
                
              });
            }

            PhoneSelects.empty();
            if(Array.isArray(parsedData)){
              parsedData.forEach(function(agent){
                var option = $("<option>").val(agent.id).text(agent.mobile);
                PhoneSelects.append(option);
              });
 
            }


          }
        });
      });



    },
    api: {
      bindevent: function () {
        Form.api.bindevent($("form[role=form]"));
      }
    }
  };
  return Controller;
});
