define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'background/proposer/index' + location.search,
                    add_url: 'background/proposer/add',
                    edit_url: 'background/proposer/edit',
                    del_url: 'background/proposer/del',
                    multi_url: 'background/proposer/multi',
                    import_url: 'background/proposer/import',
                    table: 'proposer',
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
                        {checkbox: true},
                        {field: 'user_number', title: __('User_number'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        // {field: 'id', title: __('Id')},
                      
                        {field: 'proposer_name', title: __('Proposer_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'english_name', title: __('English_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'content', title: __('Content')},
                        {field: 'applicant_telephone', title: __('Applicant_telephone'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                       
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, 
                        buttons: [
                            {
                                name: 'view',
                                title: function (row) {//这里的row是当前行的数据
                                    return row.id;
                                },
                                classname: 'btn btn-xs  btn-success btn-magic btn-addtabs btn-view',
                                icon: 'fa fa-folder-o',
                                url: function (row) { // 使用函数动态构建URL    
                                    
                                        
                                        return 'background/proposer/view?id=' + row.id;
                                    
                                }
                            }           
                        ],
                        formatter: function (value, row, index) {
 
 
                            var that = $.extend({}, this);
                             
                             
                            var table = $(that.table).clone(true);
                             
                             
                            // $(table).data("operate-edit", null);
                             
                             
                            $(table).data("operate-del", null);
                             
                             
                            that.table = table;
                             
                             
                            return Table.api.formatter.operate.call(that, value, row, index);
                            }
                            
                        // formatter: Table.api.formatter.operate
                    }
                    ] 
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        view: function () {
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
