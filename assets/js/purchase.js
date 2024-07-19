$(document).ready(function() {
    viewData();
});

$(function () {
    $('#inSupplier').select2({
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
		url: base_url+"purchase/viewData",
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
			url: base_url+"purchase/get",
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
				get("inSupplier","","");
			},
			success: function (data) {
				// console.log("test"+param);
				// console.log(data);
				// var user_data = data.res;
				$("#inputArea").html(data);
				// $("#inputArea").html(data.html).after(function (data) {
				// 	$('#inMode').val('edit');

				// console.log("test"+data.header);
				// 	// get("inDepartment",user_data.department_id,"");
				// 	// get("inDivision",user_data.department_id,user_data.division_id);
				// 	// get("inRole",user_data.role_id,"");
				// 	// $("#inIdx").val(user_data.id);
				// 	// $("#inId").val(user_data.user_id);
				// 	// $("#inName").val(user_data.name);	
				// 	// $("#inEmail").val(user_data.email);	

				// 	// $("#inPassword").closest("div").parent("div").hide();
				// 	// $("#inRepeatpassword").closest("div").parent("div").hide();
				// 	// $("#inStatus").val(user_data.status);
				// })
			},
			complete: function(data){
				// get("inSupplier","","");
			}
		})
	} else if (param == "searchColumn") {
			var rowIndex = $(obj).closest('tr').index();
			var searchColumn = $(obj).val();

			$('#tableSearch tr:eq('+rowIndex+') .col-5').html('<input type="text" class="form-control inSearchinput">');

			if (searchColumn == "date" || searchColumn == "due_date") {
				$('#tableSearch tr:eq('+rowIndex+') .inSearchinput').prop('type','date');
			} else if (searchColumn == "purchase_type_id") {
				get("searchColumn_"+searchColumn,"",function(data){
					$('#tableSearch tr:eq('+rowIndex+') .col-5').html(data);
				})
			} else if (searchColumn == "supplier_id") {
				get("searchColumn_"+searchColumn,"",function(data){
					$('#tableSearch tr:eq('+rowIndex+') .col-5').html(data);
				})
			} else {
				$('#tableSearch tr:eq('+rowIndex+') .inSearchinput').prop('type','text');
			}
	} else if (param == "inSupplier") {
		$.ajax({
			type: "POST",
			url: base_url+"purchase/get",
			data: {
				param: param,
				obj: obj
			},
			cache: false,
			dataType: "JSON",
			beforeSend: function(data) {
				$('#inSupplier').select2({
					theme: 'bootstrap4'
				})
			},
			success: function (data) {
					var html = '<option value="">Select</option>';
					var i;
	
					for (i=0; i<data.res.length; i++) {
						if (obj.trim() != "" && obj == data.res[i].id) {
							html += '<option value="' + data.res[i].id + '" selected>' + data.res[i].supplier + '</option>';	
						}
						else {
							html += '<option value="' + data.res[i].id + '">' + data.res[i].supplier + '</option>';
						}
					}
	
					$('#inSupplier').html(html);
			}
		});
	} else if (param == "inDgoods") {
		$.ajax({
			type: "POST",
			url: base_url+"purchase/get",
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
			url: base_url+"user_management/get",
			data: {
				param: param,
				obj: obj
			},
			cache: false,
			dataType: "JSON",
			success: function (data) {
				var user_data = data.res;

				$('#modalDetail').modal('show').after(function (data) {
					$("#modalDetail .modal-dialog .modal-content .modal-body #inId").text(user_data.user_id);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inName").text(user_data.name);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inDepartment").text(user_data.department);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inDivision").text(user_data.division);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inRole").text(user_data.role);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inEmail").text(user_data.email);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inImage").attr("src",base_url+"assets/img/profile/"+user_data.image);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inStatus").text(user_data.status);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inCreated_by").text(user_data.created_by);
					$("#modalDetail .modal-dialog .modal-content .modal-body #inCreated_at").text(user_data.created_at);
					
					// get("inDepartment",user_data.department_id,"");
					// get("inDivision",user_data.department_id,user_data.division_id);
					// get("inRole",user_data.role_id,"");
					// $("#inIdx").val(user_data.id);
					// $("#inId").val(user_data.user_id);
					// $("#inName").val(user_data.name);	

					// $("#inPassword").closest("div").parent("div").hide();
					// $("#inRepeatpassword").closest("div").parent("div").hide();
					// $("#inStatus").val(user_data.status);
				})
			}
		})
	} else if (param == "searchColumn_purchase_type_id") {
		$.ajax({
			type: "POST",
			url: base_url+"purchase/get",
			data: {
				param: "type",
				obj: obj
			},
			cache: false,
			dataType: "JSON",
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
	} else if (param == "searchColumn_supplier_id") {
		$.ajax({
			type: "POST",
			url: base_url+"purchase/get",
			data: {
				param: "inSupplier",
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
						html += '<option value="' + data.res[i].id + '">' + data.res[i].supplier + '</option>';
					}

					html += '</select>';

					callBack(html);
			}
		});
	} else if (param == "input") {
		$.ajax({
			type: "POST",
			url: base_url+"purchase/get",
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
				get("inSupplier","","");
				get("inDgoods","1","");	
			},
			complete: function (data) {
				$("#inMode").val("add");
				$("#inType").focus();
			}
		});
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
			if (inSearchparameter == "=") {
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
				if (inSearchparameter == "=") {
					inWhere += " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'" + inSearchinput + "'"; 
				} else if (inSearchparameter == "like") {
					inWhere += " AND " + inSearchcolumn + " " + inSearchparameter + " " +"'%" + inSearchinput.replace(" ","%") + "%'";
				}
			}
		}
	}

	if (param == "pdf") {
		if (obj == "user") {
			window.open(base_url+'report/user_management?param='+param+'&obj='+obj+'&where='+encodeURIComponent(inWhere), '_blank');
		}
	}
	else if (param == "excel") {
		if (obj == "user") {
			window.open(base_url+'report/report?param='+param+'&obj='+obj+'&where='+encodeURIComponent(inWhere), '_blank');
		}
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
												<option value="">Parameter</option>\n\
												<option value="purchase_id">ID</option>\n\
												<option value="date">Date</option>\n\
												<option value="purchase_type_id">Type</option>\n\
												<option value="supplier_id">Supplier</option>\n\
												<option value="due_date">Due Date</option>\n\
												<option value="total">Total</option>\n\
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
		// $("#contentArea").html("");
	} else if (param == "detail") {
		var html = '<tr>\n\
						<td scope="row">\n\
							<select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" required>\n\
								<option value="">Select</option>\n\
							</select>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="number" class="form-control text-right inDqty" name="inDqty" onkeyup="count(\'subtotal\',this)" required>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="text" class="form-control inDunit" name="inDunit" readonly disabled required>\n\
							<input type="hidden" class="form-control inDunitid" name="inDunitid" readonly disabled>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="number" class="form-control text-right inDprice" name="inDprice" onkeyup="count(\'subtotal\',this)" required>\n\
						</td>\n\
						<td scope="row">\n\
							<input type="number" class="form-control inDdiscount" name="inDdiscount" onkeyup="count(\'subtotal\',this)">\n\
						</td>\n\
						<td scope="row">\n\
							<input type="number" class="form-control text-right inDsubtotal" name="inDsubtotal" required>\n\
						</td>\n\
						<td>\n\
							<a class="btn btn-success m-1" id="btnDetail" title="Detail" onclick="add(\'detail\',\'\')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>\n\
							<a class="btn btn-danger m-1" id="btnDelete" title="Delete" onclick="remove(\'detail\',this)"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>\n\
						</td>\n\
					</tr>';
		$('#dataTable-input tr:last').after(html);
		var numRow = $('#dataTable-input tbody tr').length;
		get("inDgoods",numRow,"");
		// console.log(numRow);
	}
}

function save(param,obj){
	if (param == 'data') {
		var  inMode = $('#inMode').val();
		var  inIdx = $('#inIdx').val();
		var  inId = $('#inId').val();
		var  inDate = $('#inDate').val();
		var  inType = $('#inType').val();
		var  inSupplier = $('#inSupplier').val();
		var  inDuedate = $('#inDuedate').val();
		var  inRemark = $('#inRemark').val();
		var  inDiscount = parseFloat($('#inDiscount').val());
		var  inTax = parseFloat($('#inTax').val());
		var  inTotal = parseFloat($('#inTotal').val());

		var inDidx = "";
		var inDgoods = "";
		var inDqty = "";
		var inDunitid = "";
		var inDprice = "";
		var inDdiscount = "";
		var inDsubtotal = "";
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
		
		$(".inDprice").each(function(){
			inDprice  += $(this).val()+"|";
		})
		
		$(".inDdiscount").each(function(){
			inDdiscount  += $(this).val()+"|";
		})
		
		$(".inDsubtotal").each(function(){
			inDsubtotal  += $(this).val()+"|";
		})

		if (inType.trim() == "") {
			Swal.fire({
				title: "Input Type Empty !",
				icon: "error"
			}).then(function () { 
				$("#inType").focus();
				return;
			});
		} else if (inSupplier.trim() == "") {
			Swal.fire({
				title: "Input Supplier Empty !",
				icon: "error"
			}).then(function () { 
				$("#inSupplier").focus();
				return;
			});
		} else if (inDuedate.trim() == "") {
			Swal.fire({
				title: "Input Due Date Empty !",
				icon: "error"
			}).then(function () { 
				$("#inDuedate").focus();
				return;
			});
		} else {
			var check = true;

			$(".inDgoods").each(function(){
				var dqtyx = $(this).closest('tr').find('.inDqty').val();
				var dunitx = $(this).closest('tr').find('.inDunit').val();
				var dpricex = $(this).closest('tr').find('.inDprice').val();
				var dsubtotalx = $(this).closest('tr').find('.inDsubtotal').val();
					
				if ($(this).val().trim() == "") {
					if (dqtyx.trim() != "" || dunitx.trim() != "" || dpricex.trim() != "" || dsubtotalx.trim() != ""){
						Swal.fire({
							title: "Please Check Puchase Order Details",
							icon: "error"
						}).then(function () { 
							$(this).focus();
							return;
						});

						check = false;
					}
				} else if ($(this).val().trim() != "") {
					if (dqtyx.trim() == "" || dunitx.trim() == "" || dpricex.trim() == "" || dsubtotalx.trim() == ""){
						Swal.fire({
							title: "Please Check Puchase Order Details",
							icon: "error"
						}).then(function () { 
							$(this).focus();
							return;
						});

						check = false;
					}
				}
			})

			if(check) {
				var data = [{inMode: inMode,
					inIdx: inIdx,
					inId: inId,
					inDate: inDate,
					inType: inType,
					inSupplier: inSupplier,
					inDuedate: inDuedate,
					inRemark: inRemark,
					inDiscount: inDiscount,
					inTax: inTax,
					inTotal: inTotal,
					inDidx: inDidx,
					inDgoods: inDgoods,
					inDqty: inDqty,
					inDunitid: inDunitid,
					inDprice: inDprice,
					inDdiscount: inDdiscount,
					inDsubtotal: inDsubtotal,
					inDremove: inDremove}];  
		
				$.ajax({
					type: "POST",
					url: base_url+"purchase/save",
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
	// console.log("test");
	if (param == "user") {
		$('#inId').val("");
		$('#inName').val("");

		if (obj == "add") {
			$('#inMode').val('add');
		} else {
			$('#inMode').val("");
		}
		
		$('#inDepartment').val("");
		$('#inDivision').val("");
		$('#inRole').val("");
		$('#inEmail').val("");
		$('#inImage').val("");
		$('#inPassword').val("");
		$('#inRepeatpassword').val("");
		$('#inStatus').val("");

		$("#formAdd").removeClass("was-validated");
		$("input").removeClass("is-invalid");

		get("inDepartment","inDepartment","");
		get("inRole","inRole","");

		$("#inPassword").closest("div").parent("div").show();
		$("#inRepeatpassword").closest("div").parent("div").show();

		$("#modalAdd #inPassword").prop("required",true);
		$("#modalAdd #inRepeatpassword").prop("required",true);
	}
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
					url: base_url+"user_management/remove",
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
			}
		});
	}
}

function check(param,obj) {

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