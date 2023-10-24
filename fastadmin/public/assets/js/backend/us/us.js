define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'us/us/index' + location.search,
                    add_url: 'us/us/add',
                    edit_url: 'us/us/edit',
                    del_url: 'us/us/del',
                    multi_url: 'us/us/multi',
                    import_url: 'us/us/import',
                    table: 'us',
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
                        {field: 'name', title: __('Name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'phone', title: __('电话/登录账户'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'department', title: __('部门'), operate: 'LIKE', table: table, class: 'autocontent', formatter: function (value, row) {
                            var apiUrl = 'http://192.168.33.217:8081/php/PHP/business/department.php?id=' + encodeURIComponent(row.department);
                            $.ajax({
                                url: apiUrl,
                                dataType: 'json',
                                async: false,
                                success: function (response) {
                                  console.log(response); // 检查打印
                                  value = response.name;
                                  console.log(value);
                                  console.log(777);
                                //   i++;
                              
                                  // 同时更新预览按钮的data-taskvalue属性的值
                                //   $('.btn-preview[data-id="' + row.id + '"]').data('taskvalue', value);
                                  // status = value;
                                },
                                error: function () {
                                  
                                    console.log(666);
                                  value = 'Error';
                                }
                              });
                            return value;
                        
                        }
                    
                    },
                        {field: 'role', title: __('角色'), operate: 'LIKE', table: table, class: 'autocontent', formatter: function (value, row) {
                            var apiUrl = 'http://192.168.33.217:8081/php/PHP/business/dong.php?id=' + encodeURIComponent(row.role);
                            $.ajax({
                                url: apiUrl,
                                dataType: 'json',
                                async: false,
                                success: function (response) {
                                  console.log(response); // 检查打印
                                  value = response.name;
                                  console.log(value);
                                  console.log(777);
                                //   i++;
                              
                                  // 同时更新预览按钮的data-taskvalue属性的值
                                //   $('.btn-preview[data-id="' + row.id + '"]').data('taskvalue', value);
                                  // status = value;
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
