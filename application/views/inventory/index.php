<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800"><?= $title; ?></h1>

    <div class="row content" id="contentArea">
        <div class="col-lg-12" id="searchArea">
            <div class="card shadow mt-4 mb-4">
                <!-- Card Header - Accordion -->
                <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
                    <h6 class="m-0 font-weight-bold text-primary">Search Data</h6>
                </a>
                <!-- Card Content - Collapse -->
                <div class="collapse show" id="collapseCardExample" style="">
                    <table id="tableSearch" width="100%">
                        <tr>
                            <td>
                                <div class="row col-12">
                                    <div class="col-12 m-2">
                                        <div class="content" id="btnArea">
                                            <a class="btn btn-success col-1" id="btnAdd" title="Add" onclick="add('add','')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i>Add</a>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="row col-12">
                                    <div class="col-8 m-2">
                                        <div class="form-group row">
                                            <div class="col-3">
                                                <select class="form-control inSearchcolumn" style="width: 100%;" onchange="get('searchColumn',this,'')">
                                                    <option value="sales_id">ID</option>
                                                    <option value="date">Date</option>
                                                    <option value="customer_id">Customer</option>
                                                    <option value="due_date">Due Date</option>
                                                    <option value="total">Total</option>
                                                </select>
                                            </div>
                                            <div class="col-2">
                                                <select class="form-control inSearchparameter" style="width: 100%;">
                                                    <option value="=">Equal</option>
                                                    <option value="like">Like</option>
                                                    <option value=">">Greater Than</option>
                                                    <option value="<">Less Than</option>
                                                </select>
                                            </div>
                                            <div class="col-5">
                                                <input type="text" class="form-control inSearchinput">
                                            </div>
                                            <div class="col-2">
                                                <a class="btn btn-success" id="btnAdd" title="Add" onclick="add('parameter',this)"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-3 m-2">
                                        <div class="form-group float-right row">
                                            <a class="btn btn-info col-6" id="btnSearch" title="Search" onclick="viewData()"><i class="fas fa-fw fa-solid fa-magnifying-glass m-1"></i>Search</a>
                                            <div class="dropdown ml-2 col-1">
                                                <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-fw fa-solid fa-file-export m-1"></i>Export
                                                </button>
                                                <div class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton" style="">
                                                    <a class="dropdown-item" href="#" onclick="report('pdf','sales')">PDF</a>
                                                    <a class="dropdown-item" href="#" onclick="report('excel','sales')">Excel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-lg-12" id="dataArea">
            <div class="card shadow mt-4 mb-4">
                <!-- Card Header - Accordion -->
                <a href="#collapseCardExample1" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
                    <h6 class="m-0 font-weight-bold text-primary">View Data</h6>
                </a>
                <!-- Card Content - Collapse -->
                <div class="collapse show" id="collapseCardExample1">
                    <div class="card-body">
                        <div class="content" id="tableArea">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12" id="inputArea">
        </div>
    </div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<!-- Modal -->
<div class="modal fade" id="modalDetail" tabindex="-1" aria-labelledby="modalDetaillabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDetaillabel">Detail</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">ID</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtId"></div>
                    </div>
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Currency</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtCurrency"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Date</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtDate"></div>
                    </div>
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Discount</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtDiscount"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Customer</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtCustomer"></div>
                    </div>
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Tax Type</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtTaxtype"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Due Date</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtDuedate"></div>
                    </div>
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Tax</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtTax"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Remark</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtRemark"></div>
                    </div>
                    <div class="row col-6">
                        <div class="col-sm-4 h6 font-weight-bold text-primary text-uppercase mb-1">Total</div>
                        <div class="col-sm-8 h6 mb-0 font-weight-bold text-gray-800" id="txtTotal"></div>
                    </div>
                </div>

                <div class="row m-2" id="contentDetailsales">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-md col-2" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalPrint" tabindex="-1" aria-labelledby="modalPrintlabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDetaillabel">Print</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <iframe src="" frameborder="0" id="contentPrint" style="overflow:hidden;height:100%;width:100%; min-height:600px; " height="100%" width="100%"></iframe>
            </div>
            <div class="modal-footer">
                <!-- <button type="button" class="btn btn-secondary btn-md col-2" data-dismiss="modal">Close</button> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalSearchtransaction" tabindex="-1" aria-labelledby="modalSearchtransactionlabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalSearchtransactionlabel">Transaction</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-md col-2" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>