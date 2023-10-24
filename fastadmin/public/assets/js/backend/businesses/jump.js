define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'businesses/jump/index' + location.search,
                    add_url: 'businesses/jump/add',
                    edit_url: 'businesses/jump/edit',
                    del_url: 'businesses/jump/del',
                    multi_url: 'businesses/jump/multi',
                    import_url: 'businesses/jump/import',
                    table: 'jump',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'task_id', title: __('业务类型'), formatter: function (value, row) {
                            var apiUrl = 'http://192.168.33.217:8081/php/PHP/business/task.php?id=' + encodeURIComponent(row.task_id);
                            $.ajax({
                                url: apiUrl,
                                dataType: 'json',
                                async: false,
                                success: function (response) {
                                //   console.log(response); // 检查打印
                                  value = response.title;
                                //   console.log(value);
                              
                                },
                                error: function () {
                                  
                                  
                                  value = 'Error';
                                }
                              });
                            return value;
                        
                        }
                    
                    },
                        {field: 'current_id', title: __('状态'), formatter: function (value, row) {
                            var apiUrl = 'http://192.168.33.217:8081/php/PHP/business/status.php?id=' + encodeURIComponent(row.current_id);
                            $.ajax({
                                url: apiUrl,
                                dataType: 'json',
                                async: false,
                                success: function (response) {
                                //   console.log(response); // 检查打印
                                  value = response.name;
                                //   console.log(value);
                                 
                               
                                },
                                error: function () {
                                  
                                  value = 'Error';
                                }
                              });
                            return value;
                        
                        }
                    
                    },
                        {field: 'next_id', title: __('下一状态'), formatter: function (value, row) {
                            var apiUrl = 'http://192.168.33.217:8081/php/PHP/business/status.php?id=' + encodeURIComponent(row.next_id);
                            $.ajax({
                                url: apiUrl,
                                dataType: 'json',
                                async: false,
                                success: function (response) {
                                  console.log(response); // 检查打印
                                  value = response.name;
                                  console.log(value);
                                 
                                },
                                error: function () {
                                  
                                    console.log(666);
                                  value = 'Error';
                                }
                              });
                            return value;
                        
                        }
                    
                    },
                        {field: 'ProcessRole', title: __('处理角色'), formatter: function (value, row) {
                            var apiUrl = 'http://192.168.33.217:8081/php/PHP/business/role.php?id=' + encodeURIComponent(row.ProcessRole);
                            $.ajax({
                                url: apiUrl,
                                dataType: 'json',
                                async: false,
                                success: function (response) {
                                  console.log(response); // 检查打印
                                  value = response.name;
                                  console.log(value);
                                 
                                },
                                error: function () {
                                  
                                    console.log(666);
                                  value = 'Error';
                                }
                              });
                            return value;
                        
                        }
                    
                    },
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
