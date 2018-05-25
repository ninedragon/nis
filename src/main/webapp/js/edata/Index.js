$(function() {

    //1.初始化Table
    var oTable = new TableInit();
    oTable.Init();

    //2.初始化Button的点击事件
    var oButtonInit = new ButtonInit();
    oButtonInit.Init();

});
$(function() {

    //1.初始化Table
    var oTable = new TableInit();
    oTable.Init();

    //2.初始化Button的点击事件
    var oButtonInit = new ButtonInit();
    oButtonInit.Init();

});

(function(i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] ||
        function() {
            (i[r].q = i[r].q || []).push(arguments)
        },
        i[r].l = 1 * new Date();
    a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
ga('create', 'UA-36708951-1', 'wenzhixin.net.cn');
ga('send', 'pageview');

var TableInit = function() {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function() {
        $('#tb_users').bootstrapTable({
            url: 'listSuanfaResult.shtml',
            //请求后台的URL（*）
            method: 'post',
            //请求方式（*）
            toolbar: '#toolbar',
            //工具按钮用哪个容器
            striped: true,
            //是否显示行间隔色
            cache: true,
            //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,
            //是否显示分页（*）
            sortable: true,
            //是否启用排序
            sortOrder: "asc",
            //排序方式
            queryParams: oTableInit.queryParams,
            //传递参数（*）
            sidePagination: "server",
            //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,
            //初始化加载第一页，默认第一页
            pageSize: 10,
            //每页的记录行数（*）
            pageList: [10, 25, 50, 100, 200, 500, 1000, 2000, 5000],
            //可供选择的每页的行数（*）
            search: false,
            //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,
            //是否显示所有的列
            showRefresh: true,
            //是否显示刷新按钮
            minimumCountColumns: 2,
            //最少允许的列数
            clickToSelect: true,
            //是否启用点击选中行
            height: 500,
            //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "id",
            //每一行的唯一标识，一般为主键列
            showToggle: true,
            //是否显示详细视图和列表视图的切换按钮
            cardView: false,
            //是否显示详细视图
            detailView: false,
            //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                field: 'id',
                title: 'id'
            }, {
                field: 'C_DistrictBCDId',
                title: 'C_DistrictBCDId'
            }, {
                field: 'C_AddressId',
                title: 'C_AddressId'
            }, {
                field: 'C_RecordDateBCD',
                title: 'C_RecordDateBCD'
            }, {
                field: 'C_TSegmentId',
                title: 'C_TSegmentId',
                // formatter: function (value, row, index) {
                //     return jsonDateFormat(value)
                // }
            }, {
                field: 'C_ChannelId',
                title: 'C_ChannelId',
                // formatter: function (value, row, index) {
                //     return jsonDateFormat(value)
                // }
            }, {
                field: 'C_TKWh',
                title: 'C_TKWh'
            }, {
                field: 'C_FrameCmdId',
                title: 'C_FrameCmdId'
            }, {
                field: 'C_FaultId',
                title: 'C_FaultId'
            }, {
                field: 'C_EEHexId',
                title: 'C_EEHexId'
            }, {
                field: 'C_EESequenceId',
                title: 'C_EESequenceId'
            }, {
                field: 'C_EEKWh',
                title: 'C_EEKWh'
            }, {
                field: 'C_EEOpenMinute',
                title: 'C_EEOpenMinute'
            }, {
                field: 'C_EECloseMinute',
                title: 'C_EECloseMinute'
            }, {
                field: 'C_EEOpenCloseTimes',
                title: 'C_EEOpenCloseTimes'
            }, {
                field: 'C_EEPeakW',
                title: 'C_EEPeakW'
            }, {
                field: 'C_RecordInsertTime',
                title: 'C_RecordInsertTime'
            }, {
                field: 'C_IsValidRecord',
                title: 'C_IsValidRecord'
            }, {
                field: 'C_OffLineVersion',
                title: 'C_OffLineVersion'
            }, {
                field: 'C_ParaId',
                title: 'C_ParaId'
            }, {
                field: 'C_JumpSecond',
                title: 'C_JumpSecond'
                // events:operateEvents
            }, {
                field: 'C_Var',
                title: 'C_Var'
            }, {
                field: 'C_I2A',
                title: 'C_I2A'
            }, {
                field: 'C_I3A',
                title: 'C_I3A'
            }]
        });
    };

    //得到查询的参数
    oTableInit.queryParams = function(params) {
        var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            limit: params.limit,
            //页面大小
            offset: params.offset,
            //页码
            sql: $('#sql').val()
        };
        return temp;
    };
    return oTableInit;
};

var ButtonInit = function() {
    var oInit = new Object();
    var postdata = {};

    oInit.Init = function() {

        $("#btn_query").click(function() {
            $("#tb_users").bootstrapTable('refresh');
        });
    };

    return oInit;
};
// function operateEvents(e, value, row, index){
//      alert('You click like action, row: ' + JSON.stringify(row));
// }
// window.operateEvents = {
//         'click': function (e, value, row, index) {
//             alert('You click like action, row: ' + JSON.stringify(row));
//         },
//         // 'click .remove': function (e, value, row, index) {
//         //     $table.bootstrapTable('remove', {
//         //         field: 'id',
//         //         values: [row.id]
//         //     });
//         // }
//     };
// $(function() {
//     $('#tb_users').on('click-row.bs.table',
//     function(e, row, element) {
//         $(element).css({
//             "color": "blue",
//             "font-size": "16px;"
//         });
//         console.log("row:" + row);
//         console.log("e:" + e);
//         console.log("element:" + element);
//         var startPoint = $("#startPoint").val(),
//         endPoint = $("#endPoint").val(),
//         rootPath = $("#rootPath").val(),
//         pathSave = $("#pathSave").val();
//         // $.post('${basePath}/edata/getV52.shtml',{cDistrictbcdid:row.C_DistrictBCDId,cChannelid:row.C_ChannelId,cAddressid:row.C_AddressId,cRecorddatebcd:row.C_RecordDateBCD,jump:row.C_JumpSecond,cParaid:cParaid,startPoint:startPoint,endPoint:endPoint,rootPath:rootPath,pathSave:pathSave},function(data1){
//         //                       drawChart(data1); 
//         //                       $("#chartmsg").html("地区"+row.C_DistrictBCDId+" 终端号"+row.C_AddressId+" 通道号"+row.C_ChannelId+" 录入时间"+row.C_RecordDateBCD+" 阶跃时间  "+row.C_JumpSecond+'<br/><a href="${basePath}/edata/downloadfile1.shtml"><font size="3" color="blue">下载当前图片P文件数据</font></a>'+'&nbsp;&nbsp;&nbsp;<a href="${basePath}/edata/downloadfile2.shtml"><font size="3" color="blue">下载当前图片Q文件数据</font></a>'+'&nbsp;&nbsp;&nbsp;<a href="${basePath}/edata/downloadfile3.shtml"><font size="3" color="blue">下载当前图片I_2文件数据</font></a>'+'&nbsp;&nbsp;&nbsp;<a href="${basePath}/edata/downloadfile4.shtml"><font size="3" color="blue">下载当前图片I_3文件数据</font></a>');
//         //         });
//     }

// });

$(function() {
    $('#tb_users').on('click-row.bs.table', function(e, row, element) {
        $(element).css({
            "color": "blue",
            "font-size": "16px;"
        });
        console.log(row);
        var startPoint = $("#startPoint").val(),
            endPoint = $("#endPoint").val(),
            rootPath = $("#rootPath").val(),
            cParaid = $('#cParaid').val(),
            pathSave = $("#pathSave").val();
        $.post('getV52.shtml', {
            cDistrictbcdid: row.C_DistrictBCDId,
            cChannelid: row.C_ChannelId,
            cAddressid: row.C_AddressId,
            cRecorddatebcd: row.C_RecordDateBCD,
            jump: row.C_JumpSecond,
            cParaid: cParaid,
            startPoint: startPoint,
            endPoint: endPoint,
            rootPath: rootPath,
            pathSave: pathSave
        }, function(data1) {
            drawChart(data1);
            $("#chartmsg").html("地区" + row.C_DistrictBCDId + " 终端号" + row.C_AddressId + " 通道号" + row.C_ChannelId + " 录入时间" + row.C_RecordDateBCD + " 阶跃时间  " + row.C_JumpSecond + '<br/><a href="downloadfile1.shtml"><font size="3" color="blue">下载当前图片P文件数据</font></a>' + '&nbsp;&nbsp;&nbsp;<a href="downloadfile2.shtml"><font size="3" color="blue">下载当前图片Q文件数据</font></a>' + '&nbsp;&nbsp;&nbsp;<a href="downloadfile3.shtml"><font size="3" color="blue">下载当前图片I_2文件数据</font></a>' + '&nbsp;&nbsp;&nbsp;<a href="downloadfile4.shtml"><font size="3" color="blue">下载当前图片I_3文件数据</font></a>');

        });
        // $.post('${basePath}/edata/getV52.shtml',{cDistrictbcdid:row.C_DistrictBCDId,cChannelid:row.C_ChannelId,cAddressid:row.C_AddressId,cRecorddatebcd:row.C_RecordDateBCD,jump:row.C_JumpSecond,cParaid:cParaid,startPoint:startPoint,endPoint:endPoint,rootPath:rootPath,pathSave:pathSave},function(data1){
        //                       drawChart(data1); 
        //                       $("#chartmsg").html("地区"+row.C_DistrictBCDId+" 终端号"+row.C_AddressId+" 通道号"+row.C_ChannelId+" 录入时间"+row.C_RecordDateBCD+" 阶跃时间  "+row.C_JumpSecond+'<br/><a href="${basePath}/edata/downloadfile1.shtml"><font size="3" color="blue">下载当前图片P文件数据</font></a>'+'&nbsp;&nbsp;&nbsp;<a href="${basePath}/edata/downloadfile2.shtml"><font size="3" color="blue">下载当前图片Q文件数据</font></a>'+'&nbsp;&nbsp;&nbsp;<a href="${basePath}/edata/downloadfile3.shtml"><font size="3" color="blue">下载当前图片I_2文件数据</font></a>'+'&nbsp;&nbsp;&nbsp;<a href="${basePath}/edata/downloadfile4.shtml"><font size="3" color="blue">下载当前图片I_3文件数据</font></a>');
        //         }); 

    });
})
// window.operateEvents = {
//      'click': function (e, value, row, index) {
//          alert('You click like action, row: ' + JSON.stringify(row));
//      }
//  };
//  function jsonDateFormat(jsonDate) {
//             //json日期格式转换为正常格式
//             var jsonDateStr = jsonDate.toString();
//             //debugger;//此处用到toString（）是为了让传入的值为字符串类型，目的是为了避免传入的数据类型不支持.replace（）方法
//             try {
//                 var k = parseInt(jsonDateStr.replace("/Date(", "").replace(")/", ""), 10);
//                 if (k < 0) 
//                     return null;
//                 var date = new Date(parseInt(jsonDateStr.replace("/Date(", "").replace(")/", ""), 10));
//                 var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
//                 var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
//                 var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
//                 var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
//                 var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
//                 var milliseconds = date.getMilliseconds();
//                 return date.getFullYear() + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
//             }
//             catch (ex) {
//                 return "时间格式转换错误";
//             }}