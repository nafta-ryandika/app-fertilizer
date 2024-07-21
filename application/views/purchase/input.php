<?php
if (isset($param)) {
    if ($param == "edit") {
        $inIdx = $data["header"]["id"];
        $inId = $data["header"]["purchase_id"];
        $inDate = $data["header"]["date"];
        $inType = $data["header"]["purchase_type_id"];
        $inSupplier = $data["header"]["supplier_id"];
        $inDuedate = $data["header"]["due_date"];
        $inRemark = $data["header"]["remark"];
        $inDiscount = $data["header"]["discount"];
        $inTax = $data["header"]["tax"];
        $inTotal = $data["header"]["total"];
    }
}
?>

<div class="card shadow">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">Input</h6>
    </div>
    <div class="card-body">
        <div class="row">
            <input type="hidden" class="form-control text-center" id="inMode" name="inMode" value="" readonly disabled>
            <div class="col-6">
                <div class="form-group row">
                    <label for="inId" class="col-sm-3 col-form-label">ID</label>
                    <div class="col-sm-6">
                        <input type="hidden" class="form-control text-center" id="inIdx" name="inIdx" value="" readonly disabled>
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
                        <select class="form-control inType" id="inType" style="width: 100%;">
                            <option value="">Select</option>
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
                        <input type="number" class="form-control text-right" id="inDiscount" name="inDiscount" value="0" onkeyup="count('total',this)" onfocus="$(this).select();" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="inTax" class="col-sm-3 col-form-label">Tax</label>
                    <div class="col-sm-3">
                        <input type="number" class="form-control text-right" id="inTax" name="inTax" value="0" onkeyup="count('total',this)" onfocus="$(this).select();" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="inTotal" class="col-sm-3 col-form-label">Total</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control text-right" id="inTotal" name="inTotal" readonly disabled required>
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
                                        if (isset($param)) {
                                            $numRow = 1;
                                            if ($param == "edit" && (count($data["detail"]) > 0)) {
                                                foreach ($data["detail"] as $data_detail) :
                                                    $inDidx = $data_detail["id"];
                                                    $inDgoods = $data_detail["goods_id"];
                                                    $inDqty = $data_detail["qty"];
                                                    $inDunit = $data_detail["unit"];
                                                    $inDunitid = $data_detail["unit_id"];
                                                    $inPrice = $data_detail["price"];
                                                    $inDdiscount = $data_detail["discount"];
                                                    $inDsubtotal = $data_detail["subtotal"];

                                        ?>
                                                    <tr>
                                                        <td scope="row">
                                                            <input type="hidden" class="form-control text-center inDidx" id="inDidx" name="inDidx" value="<?= $inDidx; ?>" readonly disabled>
                                                            <select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" onclick="choose('inDgoods',this)" required>
                                                                <option value="">Select</option>
                                                                <?php
                                                                foreach ($goods as $data_goods) :
                                                                    if (isset($inDgoods)) {
                                                                        if ($data_goods['id'] == $inDgoods) {
                                                                            echo '<option value="' . $data_goods['id'] . '" data-unit="' . $data_goods['unit'] . '" data-unitid="' . $data_goods['unit_id'] . '" selected>' . $data_goods['goods'] . '</option>';
                                                                        } else {
                                                                            echo '<option value="' . $data_goods['id'] . '" data-unit="' . $data_goods['unit'] . '" data-unitid="' . $data_goods['unit_id'] . '">' . $data_goods['goods'] . '</option>';
                                                                        }
                                                                    } else {
                                                                        echo '<option value="' . $data_goods['id'] . '" data-unit="' . $data_goods['unit'] . '" data-unitid="' . $data_goods['unit_id'] . '">' . $data_goods['goods'] . '</option>';
                                                                    }
                                                                endforeach;
                                                                ?>
                                                            </select>
                                                        </td>
                                                        <td scope="row">
                                                            <input type="number" class="form-control text-right inDqty" name="inDqty" onkeyup="count('subtotal',this)" onfocus="$(this).select();" value="<?= $inDqty; ?>" required>
                                                        </td>
                                                        <td scope="row">
                                                            <input type="text" class="form-control inDunit" name="inDunit" value="<?= $inDunit; ?>" readonly disabled required>
                                                            <input type="hidden" class="form-control inDunitid" name="inDunitid" value="<?= $inDunitid; ?>" readonly disabled>
                                                        </td>
                                                        <td scope="row">
                                                            <input type="number" class="form-control text-right inDprice" name="inDprice" onkeyup="count('subtotal',this)" onfocus="$(this).select();" value="<?= $inPrice; ?>" required>
                                                        </td>
                                                        <td scope="row">
                                                            <input type="number" class="form-control inDdiscount" name="inDdiscount" onkeyup="count('subtotal',this)" onfocus="$(this).select();" value="<?= $inDdiscount; ?>">
                                                        </td>
                                                        <td scope="row">
                                                            <input type="number" class="form-control text-right inDsubtotal" name="inDsubtotal" value="<?= $inDsubtotal; ?>" required>
                                                        </td>
                                                        <td>
                                                            <a class="btn btn-success m-1" id="btnDetail" title="Detail" onclick="add('detail','')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>
                                                            <a class="btn btn-danger m-1" id="btnDelete" title="Delete" onclick="remove('detail',this)"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>
                                                            <script>
                                                                get("inDgoods", "", "<?= $inDgoods; ?>");
                                                            </script>
                                                        </td>
                                                    </tr>
                                                <?php
                                                endforeach;
                                            } else {
                                                ?>
                                                <tr>
                                                    <td scope="row">
                                                        <select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" required>
                                                            <option value="">Select</option>
                                                            <?php
                                                            foreach ($goods as $data_goods) :
                                                                if (isset($inDgoods)) {
                                                                    if ($data_goods['id'] == $inDgoods) {
                                                                        echo '<option value="' . $data_goods['id'] . '" data-unit="' . $data_goods['unit'] . '" data-unitid="' . $data_goods['unit_id'] . '" selected>' . $data_goods['goods'] . '</option>';
                                                                    } else {
                                                                        echo '<option value="' . $data_goods['id'] . '" data-unit="' . $data_goods['unit'] . '" data-unitid="' . $data_goods['unit_id'] . '">' . $data_goods['goods'] . '</option>';
                                                                    }
                                                                } else {
                                                                    echo '<option value="' . $data_goods['id'] . '" data-unit="' . $data_goods['unit'] . '" data-unitid="' . $data_goods['unit_id'] . '">' . $data_goods['goods'] . '</option>';
                                                                }
                                                            endforeach;
                                                            ?>
                                                        </select>
                                                    </td>
                                                    <td scope="row">
                                                        <input type="number" class="form-control text-right inDqty" name="inDqty" onkeyup="count('subtotal',this)" onfocus="$(this).select();" required>
                                                    </td>
                                                    <td scope="row">
                                                        <input type="text" class="form-control inDunit" name="inDunit" readonly disabled required>
                                                        <input type="hidden" class="form-control inDunitid" name="inDunitid" readonly disabled>
                                                    </td>
                                                    <td scope="row">
                                                        <input type="number" class="form-control text-right inDprice" name="inDprice" onkeyup="count('subtotal',this)" onfocus="$(this).select();" required>
                                                    </td>
                                                    <td scope="row">
                                                        <input type="number" class="form-control inDdiscount" name="inDdiscount" onkeyup="count('subtotal',this)" onfocus="$(this).select();">
                                                    </td>
                                                    <td scope="row">
                                                        <input type="number" class="form-control text-right inDsubtotal" name="inDsubtotal" required>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-success m-1" id="btnDetail" title="Detail" onclick="add('detail','')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>
                                                        <a class="btn btn-secondary m-1" id="btnDelete" title="Delete" onclick=""><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>
                                                        <script>
                                                            get("inDgoods", 1, "");
                                                        </script>
                                                    </td>
                                                </tr>
                                            <?php
                                            }
                                        } else {
                                            ?>
                                            <tr>
                                                <td scope="row">
                                                    <select class="form-control select2 inDgoods" style="width: 100%;" name="inDgoods" required>
                                                        <option value="">Select</option>
                                                    </select>
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control text-right inDqty" name="inDqty" onkeyup="count('subtotal',this)" onfocus="$(this).select();" required>
                                                </td>
                                                <td scope="row">
                                                    <input type="text" class="form-control inDunit" name="inDunit" readonly disabled required>
                                                    <input type="hidden" class="form-control inDunitid" name="inDunitid" readonly disabled>
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control text-right inDprice" name="inDprice" onkeyup="count('subtotal',this)" onfocus="$(this).select();" required>
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control inDdiscount" name="inDdiscount" onkeyup="count('subtotal',this)" onfocus="$(this).select();">
                                                </td>
                                                <td scope="row">
                                                    <input type="number" class="form-control text-right inDsubtotal" name="inDsubtotal" required>
                                                </td>
                                                <td>
                                                    <a class="btn btn-success m-1" id="btnDetail" title="Detail" onclick="add('detail','')"><i class="fas fa-fw fa-solid fa-square-plus m-1"></i></a>
                                                    <a class="btn btn-secondary m-1" id="btnDelete" title="Delete" onclick=""><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>
                                                    <script>
                                                        get("inDgoods", 1, "");
                                                    </script>
                                                </td>
                                            </tr>
                                        <?php
                                        }
                                        ?>
                                    </tbody>
                                </table>
                                <input type="hidden" class="form-control text-center inDremove" id="inDremove" name="inDremove" value="" readonly disabled>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="class row">
            <div class="class col-12 text-center">
                <button type="button" class="btn btn-primary btn-md col-1" id="btnSave" onclick="save('data','')">Save</button>
                <button type="button" class="btn btn-secondary btn-md col-1" data-dismiss="modal" onclick="exit('input','')">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    $("#inMode").val('<?= $param ?>');
    $("#inIdx").val('<?= $inIdx ?>');
    $("#inId").val('<?= $inId ?>');
    $("#inDate").val('<?= $inDate ?>');
    $("#inType").val('<?= $inType ?>');
    get("inSupplier", "<?= $inSupplier ?>", "");
    $("#inDuedate").val('<?= $inDuedate ?>');
    $("#inRemark").val('<?= $inRemark ?>');
    $("#inDiscount").val('<?= $inDiscount ?>');
    $("#inTax").val('<?= $inTax ?>');
    $("#inTotal").val($.number(<?= $inTotal ?>, 2));


    $('.inDgoods').on("select2:selecting", function() {
        var unit_id = $(this).find(":selected").data("unitid");
        var unit = $(this).find(":selected").data("unit");

        $(this).closest('tr').find('.inDunitid').val(unit_id);
        $(this).closest('tr').find('.inDunit').val(unit);
    });
</script>