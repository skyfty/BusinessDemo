define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'business/business/index' + location.search,
                    add_url: 'business/business/add',
                    edit_url: 'business/business/edit',
                    del_url: 'business/business/del',
                    multi_url: 'business/business/multi',
                    import_url: 'business/business/import',
                    table: 'cms_addoncompany',
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
                        { checkbox: true },
                        // {field: 'id', title: __('Id')}, 
                        { field: 'idcode', title: __('ID'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'business_name', title: __('Business_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'branchcorrelation.branch_name', title: __('机构'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//机构
                        { field: 'correlation.class_name', title: __('类别'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },//类别
                        { field: 'content', title: __('Content') },
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
                                        if (row.correlation.class_name === '公司') {
                                            
                                            return 'business/business/view?name=' + row.business_name;
                                        } else if (row.correlation.class_name === '个人') {
                                        
                                            return 'business/business/test?name=' + row.business_name;
                                        } else {
                                           
                                            console.log('没有');
                                            return '';
                                        }
                                    }
                                }           
                            ],

                            formatter: function (value, row, index) {
 
 
                                var that = $.extend({}, this);
                                 
                                 
                                var table = $(that.table).clone(true);
                                 
                                 
                                $(table).data("operate-edit", null);
                                 
                                 
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
        },
        view: function () {
            Controller.api.bindevent();
        },
        test: function () {
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
