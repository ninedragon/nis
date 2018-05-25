
$(function () {

    //1.初始化Table
    var oTable = new TableInit();
    oTable.Init();

    //2.初始化Button的点击事件
    var oButtonInit = new ButtonInit();
    oButtonInit.Init();

});

(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date(); a = s.createElement(o),
m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
ga('create', 'UA-36708951-1', 'wenzhixin.net.cn');
ga('send', 'pageview');


var TableInit = function () {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function () {
        $('#tb_users').bootstrapTable({
            url: 'getUsers.shtml',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: oTableInit.queryParams,//传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100,200,500,1000,2000,5000],        //可供选择的每页的行数（*）
            search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                field: 'id',
                title: 'id'
            }, {
                field: 'nickname',
                title: '昵称'
            }, {
                field: 'email',
                title: 'Email'
            }, {
                field: 'status',
                title: '登录状态'
            }, {
                field: 'create_time',
                title: '创建时间',
                formatter: function (value, row, index) {
                    return jsonDateFormat(value)
                }
            }, {
                field: 'last_login_time',
                title: '最后登录时间',
                formatter: function (value, row, index) {
                    return jsonDateFormat(value)
                }
            }, {
                field: 'meter',
                title: '电表号'
            }, {
                field: 'supply',
                title: '供电单位'
            }, {
                field: 'location',
                title: '家庭地址'
            }, {
                field: 'housenum',
                title: '门牌号'
            }, {
                field: 'sim',
                title: 'sim卡号'
            }, {
                field: 'absid',
                title: '绝对编号'
            }, {
                field: 'version',
                title: '设备版本号'
            }]
        });
    };

    //得到查询的参数
    oTableInit.queryParams = function (params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            limit: params.limit,   //页面大小
            offset: params.offset,  //页码
             id: $("#id").val(),
            nickname: $("#nickname").val(),
            email: $("#email").val(),
            status: $("#status").val(),
            createTime: $("#createTime").val(),
            lastLoginTime: $("#lastLoginTime").val(),
            meter: $("#meter").val(),
            supply: $("#supply").val(),
            location: $("#location").val(),
            housenum: $("#housenum").val(),
            sim: $("#sim").val(),
            absid: $("#absid").val(),
            version: $("#version").val()
        };
        return temp;
    };
    return oTableInit;
};


var ButtonInit = function () {
    var oInit = new Object();
    var postdata = {};

    oInit.Init = function () {
        $("#btn_add").click(function () {
            $(".modal-body").html();
            $("#myModalLabel").text("新增");
            var ths=$('div.fixed-table-header tr>th');
            var thsp=$(ths.parent());
            var content='';
            for (var i = 1; i < ths.length; i++) {
                var field =$('div.fixed-table-header tr th:nth-child('+(i+1)+')').attr('data-field');
                console.log(field);
                if(field!='id'){
                // var field=th. document.getElementById("testDivID").attributes["id"].value; ;
                var title=$('div.fixed-table-header tr th:nth-child('+(i+1)+')>div.th-inner').html();
                content+='<div class="form-group"><label for="';
                content+=field;
                content+='">';
                content+=title;
                content+='</label><input type="text" name="';
                content+=field;
                content+='" class="form-control" id="';
                content+=field;
                content+='" placeholder="';
                content+=title;
                content+='"></div>'; 
              }
            }
            console.log(ths);

            // for (var i = Things.length - 1; i >= 0; i--) {
            //     Things[i]
            // }
                                    
            $(".modal-body").html(content);
           
            console.log($("#myModal").find(".form-control").val(""));
            $('#myModal').modal();

           postdata.DEPARTMENT_ID = "";
        });

        $("#btn_edit").click(function () {
           $(".modal-body").html();
           var arrselections = $("#tb_users").bootstrapTable('getSelections');
           if (arrselections.length > 1) {
               toastr.warning('只能选择一行进行编辑');

               return;
           }
           if (arrselections.length <= 0) {
               toastr.warning('请选择有效数据');
               return;
           } 
            $("#myModalLabel").text("编辑");
            var ths=$('div.fixed-table-header tr>th');
            var thsp=$(ths.parent());
            debugger;
            var content='';
            for (var i = 1; i < ths.length; i++) {
                var field =$('div.fixed-table-header tr th:nth-child('+(i+1)+')').attr('data-field');
                console.log(field);
                // var field=th. document.getElementById("testDivID").attributes["id"].value; ;
                var title=$('div.fixed-table-header tr th:nth-child('+(i+1)+')>div.th-inner').html();
                if(field!='id'){
                content+='<div class="form-group"><label for="';
                content+=field;
                content+='">';
                content+=title;
                content+='</label><input type="text" name="';
                content+=field;
                content+='"';
                content+=' value="';
                var value=eval("arrselections[0]."+field);
                if(value){
                    content+=value;
                }
                content+= '" class="form-control" id="';
                content+=field;
                content+='" placeholder="';
                content+=title;
                content+='"></div>';
                }  
            }
            console.log(ths);

            // for (var i = Things.length - 1; i >= 0; i--) {
            //     Things[i]
            // }
                                    
            $(".modal-body").html(content);

           postdata.DEPARTMENT_ID = arrselections[0].DEPARTMENT_ID;
           $('#myModal').modal();
        });

        $("#btn_delete").click(function () {
           var arrselections = $("#tb_users").bootstrapTable('getSelections');
           if (arrselections.length <= 0) {
               toastr.warning('请选择有效数据');
               return;
           }
          

          
               layer.confirm('确认删除吗？', {
                btn: ['是','否'] //按钮
              }, function(){
               $.ajax({
                   type: "post",
                   url: "/Home/Delete",
                   data: { "": JSON.stringify(arrselections) },
                   success: function (data, status) {
                       if (status == "success") {
                           toastr.success('提交数据成功');
                           $("#tb_departments").bootstrapTable('refresh');
                       }
                   },
                   error: function () {
                       toastr.error('Error');
                   },
                   complete: function () {

                   }

               });                
                layer.msg('的确很重要', {icon: 1});
              }, function(){
                // layer.msg('也可以这样', {
                //   time: 20000, //20s后自动关闭
                //   btn: ['明白了', '知道了']
                // });
              });   

           
        });

        $("#btn_submit").click(function () {
           postdata.DEPARTMENT_NAME = $("#txt_departmentname").val();
           postdata.PARENT_ID = $("#txt_parentdepartment").val();
           postdata.DEPARTMENT_LEVEL = $("#txt_departmentlevel").val();
           postdata.STATUS = $("#txt_statu").val();
           $.ajax({
               type: "post",
               url: "/Home/GetEdit",
               data: { "": JSON.stringify(postdata) },
               success: function (data, status) {
                   if (status == "success") {
                       toastr.success('提交数据成功');
                       $("#tb_departments").bootstrapTable('refresh');
                   }
               },
               error: function () {
                   toastr.error('Error');
               },
               complete: function () {

               }

           });
        });

        $("#btn_query").click(function () {
           $("#tb_users").bootstrapTable('refresh');
        });
    };

    return oInit;
};
 function jsonDateFormat(jsonDate) {
            //json日期格式转换为正常格式
            var jsonDateStr = jsonDate.toString();
            //debugger;//此处用到toString（）是为了让传入的值为字符串类型，目的是为了避免传入的数据类型不支持.replace（）方法
            try {
                var k = parseInt(jsonDateStr.replace("/Date(", "").replace(")/", ""), 10);
                if (k < 0) 
                    return null;

                var date = new Date(parseInt(jsonDateStr.replace("/Date(", "").replace(")/", ""), 10));
                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
                var milliseconds = date.getMilliseconds();
                return date.getFullYear() + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
            }
            catch (ex) {
                return "时间格式转换错误";
            }}