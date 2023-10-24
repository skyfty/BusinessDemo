define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {

            Table.api.init({
                extend: {
                    index_url: 'businesses/business/index' + location.search,
                    add_url: 'businesses/business/add',
                    edit_url: 'businesses/business/edit',
                    del_url: 'businesses/business/del',
                    multi_url: 'businesses/business/multi',
                    import_url: 'businesses/business/import',
                    table: 'task',
                }
            });

            var table = $("#table");

            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        { checkbox: true },
                        { field: 'id', title: __('Id') },
                        { field: 'title', title: __('Title') },
                        { field: 'content', title: __('Content') },
                        { field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate },
                        {
                            field: 'custom_button', title: '业务流程阅览', formatter: function (value, row, index) {
                                return '<button class="btn btn-primary btn-xs btn-preview" data-id="' + row.id + '">预览</button>';
                            }
                        }
                    ]
                ]
            });


            var modal = $('<div class="modal fade" tabindex="-1" style="background-color: rgba(0, 0, 0, 0);" role="dialog"></div>');
            var modalDialog = $('<div class="modal-dialog" style="background-color: rgba(0, 0, 0, 0);" role="document"></div>');
            var modalContent = $('<div class="modal-content" style="background-color: rgba(0, 0, 0, 0);"></div>');
            
            var modalBody = $('<div class="modal-body text-center" style="height: 400px; padding-top: 100px;"></div>');
            // var canvas = $('<canvas id="canvas" style=" position: absolute;top: 0;left: 0;z-index: 1000;"></canvas>'); // 创建用于绘制连线的canvas元素
            // modalBody.append(canvas);
// canvas = document.createElement("canvas");
//                 canvas.id = "canvas";
//                 canvas.style.zIndex = 2003;
//                 modalBody.append(canvas);
            modalContent.append(modalBody);
            modalDialog.append(modalContent);
            modal.append(modalDialog);
             
            $('body').append(modal);
            modal.modal('hide');

            // 添加预览功能
            table.on('click', '.btn-preview', function () {
               
                var id = $(this).data('id');
               
                $.ajax({
                    url: 'http://192.168.33.217:8081/php/PHP/business/del.php',
                    type: 'GET',
                    data: { task_id: id },
                    success: function (response) {
                        var transitionPath = response.transition_path;
                        var transitionPathHtml = '<div class="draggable" style=" z-index: 1202;" >' // 使用 list-unstyled 类移除无序列表前面的点
                        for (var i = 0; i < transitionPath.length; i++) {


                            var currentElement = $('<div style=" background-color:blue;" class="border draggable" ></div>');
                            currentElement.append(
                                '<div class="drag"  style="border: 1px solid black; display: inline-block; ">' +
                                transitionPath[i] +
                                '</div>'
                            );




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
                            console.log('1111');
                            console.log(name1);
                            console.log(name2);
                            console.log(id);
                            var url = 'http://192.168.33.217:8081/php/PHP/business/juese.php?name1=' + encodeURIComponent(name1) + '&name2=' + encodeURIComponent(name2) + '&task_id=' + encodeURIComponent(id);

                            $.ajax({
                                url: url,
                                type: 'GET',
                                async: false,
                                success: function (data) {
                                    // 在连线旁边展示数据
                                    console.log('1111');
                                    var text = data.name;
                                    var offsetX = (x1 + x2) / 2;//计算文字的x坐标
                                    var offsetY = (y1 + y2) / 2;//计算文字的y坐标
                                    ctx.fillStyle = "red";
                                    ctx.font = "bold 13px Arial"; // 调整字体大小
                                    ctx.fillText(text, offsetX, offsetY);
                                },
                                error: function (xhr, status, error) {
                                    console.log(error);
                                }
                            });

                            // 计算容器的中心点坐标
                            var centerX1 = container1.offset().left + container1.outerWidth() / 1.6;
                            var centerY1 = container1.offset().top + container1.outerHeight() / 1.6-100;
                            var centerX2 = container2.offset().left + container2.outerWidth() / 1.6;
                            var centerY2 = container2.offset().top + container2.outerHeight() / 1.6-100;

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
                    // 关闭画布
                    // var canvas = document.getElementById("canvas");
                    // var ctx = canvas.getContext("2d");
                    // ctx.clearRect(0, 0, canvas.width, canvas.height);
                    // canvas.parentNode.removeChild(canvas);
                    location.reload();
                    
                });




            });

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
