<div class="col-lg-12">
    <div class="card shadow">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">Input</h6>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-6">
                    <div class="form-group row">
                        <label for="inId" class="col-sm-3 col-form-label">ID</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control text-center" id="inId" name="inId" value="~ Automatic ~" readonly disabled>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="inDate" class="col-sm-3 col-form-label">Date</label>
                        <div class="col-sm-3">
                            <input type="date" class="form-control" id="inDate" name="inDate" readonly disabled required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="inName" class="col-sm-3 col-form-label">Type</label>
                        <div class="col-sm-3">
                            <select class="form-control inType" style="width: 100%;">
                                <?php
                                foreach ($type as $data_type) :
                                    echo '<option value="' . $data_type['id'] . '">' . $data_type['type'] . '</option>';
                                endforeach;
                                ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="inSupplier" class="col-sm-3 col-form-label">Supplier</label>
                        <div class="col-sm-9">
                            <select class="form-control select2" style="width: 100%;" id="inSupplier" name="inSupplier" required>
                                <option value="">Select</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="inDuedate" class="col-sm-3 col-form-label">Due Date</label>
                        <div class="col-sm-3">
                            <input type="date" class="form-control" id="inDuedate" name="inDuedate" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="inRemark" class="col-sm-3 col-form-label">Remark</label>
                        <div class="col-sm-9">
                            <textarea type="text" class="form-control" id="inRemark" name="inRemark"></textarea>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="form-group row">
                        <label for="inDiscount" class="col-sm-3 col-form-label">Discount</label>
                        <div class="col-sm-3">
                            <input type="number" class="form-control text-right" id="inDiscount" name="inDiscount" value="0" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="inTax" class="col-sm-3 col-form-label">Tax</label>
                        <div class="col-sm-3">
                            <input type="number" class="form-control text-right" id="inTax" name="inTax" value="0" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="inTotal" class="col-sm-3 col-form-label">Total</label>
                        <div class="col-sm-6">
                            <input type="number" class="form-control text-right" id="inTotal" name="inTotal" readonly disabled required>
                        </div>
                    </div>
                </div>
            </div>
            <div class="class row">
                <div class="col-12">
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="class row">
                                <div class="col-12 m-2">
                                    <table class="table table-hover" id="dataTable-input" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Goods</th>
                                                <th scope="col">Qty</th>
                                                <th scope="col">Unit</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Discount</th>
                                                <th scope="col">Sub Total</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                            // $i = 1;
                                            // foreach ($user as $data_user) :
                                            // for ($i = 0; $i < 2; $i++) {
                                            ?>
                                            <tr>
                                                <td scope="row">
                                                    <select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" required>
                                                        <option value="">Select</option>
                                                    </select>
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control text-right inDqty" name="inDqty" onkeyup="count('subtotal',this)" required>
                                                </td>
                                                <td scope="row">
                                                    <input type="text" class="form-control inDunit" name="inDunit" readonly disabled required>
                                                    <input type="hidden" class="form-control inDunitid" name="inDunitid" readonly disabled>
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control text-right inDprice" name="inDprice" onkeyup="count('subtotal',this)" required>
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control inDiscount" name="inDiscount" onkeyup="count('subtotal',this)">
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control text-right inDsubtotal" name="inDsubtotal" required>
                                                </td>
                                                <td>
                                                    <a class="btn btn-success m-1" id="btnDetail" title="Detail" onclick="get('detail','','')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>
                                                    <a class="btn btn-danger m-1" id="btnDelete" title="Delete" onclick="remove('data','')"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>
                                                </td>
                                            </tr>
                                            <?php
                                            // }
                                            // $i++;
                                            // endforeach;
                                            ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="class row">
                <div class="class col-12 text-center">
                    <button type="submit" class="btn btn-primary btn-md col-1" id="btnSave">Save</button>
                    <button type="button" class="btn btn-secondary btn-md col-1" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>