// modal-dialog.js

function showPreviewModal(id) {
    // 发送请求到后端接口
    $.ajax({
        url: 'http://192.168.33.217:8081/php/PHP/business/del.php',
        type: 'GET',
        data: { task_id: id }, // 传递 task_id 参数

        success: function (response) {
            // 创建模态框并展示后端接口返回的数据
            var modal = $('<div class="modal fade" tabindex="-1" role="dialog"></div>');
            var modalDialog = $('<div class="modal-dialog modal-lg" role="document"></div>'); // 使用 modal-lg 类设置模态框的宽度为大尺寸
            var modalContent = $('<div class="modal-content"></div>');

            // 获取 transition_path 数据
            var transitionPath = response.transition_path;

            // 创建模态框主体
            var modalBody = $('<div class="modal-body text-center" style="height: 400px;padding: 100px; "></div>'); // 添加 text-center 类使内容居中显示

            // 在模态框中展示 transition_path 数据  background-color: #f2f2f2; draggable draggable-handle draggable-content
            var transitionPathHtml = '<div class="draggable" ><ul  class=" draggable-handle list-unstyled draggable-list" style="background-color: #f2f2f2; witdh:200px;margin-left:30%;margin-right:30%;">'; // 使用 list-unstyled 类移除无序列表前面的点
            for (var i = 0; i < transitionPath.length; i++) {
                if (i > 0) {
                    transitionPathHtml += '<li class="arrow" style="border-bottom-color: #fd0000;color: green;font-size: 50px;padding-left:100px">&#8595;'; // 添加箭头样式
                    var currentElements = $('<span class="border" style="border-bottom-color: #fd0000;color: green;font-size: 10px;"></span>');

                    if (i < transitionPath.length) {
                        var name1 = transitionPath[i - 1];
                        var name2 = transitionPath[i];
                        var url =
                            'http://192.168.33.217:8081/php/PHP/business/juese.php?name1=' +
                            encodeURIComponent(name1) +
                            '&name2=' +
                            encodeURIComponent(name2) +
                            '&task_id=' +
                            encodeURIComponent(id);
                        $.ajax({
                            url: url,
                            type: 'GET',
                            async: false,
                            success: (function (currentElements) {
                                return function (data) {
                                    // 在箭头旁边添加参数值和 transitionPath[i+1] 值
                                    currentElements.append(
                                        '<span style="border: 1px solid black; display: inline-block; width: 100px;">' +
                                        data.name +
                                        '</span></li>'
                                    );
                                    transitionPathHtml += currentElements.prop('outerHTML');
                                    console.log(data.name);
                                };
                            })(currentElements),
                            error: function (xhr, status, error) {
                                console.log(error); // 打印错误信息
                            }
                        });
                    }
                }

                var currentElement = $('<li class="border"></li>');
                currentElement.append(
                    '<span style="border: 1px solid black; display: inline-block; width: 100px;">' +
                    transitionPath[i] +
                    '</span>'
                );

                // 添加箭头旁边的参数值和 transitionPath[i+1] 值
                transitionPathHtml += currentElement.prop('outerHTML');
            }
            transitionPathHtml += '</ul></div>';

            modalBody.html(transitionPathHtml);

            modalContent.append(modalBody);
            modalDialog.append(modalContent);
            modal.append(modalDialog);

            modal.modal('show');
        },

        error: function (xhr, status, error) {
            // 处理错误情况
            console.log(error);
        }
    });
}