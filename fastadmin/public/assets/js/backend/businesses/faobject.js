define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'businesses/faobject/index' + location.search,
                    add_url: 'businesses/faobject/add',
                    edit_url: 'businesses/faobject/edit',
                    del_url: 'businesses/faobject/del',
                    multi_url: 'businesses/faobject/multi',
                    import_url: 'businesses/faobject/import',
                    table: 'task_object',
                }
            });

            var table = $("#table");
            //定义一个数组
            var status = [];
            //给status数组赋值
            status[0] = '未开始';

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        { checkbox: true },
                        { field: 'id', title: __('Id') },
                        { field: 'taskobject', title: __('业务对象'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        // { field: 'task', title: __('业务类型'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'task', title: __('业务类型'), operate: 'LIKE', table: table, class: 'autocontent', formatter: function (value, row) {
                            var apiUrl = 'http://localhost:8081/php/PHP/business/taskobject/taskobjecttask.php?task=' + encodeURIComponent(row.task) ;
                            $.ajax({
                                url: apiUrl,
                                dataType: 'json',
                                async: false, // 或者可以不设置，因为true是默认值
                                success: function (response) {
                                   
                                    value = response[0].title; // 将title赋给value
                                },
                                error: function () {
                                    value = 'Error';
                                }
                            });
                            return value;
                        }
                    },
                        
                        // {field: 'taskstatus', title: __('Taskstatus'), operate: 'LIKE', formatter: Table.api.formatter.status},
                        {
                            field: 'taskValue', title: '当前状态', operate: 'LIKE', table: table, class: 'autocontent', formatter: function (value, row) {
                                var apiUrl = 'http://localhost:8081/php/PHP/business/taskstaus.php?name=' + encodeURIComponent(row.task) + '&taskobject=' + encodeURIComponent(row.taskobject);
                                $.ajax({
                                    url: apiUrl,
                                    dataType: 'json',
                                    async: false,
                                    success: function (response) {
                                        console.log(9999);
                                        console.log(response.taskstatus);
                                        console.log(response); // 检查打印
                                        value = response.taskstatus;
                                      
                                        //   i++;
                                        status[row.id] = value;

                                    },
                                    error: function () {
                                        value = 'Error';
                                    }
                                });
                                return value;
                            }
                        },
                        {
                            field: 'custom_button',
                            title: '业务流程阅览',
                            formatter: function (value, row, index) {
                                console.log(row.taskValue);
                                console.log(row.taskobject);
                                return '<button class="btn btn-primary btn-xs btn-preview" data-id="' + row.id + '" data-task="' + row.task + '" data-taskvalue="' + row.taskstatus + '">预览</button>';
                            }
                        },
                        {
                            field: 'custom_button',
                            title: '日志',
                            formatter: function (value, row, index) {
                                console.log(row.taskValue);
                                console.log(row.taskobject);
                                return '<button class="btn-pre"  data-id="' + row.id + '" data-task="' + row.task + '" data-taskobject="'+ row.taskobject +'" data-taskvalue="' + row.taskstatus + '">日志</button>';
                            }
                        },
                        { field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate }
                    ]
                ]
            });





            var modal = $('<div class="modal fade" tabindex="-1" style="background-color: rgba(0, 0, 0, 0);" role="dialog"></div>');
            var modalDialog = $('<div class="modal-dialog" style="background-color: rgba(0, 0, 0, 0);" role="document"></div>');
            var modalContent = $('<div class="modal-content" style="background-color: rgba(0, 0, 0, 0);"></div>');


            var modalBody = $('<div class="modal-body text-center" style=" height: 400px; padding-top: 100px;"></div>');

            modalContent.append(modalBody);
            modalDialog.append(modalContent);
            modal.append(modalDialog);

            $('body').append(modal);
            modal.modal('hide');
            // 添加日志按钮点击事件监听器
            table.on('click', '.btn-pre', function () {
                var taskobject = $(this).data('taskobject');
                console.log(taskobject);
                console.log(111);
                // 发送Ajax请求获取数据
                $.ajax({
                    url: 'http://192.168.33.217:8081/php/PHP/business/taskobjectlog.php',
                    data: {
                        taskobject: taskobject
                    },
                    dataType: 'json',
                    success: function (data) {
                        // 创建模态框内容
                        var modalContent = $('<div class="modal-content"></div>');
                        var modalHeader = $('<div class="modal-header"></div>');
                        var modalTitle = $('<h5 class="modal-title">任务日志</h5>');
                        var closeButton = $('<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>');
                        var modalBody = $('<div class="modal-body"></div>');
            
                        // 设置模态框内容
                        modalHeader.append(modalTitle);
                        modalHeader.append(closeButton);
                        modalContent.append(modalHeader);
                        
                        // 根据返回的数据更新模态框内容
                        for (var i = 0; i < data.length; i++) {
                            var taskObject = data[i].taskobject;
                            var department = data[i].department;
                            var user = data[i].user;
                            var status = data[i].status;
                            var next = data[i].next;
                            var text = data[i].text;
                            var times = data[i].times;
                            modalBody.append('<p>处理对象: ' + taskObject + '</p>');
                            modalBody.append('<p>处理角色: ' + department + '</p>');
                            modalBody.append('<p>处理用户: ' + user + '</p>');
                            
                            modalBody.append('<p>处理状态: ' + status + '>'+next+'</p>');
                            modalBody.append('<p>处理结果: ' + text + '</p>');
                            modalBody.append('<p>处理时间: ' + times + '</p>');
                            modalBody.append('<hr>');
                        }
            
                        modalContent.append(modalBody);
            
                        // 创建模态框
                        var modal = $('<div class="modal fade" tabindex="-1" role="dialog"></div>');
                        var modalDialog = $('<div class="modal-dialog" role="document"></div>');
            
                        // 将模态框内容添加到模态框中
                        modalDialog.append(modalContent);
                        modal.append(modalDialog);
            
                        // 将模态框添加到页面中
                        $('body').append(modal);
            
                        // 显示模态框
                        modal.modal('show');
                    },
                    error: function (xhr, status, error) {
                        console.log(error);
                    }
                });
            });
            // 点击预览按钮显示模态框
            table.on('click', '.btn-preview', function () {

                var id = 0;
                var task = $(this).data('task');
                var url = 'http://192.168.33.217:8081/php/PHP/business/taskso.php?task=' + encodeURIComponent(task);

                // 发起AJAX请求
                $.ajax({
                    url: url,
                    type: 'GET',
                    dataType: 'json',
                    success: function (response) {
                        if (response.status === 'success') {
                            id = response.id;
                            console.log('ID:', id);

                            // 在这里可以进行后续操作，使用获取到的id值
                        } else {
                            console.log('请求失败:', response.message);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log('请求错误:', error);
                    }
                });

                var taskValue = $(this).data('taskvalue');
                console.log('taskValue:', taskValue);



                $.ajax({
                    url: 'http://192.168.33.217:8081/php/PHP/business/taskobject.php',
                    type: 'GET',
                    data: { value: task },
                    success: function (response) {
                        var transitionPath = response.transition_path;
                        var transitionPathHtml = '<div class="draggable" style=" z-index: 1202;" >' // 使用 list-unstyled 类移除无序列表前面的点
                        for (var i = 0; i < transitionPath.length; i++) {


                            var currentElement = $('<div style=" background-color:yellow;" class="border draggable" ></div>');
                            var currentStatus = transitionPath[i];
                            if (currentStatus === status[id]) {
                                currentElement.append(
                                    '<div class="drag"  style="  border: 1px solid black; display: inline-block; ">' +
                                    transitionPath[i] +
                                    '</div>'
                                );
                                currentElement.children('.drag').css('background-color', 'green');
                                console.log(333);
                            } else {
                                //   console.log(currentStatus);
                                currentElement.append(
                                    '<div class="drag"  style="  border: 1px solid black; display: inline-block; ">' +
                                    transitionPath[i] +
                                    '</div>'
                                );
                            }




                            transitionPathHtml += currentElement.prop('outerHTML');
                        }
                        transitionPathHtml += '</div></div>';
                        modalBody.html(transitionPathHtml);

                        modalContent.append(modalBody);
                        modalDialog.append(modalContent);
                        modal.append(modalDialog);

                        modal.modal('show');
                    },

                    error: function (xhr, status, error) {

                        console.log(error);
                    }
                });
                $(document).ready(function () {
                    var isDragging = false;
                    var offsetX = 0;
                    var offsetY = 0;
                    var $dragElement = null;

                    var canvas = document.getElementById("canvas");
                    // modalBody.append(canvas);
                    var ctx = canvas.getContext("2d");

                    $('body').on('mousedown', '.drag', function (event) {
                        isDragging = true;
                        $dragElement = $(this);
                        offsetX = event.clientX - $dragElement.offset().left;//获取鼠标相对元素的偏移量
                        offsetY = event.clientY - $dragElement.offset().top;//获取鼠标相对元素的偏移量
                    });

                    $('body').on('mousemove', function (event) {
                        if (isDragging && $dragElement) {
                            var left = event.clientX - offsetX - 220;//减去220是因为有220px的边框
                            var top = event.clientY - offsetY - 4;//减去4是因为有4px的边框

                            $dragElement.css({
                                left: left + 'px',
                                top: top + 'px'
                            });

                            drawLines();
                        }
                    });

                    $('body').on('mouseup', function () {
                        isDragging = false;
                        $dragElement = null;
                    });


                    // 绘制连线
                    function drawLines() {
                        var containers = $('.drag');
                        var canvasWidth = $(document).width();
                        var canvasHeight = $(document).height();
                        canvas.width = canvasWidth;
                        canvas.height = canvasHeight;
                        ctx.clearRect(0, 0, canvasWidth, canvasHeight);

                        for (var i = 0; i < containers.length - 1; i++) {
                            var container1 = $(containers[i]);
                            var container2 = $(containers[i + 1]);
                            var x1 = container1.offset().left + container1.outerWidth();//计算容器的中心点坐标
                            var y1 = container1.offset().top + container1.outerHeight();
                            var x2 = container2.offset().left + container2.outerWidth();
                            var y2 = container2.offset().top + container2.outerHeight();

                            // 获取数据
                            var name1 = container1.text().trim();
                            var name2 = container2.text().trim();

                            var url = 'http://192.168.33.217:8081/php/PHP/business/juese.php?name1=' + encodeURIComponent(name1) + '&name2=' + encodeURIComponent(name2) + '&task_id=' + encodeURIComponent(id);
                            //
                            $.ajax({
                                url: url,
                                type: 'GET',
                                async: false,
                                success: function (data) {
                                    // 在连线旁边展示数据
                                    //    console.log('1111');
                                    var text = data.name;
                                    var offsetX = (x1 + x2) / 2 - 1;//计算文字的x坐标
                                    var offsetY = (y1 + y2) / 2 - 1;//计算文字的y坐标
                                    ctx.fillStyle = "red";
                                    ctx.font = "bold 13px Arial"; // 调整字体大小
                                    ctx.fillText(text, offsetX, offsetY);
                                },
                                error: function (xhr, status, error) {
                                    console.log(error);
                                }
                            });

                            // 计算容器的中心点坐标
                            var centerX1 = container1.offset().left + container1.outerWidth() / 1.6;//计算容器的中心点坐标
                            var centerY1 = container1.offset().top + container1.outerHeight() / 10.0 - 100;//计算容器的中心点坐标
                            var centerX2 = container2.offset().left + container2.outerWidth() / 1.6;
                            var centerY2 = container2.offset().top + container2.outerHeight() / 10.0 - 100;

                            // 计算线的角度和长度
                            var angle = Math.atan2(centerY2 - centerY1, centerX2 - centerX1);
                            var length = Math.sqrt(Math.pow(centerX2 - centerX1, 2) + Math.pow(centerY2 - centerY1, 2));

                            // 设置箭头属性
                            var arrowSize = 30;
                            var arrowAngle = Math.PI / 6; // 30度

                            // 计算箭头位置
                            var arrowX = centerX1 + (centerX2 - centerX1) / 2;
                            var arrowY = centerY1 + (centerY2 - centerY1) / 2;


                            // 画线
                            ctx.beginPath();
                            ctx.moveTo(centerX1, centerY1);
                            ctx.lineTo(centerX2, centerY2);
                            // ctx.moveTo(x1, y1);
                            // ctx.lineTo(x2, y2);
                            ctx.stroke();
                            console.log('2222');
                            // 画箭头
                            ctx.save();
                            ctx.translate(arrowX, arrowY);
                            ctx.rotate(angle);
                            ctx.beginPath();
                            ctx.moveTo(0, 0);
                            ctx.lineTo(-arrowSize, arrowSize / 2);
                            ctx.lineTo(-arrowSize, -arrowSize / 2);
                            ctx.closePath();
                            ctx.fillStyle = "black";
                            ctx.fill();
                            ctx.restore();
                        }
                    }
                });

                modal.on('hidden.bs.modal', function () {
                    // 刷新页面
                    location.reload();
                });


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