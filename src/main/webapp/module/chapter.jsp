<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table id="chapter_tt" ></table>
<div id="chapter_album">
    <form id="ff" method="post">
        <div>
            <label for="name">名字:</label>
            <input class="easyui-validatebox" id="name" type="text" name="title" data-options="required:true" />
        </div>
        <div>
            <label for="author">作者:</label>
            <input class="easyui-validatebox" id="author" type="text" name="author" data-options="required:true" />
        </div>
        <div>
            <label for="broadcast">播音员:</label>
            <input class="easyui-validatebox" id="broadcast" type="text" name="broadcast" data-options="required:true" />
        </div>
        <div>
            <label for="brief">内容:</label>
            <textarea id="brief" name="brief"></textarea>
        </div>
        <div>
            <label for="publishDate">上传时间:</label>
            <input class="easyui-validatebox" id="publishDate" type="date" name="publishDate" data-options="required:true" />
        </div>
        <div>插图：</div>
        <img src="" id="imgaa" width="120"  height="100"/>

    </form>


</div>

<%--双击播放--%>
<div id="audio">
    <audio id="audio_id" src=""  controls="controls" loop="loop"></audio>
</div>
<%--双击播放===END===--%>

// 添加章节
<div id="addChapterDiv">
    <form method="post" enctype="multipart/form-data" id="chapterForm">
        音频：<input name="chapterFile" type="file" class="offset10 lf" id="chapterFile"/></br>
        <input type="hidden" id="idd" name="aid"/>
        <input type="button" value="提交" onclick="toChapter()"/>
    </form>
</div>

// 添加专辑
<div id="addAlbumDiv">
    <form method="post" enctype="multipart/form-data" id="albumForm">
        <table>
            <tr>
                <td>专辑名字：</td><td><input name="title" id="addTitle"/></td>
            </tr>
            <tr>
                <td>专辑作者：</td><td><input name="author" id="addAuthor"/></td>
            </tr>
            <tr>
                <td>播音员：</td><td><input name="broadcast" id="addBroadcast"/></td>
            </tr>
            <tr>
                <td>轮播图图片</td><td><div class="lf salebd"><img id="img"  src="${pageContext.request.contextPath}/img/captcha.jpg" width="100" height="100"/></div>
                <input name="uploadFile" type="file" class="offset10 lf" id="addFile"/></td>
            </tr>
            <tr>
                <td>内容：</td><td><textarea class="textarea" name="brief" id="addBrief"></textarea></td>
            </tr>
            <tr>
                <td colspan="2"><input type="button" value="添加" onclick="toAlbum()"/></td>
            </tr>
        </table>
    </form>

</div>

<script type="text/javascript">

    // 页面加载
    $(function () {
        $('#chapter_tt').treegrid({
            url:'${pageContext.request.contextPath}/album/show',
            idField:'id',
            treeField:'title',
            fit:true,
            fitColumns: true,
            columns:[[
                {field:'title',title:'名字',width:100},
                {field:'downPath',title:'下载路径',width:100},
                {field:'size',title:'章节大小',width:100},
                {field:'duration',title:'章节时长',width:100}
            ]],

            // 双击事件(播放音频)
            onDblClickRow:function (row) {
                if(row.size==null){
                    $.messager.alert('友情提示','请选中要播放的音频！','info');
                }else{
                    //alert(row.size)
                    $("#audio").dialog("open")
                    $("#audio_id").prop("src", "${pageContext.request.contextPath}/chapter/" + row.downPath)
                }

            },

            // 内容可适应
            fitColumns: true,

            // 定义按钮
            toolbar: [{
                iconCls: 'icon-more',
                text:"专辑详情",
                handler: function(){

                    // 获取选中行的对象
                   var row =  $('#chapter_tt').treegrid("getSelected");
                   if(row == null){
                       $.messager.alert('友情提示','请先选中专辑！','info');
                   }else{
                       if(row.author==null){
                           $.messager.alert('友情提示','请先选中专辑！','info');
                       }else{
                           // 打开详情窗口
                           $('#chapter_album').dialog("open");
                           $("#imgaa").prop("src","${pageContext.request.contextPath}/img/"+row.coverImg);
                           $("#ff").form("load",row)
                       }
                   }
                }
            },'-',{
                iconCls: 'icon-add',
                text:"添加专辑",
                handler: function(){
                    $('#addAlbumDiv').dialog("open");
                }
            },'-',{
                iconCls: 'icon-add',
                text:"添加章节",
                handler: function(){

                  // 获取选中行的对象
                    var row =  $('#chapter_tt').treegrid("getSelected");
                    if(row == null){
                        $.messager.alert('友情提示','请先选中专辑！','info');
                    }else{
                        if(row.author==null){
                            $.messager.alert('友情提示','请先选中专辑！','info');
                        }else{

                            // 给隐藏域传专辑id
                            $("#idd").val(row.id);
                            $('#addChapterDiv').dialog("open");

                        }
                    }


                }
            },'-',{
                iconCls: 'icon-undo',
                text:"下载音频",
                handler: function(){

                    // 获取选中行的对象
                    var row =  $('#chapter_tt').treegrid("getSelected");
                    if(row == null){
                        $.messager.alert('友情提示','请先选中章节！','info');
                    }else{
                        if(row.size==null){
                            $.messager.alert('友情提示','请先选中章节！','info');
                        }else{
                            // 往后台发ajax
                            location.href="${pageContext.request.contextPath}/chapter/dowload?title="+row.title+"&url="+row.downPath;


                        }
                    }


                }
            }

            ],
        });

        //  专辑详情的弹窗
        $('#chapter_album').dialog({
            title: '专辑详情',
            // width: 400,
            // height: 200,
            closed: true,
            modal: true
        });

        // 添加专辑的弹窗
        $('#addAlbumDiv').dialog({
            title: '添加专辑',
            // width: 400,
            // height: 200,
            closed: true,
            modal: true
        });
        // 播放音频
        $('#audio').dialog({
            title: '播放音频',
            // width: 400,
            // height: 200,
            closed: true,
            modal: true,
            onBeforeClose
        });


        // 添加章节的弹窗
        $('#addChapterDiv').dialog({
            title: '添加章节',
            // width: 400,
            // height: 200,
            closed: true,
            modal: true
        });


        // 文件上传(文件域)的改变事件
        $('#addFile').change(function(event) {
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
                $("#img").prop('src', imgURL);
            }
        });

        /*验证框*/
        $('#addFile').validatebox({
            required: true,

        });
        $('#addTitle').validatebox({
            required: true,
        });
        $('#addAuthor').validatebox({
            required: true,
        });
        $('#addBrief').validatebox({
            required: true,
        });
        $('#addBroadcast').validatebox({
            required: true,
        });
        $('#chapterFile').validatebox({
            required: true,
        });

    })

    // 添加专辑
    function toAlbum(){
        $("#albumForm").form("submit",{
            url:"${pageContext.request.contextPath}/album/add",
            onSubmit: function(){
                return $(this).form("validate");
            },
            success:function(data){
                if(data=="true"){
                    $('#addAlbumDiv').dialog("close");
                    $("#chapter_tt").treegrid("reload");
                }else{
                    $.messager.alert('警告','添加失败！','error');
                }
            }

        })
    }

    // 添加章节
    function toChapter() {
        $("#chapterForm").form("submit",{
            url:"${pageContext.request.contextPath}/chapter/add",
            onSubmit: function(){
                return $(this).form("validate");
            },
            success:function(data){
                if(data=="true"){
                    $('#addChapterDiv').dialog("close");
                    $("#chapter_tt").treegrid("reload");
                }else{
                    $.messager.alert('警告','添加失败！','error');
                }
            }

        })
    }
</script>