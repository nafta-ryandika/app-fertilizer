$(document).ready(function() {
    viewData();
	// add('add','');
	$('#modalDetail').on('hidden.bs.modal', function () {
		$("#contentDetailsales").html("");
	})
});

$(function () {
    $('#inCustomer').select2({
		theme: 'bootstrap4'
	})
})

function viewData() {
	var rowTable = $('#tableSearch tr').length;
	var inWhere = "";
	var inSearchcolumn = "";
	var inSearchparameter = "";
	var inSearchinput = "";

	if (rowTable == 1) {
		inSearchcolumn = $('.inSearchcolumn').val();
		inSearchparameter = $('.inSearchparameter').val();
		inSearchinput = $('.inSearchinput').val();

		if (inSearchcolumn.trim() != "" && inSearchinput.trim() != "") {
			if (inSearchparameter == "=" || inSearchparameter == ">" || inSearchparameter == "<") {
				inWhere = " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'" + inSearchinput + "'"; 
			} else if (inSearchparameter == "like") {
				inWhere = " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'%" + inSearchinput.replace(" ","%") + "%'";
			}
		}
	}
	else if (rowTable > 1) {
		var inWhere = "";
		var inSearchcolumn = "";
		var inSearchparameter = "";
		var inSearchinput = "";
		var xSearchcolumn = [];
		var xSearchparameter = [];
		var xSearchinput = [];

		$('.inSearchcolumn').each(function(){ 
			xSearchcolumn.push($(this).val());
		});
		
		$('.inSearchparameter').each(function(){ 
			xSearchparameter.push($(this).val());
		});

		$('.inSearchinput').each(function(){ 
			xSearchinput.push($(this).val());
		});

		for (var i = 0; i < xSearchcolumn.length; i++) {
			inSearchcolumn = xSearchcolumn[i];
			inSearchparameter = xSearchparameter[i];
			inSearchinput = xSearchinput[i];

			if (inSearchcolumn.trim() != "" && inSearchinput.trim() != "") {
				if (inSearchparameter == "=" || inSearchparameter == ">" || inSearchparameter == "<") {
					inWhere += " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'" + inSearchinput + "'"; 
				} else if (inSearchparameter == "like") {
					inWhere += " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'%" + inSearchinput.replace(" ","%") + "%'";
				}
			}
		}
	}

	// console.log("test" + inWhere);
	// return;

	$.ajax({
		type: "POST",
		url: base_url+"inventory/viewData",
		data: {
				inWhere: inWhere
			},
		cache: false,
		success: function (data) {
			$('#tableArea').html(data);
			$(function () {
				$("#dataTable").DataTable();
			})
		}
	});
}

function get(param,obj,callBack) {
	if (param == "edit") {
		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: param,
				obj: obj
			},
			cache: false,
			dataType: "html",
			beforeSend: function (data) {
				$("#searchArea").hide();
				$("#dataArea").hide();
				$("#inputArea").show();
			},
			success: function (data) {
				$("#inputArea").html(data);
			}, 
			complete: function (data) {
				$("#inType").prop('disabled', true);
				$("a.btn.btn-success.m-1").addClass("disabled");
				$("a.btn.btn-secondary.m-1").addClass("disabled");
				$("a.btn.btn-danger.m-1").addClass("disabled");
			}
		})
	} else if (param == "searchColumn") {
			var rowIndex = $(obj).closest('tr').index();
			var searchColumn = $(obj).val();

			$('#tableSearch tr:eq('+rowIndex+') .col-5').html('<input type="text" class="form-control inSearchinput">');

			if (searchColumn == "date") {
				$('#tableSearch tr:eq('+rowIndex+') .inSearchinput').prop('type','date');
			} else if (searchColumn == "inventory_type_id") {
				get("searchColumn_"+searchColumn,"",function(data){
					$('#tableSearch tr:eq('+rowIndex+') .col-5').html(data);
				})
			} else if (searchColumn == "warehouse_id") {
				get("searchColumn_"+searchColumn,"",function(data){
					$('#tableSearch tr:eq('+rowIndex+') .col-5').html(data);
				})
			} else {
				$('#tableSearch tr:eq('+rowIndex+') .inSearchinput').prop('type','text');
			}
	} else if (param == "inWarehouse") {
		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: param,
				obj: obj
			},
			cache: false,
			dataType: "JSON",
			beforeSend: function(data) {
				$('#inWarehouse').select2({
					theme: 'bootstrap4'
				})
			},
			success: function (data) {
					var html = '<option value="">Select</option>';
					var i;
	
					for (i=0; i<data.res.length; i++) {
						if (obj.trim() != "" && obj == data.res[i].id) {
							html += '<option value="' + data.res[i].id + '" selected>' + data.res[i].warehouse + '</option>';	
						}
						else {
							html += '<option value="' + data.res[i].id + '">' + data.res[i].warehouse + '</option>';
						}
					}
	
					$('#inWarehouse').html(html);
			}
		});
	} else if (param == "inDgoods") {
		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: param,
				obj: obj
			},
			cache: false,
			dataType: "JSON",
			beforeSend: function(data) {
				$('.inDgoods').select2({
					theme: 'bootstrap4'
				})
			},
			success: function (data) {
					var html = '<option value="">Select</option>';
					var i;
	
					for (i=0; i<data.res.length; i++) {
						if (callBack.trim() != "" && callBack == data.res[i].id) {
							html += '<option value="' + data.res[i].id + '" data-unit="'+data.res[i].unit+'" data-unitid="'+data.res[i].unit_id+'" selected>' + data.res[i].goods + '</option>';	
						}
						else {
							html += '<option value="' + data.res[i].id + '" data-unit="'+data.res[i].unit+'" data-unitid="'+data.res[i].unit_id+'">' + data.res[i].goods + '</option>';
						}
					}
	
					$("#dataTable-input tr").eq(obj).find('.inDgoods').html(html);

					$('.inDgoods').on('select2:select', function () {
						var unit_id = $(this).find(":selected").data("unitid");
						var unit = $(this).find(":selected").data("unit");
						
						$(this).closest('tr').find('.inDunitid').val(unit_id);
						$(this).closest('tr').find('.inDunit').val(unit);
					});
			}
		});
	} else if (param == "detail") {
		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: param,
				obj: obj
			},
			cache: false,
			dataType: "JSON",
			success: function (data) {
				var data_header = data.header;
				var data_detail = data.detail;

				$('#modalDetail').modal('show').after(function (data) {
					$("#modalDetail .modal-dialog .modal-content .modal-body #txtId").text(data_header.inventory_id);
					$("#modalDetail .modal-dialog .modal-content .modal-body #txtDate").text(data_header.date);
					$("#modalDetail .modal-dialog .modal-content .modal-body #txtType").text(data_header.type);
					$("#modalDetail .modal-dialog .modal-content .modal-body #txtWarehouse").text(data_header.warehouse);
					$("#modalDetail .modal-dialog .modal-content .modal-body #txtTransaction").text(data_header.transaction_id);
					$("#modalDetail .modal-dialog .modal-content .modal-body #txtRemark").text(data_header.remark);
					
					if (data_detail.length > 0){
						var html = "<table class=\"table table-hover\" id=\"tableDetailsales\">\n\
										<tr>\n\
											<th scope=\"col\" style=\"text-align: center !important;\">Goods</th>\n\
											<th scope=\"col\" style=\"text-align: center !important;\">Qty</th>\n\
											<th scope=\"col\" style=\"text-align: center !important;\">Unit</th>\n\
										</tr>";

						for (var i = 0; i < data_detail.length; i++) {
							html += "<tr>\n\
										<td style=\"text-align: left !important;\">"+ data_detail[i].goods +"</td>\n\
										<td style=\"text-align: center !important;\">"+ parseFloat(data_detail[i].qty).toLocaleString('id-ID') +"</td>\n\
										<td style=\"text-align: center !important;\">"+ data_detail[i].unit +"</td>\n\
									</tr>";
						}

						html += "</table>";

						$('#contentDetailsales').html(html);
					}
				})
			}
		})
	} else if (param == "searchColumn_inventory_type_id") {
		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: "inType",
				obj: obj
			},
			cache: false,
			dataType: "JSON",
			beforeSend: function(data) {
				$('#inDivision').select2({
					dropdownParent: $('#modalAdd'),
					theme: 'bootstrap4'
				})
			},
			success: function (data) {
					var html = '<select class="form-control inSearchinput" style="width: 100%;">\n\
									<option value="">Select</option>';
					var i;

					for (i=0; i<data.res.length; i++) {
						html += '<option value="' + data.res[i].id + '">' + data.res[i].type + '</option>';
					}

					html += '</select>';

					callBack(html);
			}
		});
	} else if (param == "searchColumn_warehouse_id") {
		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: "inWarehouse",
				obj: obj
			},
			cache: false,
			dataType: "JSON",
			beforeSend: function(data) {
				$('#inDivision').select2({
					dropdownParent: $('#modalAdd'),
					theme: 'bootstrap4'
				})
			},
			success: function (data) {
					var html = '<select class="form-control inSearchinput" style="width: 100%;">\n\
									<option value="">Select</option>';
					var i;

					for (i=0; i<data.res.length; i++) {
						html += '<option value="' + data.res[i].id + '">' + data.res[i].warehouse + '</option>';
					}

					html += '</select>';

					callBack(html);
			}
		});
	} else if (param == "input") {
		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: param,
				obj:obj
			},
			cache: false,
			beforeSend: function (data) {
				$("#searchArea").hide();
				$("#dataArea").hide();
				$("#inputArea").show();
			},
			success: function (data) {
				$("#inputArea").html(data);
				$(function () {
					$("#dataTable-input").DataTable( {
						"bInfo" : false,
						"paging": false,
						"ordering": false,
						"searching":false,
						"columnDefs": [{ width: '20%', targets: 0 }]
					});
				})

				var today = new Date().toISOString().split('T')[0];
				$("#inDate").val(today);
				get("inWarehouse","","");
				get("inDgoods","1","");
				
				$('#inCustomer').select2({
					theme: 'bootstrap4'
				})
			},
			complete: function (data) {
				$("#inMode").val("add");
				$("#inType").focus();
			}
		});
	} else if (param == "searchTransaction") {
		var inType = $("#inType").val();
		var inTransaction = $("#inTransaction").val();

		if (obj.trim() != "") {
			inTransaction = obj;	
		}
		
		var data = [{
					inType: inType,
					inTransaction: inTransaction
					}];  

		$.ajax({
			type: "POST",
			url: base_url+"inventory/get",
			data: {
				param: param,
				obj: obj,
				data: data
			},
			cache: false,
			dataType: "JSON",
			beforeSend: function(data) {
				Swal.fire({
					title: "Please Wait!",
					didOpen: () => {
						Swal.showLoading();
					}
				})
			},
			success: function (data) {
				if (data.status == 1) {
					set("detail", data.res);

					if($('#modalSearchtransaction').hasClass('show')){
						$('#modalSearchtransaction').modal('toggle');
					}

					Swal.close();
					
				} else if (data.status == 0) {
					var data_transaction = data.res;
					var data_inType = data.inType;

					$('#modalSearchtransaction').modal('show').after(function (data) {
						if (data_transaction.length > 0){
							Swal.close();

							var htmlHeader = "";

							$('#dataTable-modalTransaction thead').empty().after(function(){
								if (data_inType == 1) {
									htmlHeader = "<tr>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">ID</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Date</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Due Date</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Type</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Supplier</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Goods</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Qty</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Unit</th>\n\
												</tr>";
								} else if (data_inType == 2) {
									htmlHeader = "<tr>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">ID</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Date</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Type</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Warehouse</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Goods</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Qty</th>\n\
													<th scope=\"col\" style=\"text-align: center !important;\">Unit</th>\n\
												</tr>";
								}
							})

							$('#dataTable-modalTransaction thead').append(htmlHeader);

							var html = "";
							$('#dataTable-modalTransaction tbody').empty().after(function(){
								for (var i = 0; i < data_transaction.length; i++) {
									if (data_inType == 1) {
										html = "<tr onclick=\"get('searchTransaction', '"+ data_transaction[i].purchase_id +"', ''); $('#inTransaction').val('"+ data_transaction[i].purchase_id +"')\">\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].purchase_id +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].date +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].due_date +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].type +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].supplier +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].goods +"</td>\n\
													<td style=\"text-align: center !important;\">"+ parseFloat(data_transaction[i].qty).toLocaleString('id-ID') +"</td>\n\
													<td style=\"text-align: center !important;\">"+ data_transaction[i].unit +"</td>\n\
												</tr>";
									} else if (data_inType == 2) {
										html = "<tr onclick=\"get('searchTransaction', '"+ data_transaction[i].inventory_id +"', ''); $('#inTransaction').val('"+ data_transaction[i].inventory_id +"')\">\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].inventory_id +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].date +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].type +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].warehouse +"</td>\n\
													<td style=\"text-align: left !important;\">"+ data_transaction[i].goods +"</td>\n\
													<td style=\"text-align: center !important;\">"+ parseFloat(data_transaction[i].qty).toLocaleString('id-ID') +"</td>\n\
													<td style=\"text-align: center !important;\">"+ data_transaction[i].unit +"</td>\n\
												</tr>";
									}
										

									$('#dataTable-modalTransaction tbody').append(html);
								}
							})

							$("#dataTable-modalTransaction").DataTable();
						}
						else {
							Swal.close();
							Swal.fire({
								title: "Data Not Found !",
								icon: "error"
							})

							$('#dataTable-input tbody').empty();
							add('detailEmpty','');
						}
					})
				} else {
					Swal.close();
					Swal.fire({
						title: "Data Not Found !",
						icon: "error"
					})

					$('#dataTable-input tbody').empty();
					add('detailEmpty','');
				}
			},
			complete: function (data) {
			}
		});
	}
}

function set(param,obj){
	if(param == "detail"){
		if (obj.length > 0){
			$('#dataTable-input tbody').empty().after(function(){
				var html = "";

				for (var i = 0; i < obj.length; i++) {
					html = '<tr>\n\
									<td scope="row">\n\
										<select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" required>\n\
											<option value="">Select</option>\n\
										</select>\n\
									</td>\n\
									<td scope="row">\n\
										<input type="number" class="form-control text-right inDqty" name="inDqty" qty-max=\"'+parseFloat(obj[i].qty).toLocaleString('id-ID')+'\" value="' + parseFloat(obj[i].qty).toLocaleString('id-ID') + '" onfocus="$(this).select();" required>\n\
									</td>\n\
									<td scope="row">\n\
										<input type="text" class="form-control inDunit" name="inDunit" value="' +obj[i].unit+ '" readonly disabled required>\n\
										<input type="hidden" class="form-control inDunitid" name="inDunitid" value="' + obj[i].unit_id + '" readonly disabled>\n\
									</td>\n\
									<td>\n\
										<a class="btn btn-success m-1 disabled" id="btnDetail" title="Detail" onclick="add(\'detail\',\'\')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>\n\
										<a class="btn btn-danger m-1 disabled" id="btnDelete" title="Delete" onclick="remove(\'detail\',this)"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>\n\
									</td>\n\
								</tr>';
								
								$('#dataTable-input tbody').append(html);

								var j = i;
								j++

								get("inDgoods",j,obj[i].goods_id);		
				}
			});
		}
	}
}

function report(param,obj){
	var rowTable = $('#tableSearch tr').length;
	var inWhere = "";

	if (rowTable == 1) {
		var inSearchcolumn = $('.inSearchcolumn').val();
		var inSearchparameter = $('.inSearchparameter').val();
		var inSearchinput = $('.inSearchinput').val();

		if (inSearchcolumn.trim() != "" && inSearchinput.trim() != "") {
			if (inSearchparameter == "=" || inSearchparameter == ">" || inSearchparameter == "<") {
				inWhere = "AND " + inSearchcolumn + " " + inSearchparameter + " " +"'" + inSearchinput + "'"; 
			} else if (inSearchparameter == "like") {
				inWhere = "AND " + inSearchcolumn + " " + inSearchparameter + " " +"'%" + inSearchinput.replace(" ","%") + "%'";
			}
		}
	}
	else if (rowTable > 1) {
		var inWhere = "";
		var inSearchcolumn = "";
		var inSearchparameter = "";
		var inSearchinput = "";
		var xSearchcolumn = [];
		var xSearchparameter = [];
		var xSearchinput = [];

		$('.inSearchcolumn').each(function(){ 
			xSearchcolumn.push($(this).val());
		});
		
		$('.inSearchparameter').each(function(){ 
			xSearchparameter.push($(this).val());
		});

		$('.inSearchinput').each(function(){ 
			xSearchinput.push($(this).val());
		});

		for (var i = 0; i < xSearchcolumn.length; i++) {
			inSearchcolumn = xSearchcolumn[i];
			inSearchparameter = xSearchparameter[i];
			inSearchinput = xSearchinput[i];

			if (inSearchcolumn.trim() != "" && inSearchinput.trim() != "") {
				if (inSearchparameter == "=" || inSearchparameter == ">" || inSearchparameter == "<") {
					inWhere += " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'" + inSearchinput + "'"; 
				} else if (inSearchparameter == "like") {
					inWhere += " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'%" + inSearchinput.replace(" ","%") + "%'";
				}
			}
		}
	}

	if (param == "pdf") {
		if (obj == "sales") {
			window.open(base_url+'inventory/report?param='+param+'&obj='+obj+'&where='+encodeURIComponent(inWhere), '_blank');
		}
	}
	else if (param == "excel") {
		if (obj == "sales") {
			window.open(base_url+'inventory/report?param='+param+'&obj='+obj+'&where='+encodeURIComponent(inWhere), '_blank');
		}
	} else if (param == "print") {
		$('#modalPrint').modal('show').after(function (data) {
			$("#contentPrint").attr("src",base_url+'inventory/report?param='+param+'&obj='+obj);
		})
	}
}

function add(param,obj){
	if (param == "parameter") {
		var html = '<tr>\n\
						<td>\n\
							<div class="row col-12">\n\
								<div class="col-8 m-2">\n\
									<div class="form-group row">\n\
										<div class="col-3">\n\
											<select class="form-control inSearchcolumn" style="width: 100%;" onchange="get(\'searchColumn\',this,\'\')">\n\
												<option value="dt1.inventory_id">ID</option>\n\
												<option value="date">Date</option>\n\
												<option value="inventory_type_id">Type</option>\n\
												<option value="warehouse_id">Warehouse</option>\n\
												<option value="transaction_id">Transaction ID</option>\n\
											</select>\n\
										</div>\n\
										<div class="col-2">\n\
											<select class="form-control inSearchparameter" style="width: 100%;">\n\
												<option value="=">Equal</option>\n\
												<option value="like">Like</option>\n\
												<option value=">">Greater Than</option>\n\
												<option value="<">Less Than</option>\n\
											</select>\n\
										</div>\n\
										<div class="col-5">\n\
											<input type="text" class="form-control inSearchinput">\n\
										</div>\n\
										<div class="col-2">\n\
											<a class="btn btn-danger" id="btnRemove" title="Remove" onclick="remove(\'parameter\',this)"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>\n\
										</div>\n\
									</div>\n\
								</div>\n\
							</div>\n\
						</td>\n\
					<tr/>';

		$('#tableSearch tr:last').after(html);
	} else if (param == "add") {
		if (obj.trim() == "") {
			get("input","","").after(function(){
				
			});
		}
	} else if (param == "detail") {
		var html = '<tr>\n\
						<td scope="row">\n\
							<select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" required>\n\
								<option value="">Select</option>\n\
							</select>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="number" class="form-control text-right inDqty" name="inDqty" onfocus="$(this).select();" required>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="text" class="form-control inDunit" name="inDunit" readonly disabled required>\n\
							<input type="hidden" class="form-control inDunitid" name="inDunitid" readonly disabled>\n\
						</td>\n\
						<td>\n\
							<a class="btn btn-success m-1" id="btnDetail" title="Detail" onclick="add(\'detail\',\'\')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>\n\
							<a class="btn btn-danger m-1" id="btnDelete" title="Delete" onclick="remove(\'detail\',this)"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>\n\
						</td>\n\
					</tr>';
		$('#dataTable-input tr:last').after(html);
		var numRow = $('#dataTable-input tbody tr').length;
		get("inDgoods",numRow,"");
	} else if (param == "detailEmpty") {
		var html = '<tr>\n\
						<td scope="row">\n\
							<select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" required>\n\
								<option value="">Select</option>\n\
							</select>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="number" class="form-control text-right inDqty" name="inDqty" onfocus="$(this).select();" required>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="text" class="form-control inDunit" name="inDunit" readonly disabled required>\n\
							<input type="hidden" class="form-control inDunitid" name="inDunitid" readonly disabled>\n\
						</td>\n\
						<td>\n\
							<a class="btn btn-success m-1" id="btnDetail" title="Detail" onclick="add(\'detail\',\'\')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>\n\
							<a class="btn btn-danger m-1 disabled" id="btnDelete" title="Delete" onclick="remove(\'detail\',this)"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>\n\
						</td>\n\
					</tr>';

		$('#dataTable-input tr:last').after(html);
		get("inDgoods",1,"");
	}
}

function save(param,obj){
	if (param == 'data') {
		var  inMode = $('#inMode').val();
		var  inIdx = $('#inIdx').val();
		var  inId = $('#inId').val();
		var  inDate = $('#inDate').val();
		var  inType = $('#inType').val();
		var  inWarehouse = $('#inWarehouse').val();
		var  inTransaction = $('#inTransaction').val();
		var  inRemark = $('#inRemark').val();
		var  inStatus = $('#inStatus').val();

		var inDidx = "";
		var inDgoods = "";
		var inDqty = "";
		var inDunitid = "";
		var inDstatus = "";
		var inDremove = $("#inDremove").val();

		$(".inDidx").each(function(){
			inDidx  += $(this).val()+"|";
		})

		$(".inDgoods").each(function(){
			inDgoods  += $(this).val()+"|";
		})
		
		$(".inDqty").each(function(){
			inDqty  += $(this).val()+"|";
		})
		
		$(".inDunitid").each(function(){
			inDunitid  += $(this).val()+"|";
		})

		$(".inDstatus").each(function(){
			inDstatus  += $(this).val()+"|";
		})

		if (inType.trim() == "") {
			Swal.fire({
				title: "Input Type Empty !",
				icon: "error"
			}).then(function () { 
				$("#inType").focus();
				return;
			});
		} else if (inWarehouse.trim() == "") {
			Swal.fire({
				title: "Input Warehouse Empty !",
				icon: "error"
			}).then(function () { 
				$("#inWarehouse").focus();
				return;
			});
		} else if (inTransaction.trim() == "") {
			Swal.fire({
				title: "Input Transaction Empty !",
				icon: "error"
			}).then(function () { 
				$("#inTransaction").focus();
				return;
			});
		} else {
			var check = true;

			$(".inDgoods").each(function(){
				var dqtyx = $(this).closest('tr').find('.inDqty').val();
				var dqtyxMax = $(this).closest('tr').find('input').attr('qty-max');
				var dunitx = $(this).closest('tr').find('.inDunit').val();
					
				if ($(this).val().trim() == "") {
					if (dqtyx.trim() != "" || dunitx.trim() != ""){
						Swal.fire({
							title: "Please Check Inventory Details",
							icon: "error"
						}).then(function () { 
							$(this).focus();
							return;
						});

						check = false;
					}
				} else if ($(this).val().trim() != "") {
					if (dqtyx.trim() == "" || dunitx.trim() == ""){
						Swal.fire({
							title: "Please Check Inventory Details",
							icon: "error"
						}).then(function () { 
							$(this).focus();
							return;
						});

						check = false;
					}

					if (inType == 2) {
						if (dqtyx > dqtyxMax) {
							Swal.fire({
								title: "Qty Exceeds Limit !",
								icon: "error"
							}).then(function () { 
								$(this).focus();
								return;
							});

							check = false;
						}
					}
				}
			})

			if(check) {
				var data = [{inMode: inMode,
					inIdx: inIdx,
					inId: inId,
					inDate: inDate,
					inType: inType,
					inWarehouse: inWarehouse,
					inTransaction: inTransaction,
					inRemark: inRemark,
					inStatus: inStatus,
					inDidx: inDidx,
					inDgoods: inDgoods,
					inDqty: inDqty,
					inDunitid: inDunitid,
					inDstatus: inDstatus,
					inDremove: inDremove}];  
		
				$.ajax({
					type: "POST",
					url: base_url+"inventory/save",
					data: {
							param: param,
							obj: obj,
							data: data
						},
					cache: false,
					dataType: "JSON",
					success: function (data) {
						if (data.res == 'success') {
							Swal.fire({
								title: "Data Saved!",
								icon: "success",
								timer: 1000
							}).then(function () { 
								if (inMode == "add") {
									get("input","","");
								} else if (inMode == "edit") {
									exit('save','');
								}
							});
						} else if (date.err == '') {
							console.log(data.err);
						} 
					}
				});
			}
		}
	}
}

function clear(param,obj) {
	
}

function remove(param,obj) {
	const swalWithBootstrapButtons = Swal.mixin({
		customClass: {
			confirmButton: "btn btn-lg btn-success m-3",
			cancelButton: "btn btn-lg btn-danger m-3"
		},
		buttonsStyling: false
	});

	if (param == "parameter") {
		$(obj).closest('tr').remove();
	} else if (param == "data") {
		swalWithBootstrapButtons.fire({
			title: "Are you sure?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonText: "Yes",
			cancelButtonText: "No",
			reverseButtons: true
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: "POST",
					url: base_url+"inventory/remove",
					data: {
						param: param,
						obj: obj
					},
					cache: false,
					dataType: "JSON",
					success: function (data) {
						if (data.res == 'success') {
							swalWithBootstrapButtons.fire({
								title: "Deleted!",
								icon: "success"
							}).then(function () { 
								viewData();
							});
						} else if (date.err == '') {
							console.log(data.err);
						} 
					}
				});
			} else if (
				result.dismiss === Swal.DismissReason.cancel
			) {
				swalWithBootstrapButtons.fire({
					title: "Cancelled",
					icon: "error"
				});
			}
		});
	} else if (param == "detail") { 
		swalWithBootstrapButtons.fire({
			title: "Are you sure?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonText: "Yes",
			cancelButtonText: "No",
			reverseButtons: true
		}).then((result) => {
			if (result.isConfirmed) {
				var inDremove = $("#inDremove").val(); 
				inDremove += $(obj).closest('tr').find('.inDidx').val() + "|";
				$("#inDremove").val(inDremove);

				$(obj).closest('tr').remove();
				
				var rowCount = $('#dataTable-input tbody tr').length;
				
				if (rowCount == 0) {
					add('detail','');
				}

				count("subtotal","");
			}
		});
	}
}

function check(param,obj) {
	if (param == "qtyMax") {
		
	}
}

function count (param,obj){
	if (param == "subtotal") {
		var inDqty = $(obj).closest("tr").find(".inDqty").val();
		var inDprice = $(obj).closest("tr").find(".inDprice").val();
		var inDdiscount = $(obj).closest("tr").find(".inDdiscount").val();
		var subtotal = 0;

		if (inDqty > 0 && inDprice) {
			if (inDdiscount > 0) {
				subtotal = inDqty * inDprice * (1 - (inDdiscount/100));
			} else {
				subtotal = inDqty * inDprice;
			}
		}

		if(!isNaN(subtotal)) {
			$(obj).closest("tr").find(".inDsubtotal").val(subtotal);
		}
		var total = 0;
		var inDiscount = $("#inDiscount").val();
		var inTax = $("#inTax").val();

		$(".inDsubtotal").each(function () {
			total = parseFloat(total) + parseFloat($(this).val());
		})
		
		total = total * (1 - (inDiscount/100));

		total = total + (total * (inTax/100));

		if(!isNaN(total)) {
			$("#inTotal").val(total);
		} else {
			$("#inTotal").val(0);
		}
	} else if (param == "total") {
		var total = 0;
		var inDiscount = $("#inDiscount").val();
		var inTax = $("#inTax").val();

		$(".inDsubtotal").each(function () {
			total = parseFloat(total) + parseFloat($(this).val());
		})
		
		total = total * (1 - (inDiscount/100));

		total = total + (total * (inTax/100));

		if(!isNaN(total)) {
			$("#inTotal").val(total);
		} else {
			$("#inTotal").val(0);
		}
	}
}

function exit (param,obj){
	if (param == "input") {
		const swalWithBootstrapButtons = Swal.mixin({
			customClass: {
				confirmButton: "btn btn-lg btn-success m-3",
				cancelButton: "btn btn-lg btn-danger m-3"
			},
			buttonsStyling: false
		});

		swalWithBootstrapButtons.fire({
			title: "Close Input?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonText: "Yes",
			cancelButtonText: "No",
			reverseButtons: true
		}).then((result) => {
			if (result.isConfirmed) {
				$('#inMode').val("");
				$("#inputArea").hide();
				$("#searchArea").show();
				$("#dataArea").show();
				viewData();
			} else if (
				result.dismiss === Swal.DismissReason.cancel
			) {
				swalWithBootstrapButtons.fire({
					title: "Cancelled",
					icon: "error"
				});
			}
		});
	} else if (param == "save") {
		$('#inMode').val("");
		$("#inputArea").hide();
		$("#searchArea").show();
		$("#dataArea").show();
		viewData();
	}
}