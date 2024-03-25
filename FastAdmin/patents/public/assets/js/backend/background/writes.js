define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'background/writes/index' + location.search,
                    add_url: 'background/writes/add',
                    edit_url: 'background/writes/edit',
                    del_url: 'background/writes/del',
                    multi_url: 'background/writes/multi',
                    import_url: 'background/writes/import',
                    table: 'patentwrites',
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
                        {field:'idcode',title:__('唯一标识')},
                        {field: 'content', title: __('返稿意见'),operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content  },
                        {field: 'write_name', title: __('Write_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'now_status', title: __('当前状态'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'organization.branch_name', title: __('机构'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'departementcorrelation.name', title: __('部门'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'agent.nickname', title: __('代理人'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'agent.mobile', title: __('代理人联系方式'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'words', title: __('Words'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
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
