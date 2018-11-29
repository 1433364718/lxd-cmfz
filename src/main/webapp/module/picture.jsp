<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<body>
<div id="dd">
    <form method="post" enctype="multipart/form-data" id="isForm">
       <table>
           <tr>
               <td>轮播图名字：</td><td><input name="picName" id="name"/></td>
           </tr>
           <tr>
               <td>轮播图图片</td><td><div class="lf salebd"><img src="${pageContext.request.contextPath}/img/captcha.jpg" width="100" height="100"/></div>
               <input name="uploadFile" type="file" class="offset10 lf" id="upload_image"/></td>
           </tr>
           <tr>
               <td>描述：</td><td><textarea id="desc" class="textarea" name="desc"></textarea></td>
           </tr>
            <tr>
                <td colspan="2"><input type="button" value="添加" onclick="toAdd()"/></td>
            </tr>
       </table>
    </form>
</div>

<table id="dg"></table>
    <script type="text/javascript">
        $(function () {
           $('#dg').edatagrid({
                url:'${pageContext.request.contextPath}/picture/selectByPage',

                // 开启分页
                pagination:true,

                //通过URL更新数据到服务器并返回更新的行
                updateUrl:"${pageContext.request.contextPath}/picture/update",

                columns:[[
                    {field:'picName',title:'图片名字',width:100},
                    {field:'status',title:'状态',width:100,
                        // 定义该列为可编辑列
                        editor:{
                        // 定义编辑的形式为文本框text
                        type:"text",
                        options:{
                            // 编辑后必须有值（即不能为空）
                             required:true
                         }
                    }},
                    {field:'desc',title:'描述',width:100,align:'right'},
                ]],

                // 启用数据表格详细展示
                view: detailview,
                detailFormatter: function(rowIndex, rowData){
                    return '<table><tr>' +
                        '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/img/' + rowData.url + '" style="height:50px;"></td>' +
                        '<td style="border:0">' +
                        '<p>时间: ' + rowData.date + '</p>' +
                        '<p>描述: ' + rowData.desc + '</p>' +
                        '</td>' +
                        '</tr></table>';
                },

                // 内容可适应
                fitColumns: true,

                // 定义按钮
                toolbar: [{
                    iconCls: 'icon-add',
                    text:"添加",
                    handler: function(){
                        $('#dd').dialog("open");
                    }
                },'-',{
                    iconCls: 'icon-pencil',
                    text:"修改",
                    handler: function(){
                        // 点击修改按钮执行的方法

                        // 获取选中行的对象，若没选中返回值为null
                        var rows = $("#dg").edatagrid("getSelected")
                        // 如果没有选，则提示让选
                        if(rows==null){
                            $.messager.alert('友情提示','请先选中行！','info');
                        }else {
                            /!*将当前行变成可编辑模式*!/
                            // 获取行号
                            var index = $("#dg").edatagrid("getRowIndex", rows);

                            // 编辑指定行(参数为行号，由上一行获取)
                            $("#dg").edatagrid("editRow", index);
                        }

                    }
                },'-',{
                    iconCls: 'icon-cut',
                    text:"删除",
                    handler: function(){
                        // 获取选中行的对象，若没选中返回值为null
                        var row = $("#dg").edatagrid("getSelected")
                        // 如果没有选，则提示让选
                        if(row==null){
                            $.messager.alert('友情提示','请先选中行！','info');
                        }else {
                            $.ajax({
                                url:"${pageContext.request.contextPath}/picture/delete",
                                data:"id="+row.id,
                                success:function (data) {
                                    if(data){
                                        $("#dg").edatagrid("reload");
                                    }else{
                                        $.messager.alert('失败','删除失败！','error');
                                    }
                                }
                            })
                        }
                    }
                },'-',{
                    iconCls: 'icon-filter',
                    text:"保存",
                    handler: function(){
                        // 点击保存按钮执行的代码

                        // 保存编辑行并发送到服务器,即会自动把编辑后的数据发送到属性updateUrl指向的地址
                        $("#dg").edatagrid("saveRow");
                        /*$.ajax({
                            type: "post",
                            url:"${pageContext.request.contextPath}/tea/manage/saveTeacher",
                            data:{'dataJson': JSON.stringify($('#dg').edatagrid("getRows"))},
                            dataType: 'json',
                            success: function (data, textStatus) {
                                if(data) {
                                    showRightBottomMsg("系统提示","提交成功！",'slide',5000);
                                    clearDatagridAndTree();
                                } else {
                                    if(data.errorType == "user") {
                                        showAlertMsg("提示",data.msg,"warning");
                                    } else {
                                        showRightBottomMsg("系统提示",data.msg,'slide',5000);
                                    }
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus + errorThrown);
                            }
                        });*/

                    }
                }

                ],

            });

            // 文件上传(文件域)的改变事件
            $(':file').change(function(event) {
                //  HTML5 js 对象的获取
                var files = event.target.files, file;
                if(files && files.length > 0){
                    // 获取目前上传的文件
                    file = files[0];
                    // 文件的限定类型什么的道理是一样的
                    if(file.size > 1024 * 1024 * 5) {
                        alert('图片大小不能超过 5MB!');
                        return false;
                    }
                    // file对象生成可用的图片
                    var URL = window.URL || window.webkitURL;
                    // 通过 file 生成目标 url
                    var imgURL = URL.createObjectURL(file);
                    // 用这个 URL 产生一个 <img> 将其显示出来
                    $("img").prop('src', imgURL);
                }
            });

            // 弹窗
            $('#dd').dialog({
                title: '添加轮播图',
                //width: 400,
                //height: 200,
                closed: true,
                modal: true,
                resizable:true,
            });

            // 图片名字验证框
            $('#name').validatebox({
                required: true,

            });

            // 文件域验证框
            $('#upload_image').validatebox({
                required: true,

            });

            // 描述验证框
            $('#desc').validatebox({
                required: true,

            });


        })

        function toAdd(){
            $("#isForm").form("submit",{
                url:"${pageContext.request.contextPath}/picture/add",
                onSubmit: function(){
                     return $(this).form("validate");
                },
                success:function(data){
                    if(data=="true"){
                        $('#dd').dialog("close");
                        $("#dg").edatagrid("reload");
                    }else{
                        $.messager.alert('警告','添加失败！','error');
                    }
                }

            })
        }


    </script>
</body>