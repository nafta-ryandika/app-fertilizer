<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Purchase_M extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        checkLogin();
        $this->load->library('session');

        date_default_timezone_set('Asia/Jakarta');
    }

    public function get($param, $obj)
    {
        $data = array();

        if ($param == "inSupplier") {
            $query = "SELECT id, supplier FROM m_supplier WHERE `status` = '1' ORDER BY supplier";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "inDgoods") {
            $query = "SELECT id, goods, unit_id,
                        (SELECT unit FROM m_unit where id = unit_id) AS unit
                        FROM m_goods 
                        WHERE 
                        `status` = '1' AND 
                        goods_type_id != '2'
                        ORDER BY goods";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "type") {
            $query = "SELECT id, `type` FROM m_purchase_type a WHERE `status` = 1  ORDER BY `type` ASC";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "edit") {

            $query = "SELECT 
                    id, purchase_id, `date`, purchase_type_id, supplier_id, due_date, remark, discount, currency_id, tax_type, tax, total, `status` 
                    FROM t_purchase
                    WHERE 
                    id = '" . $obj . "' AND 
                    `status` = 1";

            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["header"] = $this->db->query($query)->row_array();
            } else {
                return FALSE;
            }

            $purchase_id = $data["header"]["purchase_id"];

            $query2 = "SELECT 
                        *,
                        (SELECT unit FROM m_unit WHERE id = unit_id) AS unit 
                        FROM t_purchase_detail 
                        WHERE 
                        purchase_id = '" . $purchase_id . "' AND 
                        `status` = 1";

            if ($row > 0) {
                $data["detail"] = $this->db->query($query2)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "detail") {
            $datax = explode("|", $obj);

            $query = "SELECT 
                        id, purchase_id, purchase_type_id, supplier_id, due_date, remark, discount, tax, total, `status`, created_by, created_at, log_by, log_at,
                        DATE_FORMAT(a.`date`, '%d-%m-%Y ') AS `date`,
                        DATE_FORMAT(a.due_date, '%d-%m-%Y ') AS `due_date`,
                        (SELECT `type` FROM m_purchase_type WHERE id = a.purchase_type_id) AS `type`,
                        (SELECT supplier FROM m_supplier WHERE id = a.supplier_id) AS supplier,
                        (SELECT currency FROM m_currency WHERE id = a.currency_id) AS currency,
                        IF(a.tax_type = 1 , 'Include (PKP)', 'Exclude (Non - PKP)') AS tax_type
                        FROM t_purchase a 
                        WHERE id = '" . $datax[0] . "' AND `status` = 1";

            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["header"] = $this->db->query($query)->row_array();
            } else {
                return FALSE;
            }

            $query1 = "SELECT 
                        *,
                        (SELECT goods FROM m_goods WHERE id = goods_id) AS goods, 
                        (SELECT unit FROM m_unit WHERE id = unit_id) AS unit 
                        FROM t_purchase_detail 
                        WHERE 
                        purchase_id = '" . $datax[1] . "' AND 
                        `status` = 1";

            $row1 = $this->db->query($query1)->num_rows();

            if ($row1 > 0) {
                $data["detail"] = $this->db->query($query1)->result_array();
            } else {
                $data["detail"] = "";
            }
        }

        return $data;
    }

    public function save($param, $obj, $data)
    {
        $res = array();

        for ($i = 0; $i < count($data); $i++) {
            //header
            $inMode = $data[$i]["inMode"];
            $inIdx = $data[$i]["inIdx"];
            $inId = $data[$i]["inId"];
            $inDate = $data[$i]["inDate"];
            $inType = $data[$i]["inType"];
            $inSupplier = $data[$i]["inSupplier"];
            $inDuedate = $data[$i]["inDuedate"];
            $inRemark = $data[$i]["inRemark"];
            $inCurrency = $data[$i]["inCurrency"];
            $inDiscount = $data[$i]["inDiscount"];
            $inTaxtype = $data[$i]["inTaxtype"];
            $inTax = $data[$i]["inTax"];
            $inTotal = $data[$i]["inTotal"];

            // detail
            $inDidx = $data[$i]["inDidx"];
            $inDgoods = $data[$i]["inDgoods"];
            $inDqty = $data[$i]["inDqty"];
            $inDunitid = $data[$i]["inDunitid"];
            $inDprice = $data[$i]["inDprice"];
            $inDdiscount = $data[$i]["inDdiscount"];
            $inDsubtotal = $data[$i]["inDsubtotal"];
            $inDremove = $data[$i]["inDremove"];
        }

        $curdate = date("Y-m-d H:i:s");
        $period = date("m") . date("Y");
        $transaction = "purchase";
        $counter = 0;

        if ($inMode == "add") {
            $query1 = "SELECT `counter` From m_counter WHERE `transaction` = '" . $transaction . "'  AND  `period` = '" . $period . "' AND `status` = '1'";
            $row1 = $this->db->query($query1)->num_rows();

            if ($row1 > 0) {
                $data1 = $this->db->query($query1)->row_array();
                $counter = $data1['counter'];
                $counter++;

                $data2 = array(
                    'counter' => $counter,
                    'created_by' => $_SESSION['user_id'],
                    'created_at' => $curdate
                );

                $this->db->db_debug = false;

                $where2 = array(
                    'period' => $period,
                    'transaction' => $transaction
                );

                $this->db->where($where2);

                if ($this->db->update("m_counter", $data2)) {
                    $res['res'] = 'success';
                } else {
                    $res['res'] =  $this->db->error();
                    $res['res'] = $data['res']['message'];
                    return $res;
                }
            } else {
                $counter++;

                $data2 = array(
                    'id' => '',
                    'transaction' => $transaction,
                    'counter' => $counter,
                    'period' => $period,
                    'created_by' => $_SESSION['user_id']
                );

                $this->db->db_debug = false;

                if ($this->db->insert('m_counter', $data2)) {
                    $res['res'] = 'success';
                } else {
                    $res['err'] =  $this->db->error();
                    $res['err'] = $res['err']['message'];
                    return $res;
                }
            }

            $counter = sprintf("%05d", $counter);

            $purchase_id = "PO/" . $period . "/" . $counter;

            // header
            $data3 = array(
                'id' => '',
                'purchase_id' => $purchase_id,
                'date' => $inDate,
                'purchase_type_id' => $inType,
                'supplier_id' => $inSupplier,
                'due_date' => $inDuedate,
                'remark' => $inRemark,
                'currency_id' => $inCurrency,
                'discount' => $inDiscount,
                'tax_type' => $inTaxtype,
                'tax' => $inTax,
                'total' => $inTotal,
                'created_by' => $_SESSION['user_id']
            );

            $this->db->db_debug = false;

            if ($this->db->insert('t_purchase', $data3)) {
                $res['res'] = 'success';
            } else {
                $res['err'] =  $this->db->error();
                $res['err'] = $res['err']['message'];
                return $res;
            }

            // detail
            $inDgoods = rtrim($inDgoods, "|");
            $inDgoods = explode("|", $inDgoods);

            $inDqty = rtrim($inDqty, "|");
            $inDqty = explode("|", $inDqty);

            $inDunitid = rtrim($inDunitid, "|");
            $inDunitid = explode("|", $inDunitid);

            $inDprice = rtrim($inDprice, "|");
            $inDprice = explode("|", $inDprice);

            $inDdiscount = rtrim($inDdiscount, "|");
            $inDdiscount = explode("|", $inDdiscount);

            $inDsubtotal = rtrim($inDsubtotal, "|");
            $inDsubtotal = explode("|", $inDsubtotal);

            if (!empty($inDgoods)) {
                for ($i = 0; $i < count($inDgoods); $i++) {
                    if (!empty($inDdiscount[$i])) {
                        $inDdiscountx = $inDdiscount[$i];
                    } else {
                        $inDdiscountx = 0;
                    }

                    $data4 = array(
                        'id' => '',
                        'purchase_id' => $purchase_id,
                        'goods_id' => $inDgoods[$i],
                        'qty' => $inDqty[$i],
                        'unit_id' => $inDunitid[$i],
                        'price' => $inDprice[$i],
                        'discount' => $inDdiscountx,
                        'subtotal' => $inDsubtotal[$i],
                        'created_by' => $_SESSION['user_id']
                    );

                    $this->db->db_debug = false;

                    if ($this->db->insert('t_purchase_detail', $data4)) {
                        $res['res'] = 'success';
                    } else {
                        $res['err'] =  $this->db->error();
                        $res['err'] = $res['err']['message'];
                        return $res;
                    }
                }
            }
        } else if ($inMode == "edit") {
            // header
            $data2 = array(
                'purchase_type_id' => $inType,
                'supplier_id' => $inSupplier,
                'due_date' => $inDuedate,
                'remark' => $inRemark,
                'currency_id' => $inCurrency,
                'discount' => $inDiscount,
                'tax_type' => $inTaxtype,
                'tax' => $inTax,
                'total' => $inTotal,
                'log_by' => $_SESSION['user_id'],
                'log_at' => date("Y-m-d H:i:s")
            );

            $this->db->db_debug = false;

            $where2 = array(
                'id' => $inIdx,
                'purchase_id' => $inId
            );

            $this->db->where($where2);

            if ($this->db->update("t_purchase", $data2)) {
                $res['res'] = 'success';
            } else {
                $res['res'] =  $this->db->error();
                $res['res'] = $data['res']['message'];
                return $res;
            }

            // detail 
            $inDidx = rtrim($inDidx, "|");
            $inDidx = explode("|", $inDidx);

            $inDgoods = rtrim($inDgoods, "|");
            $inDgoods = explode("|", $inDgoods);

            $inDqty = rtrim($inDqty, "|");
            $inDqty = explode("|", $inDqty);

            $inDunitid = rtrim($inDunitid, "|");
            $inDunitid = explode("|", $inDunitid);

            $inDprice = rtrim($inDprice, "|");
            $inDprice = explode("|", $inDprice);

            $inDdiscount = rtrim($inDdiscount, "|");
            $inDdiscount = explode("|", $inDdiscount);

            $inDsubtotal = rtrim($inDsubtotal, "|");
            $inDsubtotal = explode("|", $inDsubtotal);

            if (!empty($inDgoods)) {
                for ($i = 0; $i < count($inDgoods); $i++) {

                    if (!empty($inDdiscount[$i])) {
                        $inDdiscountx = $inDdiscount[$i];
                    } else {
                        $inDdiscountx = 0;
                    }

                    if (isset($inDidx[$i]) && $inDidx[$i] != "") {
                        $data3 = array(
                            'goods_id' => $inDgoods[$i],
                            'qty' => $inDqty[$i],
                            'unit_id' => $inDunitid[$i],
                            'price' => $inDprice[$i],
                            'discount' => $inDdiscountx,
                            'subtotal' => $inDsubtotal[$i],
                            'log_by' => $_SESSION['user_id'],
                            'log_at' => date("Y-m-d H:i:s")
                        );



                        $this->db->db_debug = false;

                        $where3 = array(
                            'id' => $inDidx[$i],
                            'purchase_id' => $inId
                        );

                        $this->db->where($where3);

                        if ($this->db->update("t_purchase_detail", $data3)) {
                            $res['res'] = 'success';
                        } else {
                            $res['res'] =  $this->db->error();
                            $res['res'] = $data['res']['message'];
                            return $res;
                        }
                    } else {
                        $data3 = array(
                            'id' => '',
                            'purchase_id' => $inId,
                            'goods_id' => $inDgoods[$i],
                            'qty' => $inDqty[$i],
                            'unit_id' => $inDunitid[$i],
                            'price' => $inDprice[$i],
                            'discount' => $inDdiscountx,
                            'subtotal' => $inDsubtotal[$i],
                            'created_by' => $_SESSION['user_id']
                        );

                        $this->db->db_debug = false;

                        if ($this->db->insert('t_purchase_detail', $data3)) {
                            $res['res'] = 'success';
                        } else {
                            $res['err'] =  $this->db->error();
                            $res['err'] = $res['err']['message'];
                            return $res;
                        }
                    }
                }
            }

            if (isset($inDremove)) {
                $inDremove = explode("|", $inDremove);

                if (!empty($inDremove)) {
                    for ($i = 0; $i < count($inDremove); $i++) {
                        $data4 = array(
                            'status' => 0,
                            'log_by' => $_SESSION['user_id'],
                            'log_at' => date("Y-m-d H:i:s")
                        );

                        $this->db->db_debug = false;

                        $where4 = array(
                            'id' => $inDremove[$i],
                            'purchase_id' => $inId
                        );

                        $this->db->where($where4);

                        if ($this->db->update("t_purchase_detail", $data4)) {
                            $res['res'] = 'success';
                        } else {
                            $res['res'] =  $this->db->error();
                            $res['res'] = $data['res']['message'];
                            return $res;
                        }
                    }
                }
            }
        }

        return $res;
    }

    public function remove($param, $obj)
    {
        $res = array();

        if ($param == "data") {
            $datax = explode("|", $obj);

            // header
            $data1 = array(
                'status' => 0,
                'log_by' => $_SESSION['user_id'],
                'log_at' => date("Y-m-d H:i:s")
            );

            $this->db->db_debug = false;

            $where1 = array(
                'id' => $datax[0],
                'purchase_id' => $datax[1]
            );

            $this->db->where($where1);

            if ($this->db->update("t_purchase", $data1)) {
                $res['res'] = 'success';
            } else {
                $res['res'] =  $this->db->error();
                $res['res'] = $data['res']['message'];
                return $res;
            }

            $data2 = array(
                'status' => 0,
                'log_by' => $_SESSION['user_id'],
                'log_at' => date("Y-m-d H:i:s")
            );

            $this->db->db_debug = false;

            $where2 = array(
                'purchase_id' => $datax[1]
            );

            $this->db->where($where2);

            if ($this->db->update("t_purchase_detail", $data2)) {
                $res['res'] = 'success';
            } else {
                $res['res'] =  $this->db->error();
                $res['res'] = $data['res']['message'];
                return $res;
            }
        }

        return $res;
    }
}
