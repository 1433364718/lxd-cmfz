<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>持名法州主页</title>
<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">   
<script type="text/javascript" src="../js/jquery.min.js"></script>   
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>  
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	<!--菜单处理-->
    $(function(){
        $.ajax({
            url:"${pageContext.request.contextPath}/menus/selectAll",
            success:function (data) {
                var menusList = data.menusList;
                for (var i=0;i<menusList.length;i++){
                    var list=menusList[i].menuList;
                    var title='';
                    for (var j=0;j<list.length;j++){
                        var menus = list[j];
                        title+='<a href="javascript:void(0)" onclick="toJsp('+menus.title+')">'+menus.title+'</a></br>'
                    }
                    $('#aa').accordion('add', {
                        iconCls:menusList[i].iconCls,
                        title: menusList[i].title,
                        content: title,
                        selected: false,
                    });

                }
            }
        })
    })

    function toJsp(menu){
	    alert(menu)
        // 判断该页签是否存在
        var result = $("#tt").tabs("exists",menu);
        if(result){
            // 如果存在，展示该页签
            $("#tt").tabs("select",menu);
        }else{
            // 如果不存在，添加该页签
            $("#tt").tabs("add",{
                title: menu,
                // 能不能被叉掉
                closable:true,
               content:'<iframe src="${pageContext.request.contextPath}/login.jsp" width="100%" height="100%"></iframe>',
            })
        }

    }
</script>

</head>
<body class="easyui-layout">

    <div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    	<div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px" >持名法州后台管理系统</div>
    	<div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">欢迎您:<font color="aqua">${manage.username}</font>  &nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/login.jsp" class="easyui-linkbutton" data-options="iconCls:'icon-01'">退出系统</a></div>
    </div>   
    <div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    	<div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体" >&copy;百知教育 htf@zparkhr.com.cn</div>
    </div>   
       
    <div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    	<div id="aa" class="easyui-accordion" data-options="fit:true">

		</div>
    </div>   
    <div data-options="region:'center'">
    	<div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
		    <div title="主页" data-options="iconCls:'icon-neighbourhood',"  style="background-image:url(image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;"></div>
		</div>  
    </div>   
</body> 
</html>