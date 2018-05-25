$(function() {
	function Add_DisAdd(Province_Selected_Id) {
		$("#city").empty();
		$("#city").append("<option>City</option>");
		$("#country").empty();
		$("#country").append("<option>Country</option>");
		//上面的两次清空与两次添加是为了保持级联的一致性
		var province_dict = Place_dict[Province_Selected_Id]; //获得一个省的字典
		for (city in province_dict) { //取得省的字典中的城市
			//添加内容的同时在option标签中添加对应的城市ID
			var text = "<option" + " id='" + city + "'>" + city + "</option>";
			$("#city").append(text);
			console.log(text); //用来观察生成的text数据
		}
	}
	//加载城市选项
	function Add_city(Province_Selected_Id) {
		$("#city").empty();
		$("#city").append("<option>City</option>");
		$("#country").empty();
		$("#country").append("<option>Country</option>");
		//上面的两次清空与两次添加是为了保持级联的一致性
		var province_dict = Place_dict[Province_Selected_Id]; //获得一个省的字典
		for (city in province_dict) { //取得省的字典中的城市
			//添加内容的同时在option标签中添加对应的城市ID
			var text = "<option" + " id='" + city + "'>" + city + "</option>";
			$("#city").append(text);
			console.log(text); //用来观察生成的text数据
		}
	}
	//加载县区选项
	function Add_country(City_Selected_Id) {
		$("#country").empty();
		$("#country").append("<option>Country</option>");
		//上面的清空与添加是为了保持级联的一致性
		var Province_Selected_ID = Get_Selected_Id("province"); //获得被选中省的ID，从而方便在字典中加载数据
		var country_list = Place_dict[Province_Selected_ID][City_Selected_Id]; //获得城市列表
		for (index in country_list) {
			////添加内容的同时在option标签中添加对应的县区ID
			var text = "<option" + " id=\'" + country_list[index] + "\'>" + country_list[index] + "</option>";
			$("#country").append(text);
			console.log(text); //用来观察生成的text数据
		}
	}
	var Place_dict = "";
	$().$.ajax({
			url: '${basePath}/edata/listLSDevice.shtml',
			type: 'POST',
			dataType: 'json'
		})
		.done(function(data) {
			console.log("success");
			Place_dict = data;
			for (var i = 0; i < data.length; i++) {
				var text = "<option" + " id='" + city + "'>" + city + "</option>";
				$("#cDistrictbcdid").append(text);
			}
			$('#cDistrictbcdid').html('<option value="${x}">'++'</option>');

		})
		.fail(function() {
			console.log("error");
		})
		.always(function() {
			console.log("complete");
		});

});