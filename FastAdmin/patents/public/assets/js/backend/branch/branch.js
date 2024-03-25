define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'branch/branch/index' + location.search,
                    add_url: 'branch/branch/add',
                    edit_url: 'branch/branch/edit',
                    del_url: 'branch/branch/del',
                    multi_url: 'branch/branch/multi',
                    import_url: 'branch/branch/import',
                    table: 'cms_addonbranch',
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
                        // {field: 'id', title: __('Id')},
                        {field: 'idcode', title: __('Idcode'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'branch_name', title: __('Branch_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'content', title: __('Content')},
                       
                        {field: 'telephone', title: __('Telephone'), operate: 'LIKE'},
                        
                        {field: 'branch_image', title: __('Branch_image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, 
                    
                        buttons : [
                          
                            {
                                name     : 'view',
                                
                                title    : function(row){//这里的row是当前行的数据
                                    console.log(row);
                                    console.log(row.branch_name);
                                    console.log(row.id);
                                    return row.id;
                                    
                                },
                                classname: 'btn btn-xs  btn-success btn-magic btn-addtabs btn-view',
                                icon: 'fa fa-folder-o',
                                url: function(row) { // 使用函数动态构建URL
                                    return 'branch/branch/view?id=' + row.id;
                                }
                                
                            }
                        ],
                        
                        
                        formatter: Table.api.formatter.operate}
                    ]
                ]
            });
         
           
            
            // 为表格绑定事件
            Table.api.bindevent(table);
            // Controller.api.bindevent();
        },
        view: function () {
            Table.api.init({
                extend: {
                    index_url: 'branch/branch/index' + location.search,
                    add_url: 'branch/branch/add',
                    edit_url: 'branch/branch/edit',
                    del_url: 'branch/branch/del',
                    multi_url: 'branch/branch/multi',
                    import_url: 'branch/branch/import',
                    table: 'cms_addonbranch',
                }
            });
            // Table.api.bindevent(table);
            Controller.api.bindevent();
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
