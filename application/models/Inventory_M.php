<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Inventory_M extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        checkLogin();
        $this->load->library('session');

        date_default_timezone_set('Asia/Jakarta');
    }

    public function get($param, $obj, $datax)
    {
        $data = array();

        if ($param == "inWarehouse") {
            $query = "SELECT id, warehouse FROM m_warehouse WHERE `status` = '1' ORDER BY warehouse";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "inType") {
            $query = "SELECT id, `type` FROM m_inventory_type a WHERE `status` <> 0  ORDER BY `id` ASC";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "searchTransaction") {
            for ($i = 0; $i < count($datax); $i++) {
                $inType = $datax[$i]["inType"];
                $inTransaction = trim($datax[$i]["inTransaction"]);
            }

            if ($inType == 1) {
                if ($inTransaction != "") {
                    $query = "SELECT 
                                *,
                                (SELECT goods FROM m_goods WHERE id = goods_id) AS goods, 
                                (SELECT unit FROM m_unit WHERE id = unit_id) AS unit 
                                FROM t_purchase_detail 
                                WHERE 
                                purchase_id = '" . $inTransaction . "' AND 
                                `status` <> 0";

                    $row = $this->db->query($query)->num_rows();

                    if ($row) {
                        $data["status"] = 1;
                        $data["res"] = $this->db->query($query)->result_array();
                    } else {
                        $data["res"] = [];

                        $query2 = "SELECT 
                                        t1.purchase_id,
                                        DATE_FORMAT(t1.`date`, '%d-%m-%Y ') AS `date`,
                                    DATE_FORMAT(t1.due_date, '%d-%m-%Y ') AS `due_date`,
                                    (SELECT `type` FROM m_purchase_type WHERE id = t1.purchase_type_id) AS `type`,
                                    (SELECT supplier FROM m_supplier WHERE id = t1.supplier_id) AS supplier,
                                    (SELECT currency FROM m_currency WHERE id = t1.currency_id) AS currency,
                                    IF(t1.tax_type = 1 , 'Include (PKP)', 'Exclude (Non - PKP)') AS tax_type,
                                        (SELECT goods FROM m_goods WHERE id = t2.goods_id) AS goods,
                                        t2.qty,
                                        t2.qty_received,  
                                        (SELECT unit FROM m_unit WHERE id = t2.unit_id) AS unit
                                    FROM (
                                        SELECT 
                                        id, purchase_id, `date`, purchase_type_id, supplier_id, due_date, currency_id, tax_type
                                        FROM t_purchase
                                        WHERE 
                                        `status` <> 0 AND 
                                        purchase_id  LIKE '%" . $inTransaction . "%'
                                    )t1 
                                    LEFT  JOIN ( 
                                        SELECT 
                                        id, purchase_id, goods_id, qty, unit_id, qty_received
                                        FROM t_purchase_detail
                                        WHERE 
                                        `status` <> 0  AND 
                                        purchase_id  LIKE '%" . $inTransaction . "%'  AND 
                                        (qty_received IS NULL OR qty > qty_received)
                                    )t2 ON 
                                    t1.purchase_id = t2.purchase_id
                                    ORDER BY t1.date DESC";

                        // return ($query2);

                        $row2 = $this->db->query($query2)->num_rows();

                        if ($row2) {
                            $data["status"] = 0;
                            $data["res"] = $this->db->query($query2)->result_array();
                        } else {
                            return FALSE;
                        }
                    }
                } else {
                    $query3 = "SELECT 
                                *,
                                (SELECT goods FROM m_goods WHERE id = goods_id) AS goods, 
                                (SELECT unit FROM m_unit WHERE id = unit_id) AS unit 
                                FROM t_purchase_detail 
                                WHERE `status` <> 0 
                                ORDER BY purchase_id DESC ";


                    $row3 = $this->db->query($query3)->num_rows();

                    if ($row3) {
                        $data["status"] = 0;
                        $data["res"] = $this->db->query($query3)->result_array();
                    } else {
                        return FALSE;
                    }
                }
            } else if ($inType == 2) {
                if ($inTransaction != "") {
                    $query = "SELECT 
                                *, 
                                (SELECT `type` FROM m_inventory_type WHERE id = t1.inventory_type_id) AS `type`,
                                (SELECT warehouse FROM m_warehouse WHERE id = t1.warehouse_id) AS warehouse,
                                (SELECT goods FROM m_goods WHERE id = goods_id) AS goods,
                                DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`
                                FROM (
                                    SELECT 
                                        id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, `status` 
                                    FROM t_inventory 
                                    WHERE 
                                    `status` <> 0 AND 
                                    inventory_type_id = 1 AND 
                                    inventory_id = '" . $inTransaction . "'
                                )t1 JOIN (
                                    SELECT id, inventory_id, goods_id, qty, unit_id, `status` 
                                    FROM t_inventory_detail
                                    WHERE 
                                    `status` <> 0 AND 
                                    inventory_id = '" . $inTransaction . "'
                                )t2
                                ON t1.inventory_id = t2.inventory_id";

                    $row = $this->db->query($query)->num_rows();

                    if ($row) {
                        $data["status"] = 1;
                        $data["res"] = $this->db->query($query)->result_array();
                    } else {
                        $data["res"] = [];

                        $query2 = "SELECT 
                                    *, 
                                    (SELECT `type` FROM m_inventory_type WHERE id = t1.inventory_type_id) AS `type`,
                                    (SELECT warehouse FROM m_warehouse WHERE id = t1.warehouse_id) AS warehouse,
                                    (SELECT goods FROM m_goods WHERE id = goods_id) AS goods,
                                    DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`
                                    FROM (
                                        SELECT 
                                            id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, `status` 
                                        FROM t_inventory 
                                        WHERE 
                                        `status` <> 0 AND 
                                        inventory_type_id = 1 AND 
                                        inventory_id LIKE '%" . $inTransaction . "%'
                                    )t1 JOIN (
                                        SELECT id, inventory_id, goods_id, qty, unit_id, `status` 
                                        FROM t_inventory_detail
                                        WHERE 
                                        `status` <> 0 AND 
                                        inventory_id LIKE '%" . $inTransaction . "%'
                                    )t2
                                    ON t1.inventory_id = t2.inventory_id 
                                    ORDER by t1.`date` DESC";

                        // return ($query2);

                        $row2 = $this->db->query($query2)->num_rows();

                        if ($row2) {
                            $data["status"] = 0;
                            $data["res"] = $this->db->query($query2)->result_array();
                        } else {
                            return FALSE;
                        }
                    }
                } else {
                    $query3 = "SELECT 
                                *, 
                                (SELECT `type` FROM m_inventory_type WHERE id = t1.inventory_type_id) AS `type`,
                                (SELECT warehouse FROM m_warehouse WHERE id = t1.warehouse_id) AS warehouse,
                                (SELECT goods FROM m_goods WHERE id = goods_id) AS goods,
                                DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`
                                FROM (
                                    SELECT 
                                        id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, `status` 
                                    FROM t_inventory 
                                    WHERE 
                                    `status` <> 0 AND 
                                    inventory_type_id = 1 
                                )t1 JOIN (
                                    SELECT id, inventory_id, goods_id, qty, unit_id, `status` 
                                    FROM t_inventory_detail
                                    WHERE 
                                    `status` <> 0 
                                )t2
                                ON t1.inventory_id = t2.inventory_id 
                                ORDER by t1.`date` DESC";


                    $row3 = $this->db->query($query3)->num_rows();

                    if ($row3) {
                        $data["status"] = 0;
                        $data["res"] = $this->db->query($query3)->result_array();
                    } else {
                        return FALSE;
                    }
                }
            }
        } else if ($param == "inDgoods") {
            $query = "SELECT id, goods, unit_id,
                        (SELECT unit FROM m_unit where id = unit_id) AS unit
                        FROM m_goods 
                        WHERE 
                        `status` = '1' AND 
                        goods_type_id = '1'   
                        ORDER BY goods";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "edit") {

            $query = "SELECT 
                        id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, remark, created_by, created_at
                        FROM t_inventory 
                        WHERE 
                        id = '" . $obj . "' AND 
                        `status` <> 0";

            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["header"] = $this->db->query($query)->row_array();
            } else {
                return FALSE;
            }

            $inventory_id = $data["header"]["inventory_id"];

            $query2 = "SELECT 
                        *,
                        (SELECT unit FROM m_unit WHERE id = unit_id) AS unit 
                        FROM t_inventory_detail 
                        WHERE 
                        inventory_id = '" . $inventory_id . "' AND 
                        `status` <> 0";

            if ($row > 0) {
                $data["detail"] = $this->db->query($query2)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "detail") {
            $datax = explode("|", $obj);

            $query = "SELECT                      
                        id, inventory_id, inventory_type_id, warehouse_id, transaction_id, remark, created_by, created_at,
                        (SELECT `type` FROM m_inventory_type WHERE id = inventory_type_id) AS `type`,
                        (SELECT warehouse FROM m_warehouse WHERE id = warehouse_id) AS warehouse,
                        DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`
                        FROM t_inventory          
                        WHERE id = '" . $datax[0] . "' AND `status` <> 0";

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
                        FROM t_inventory_detail 
                        WHERE 
                        inventory_id = '" . $datax[1] . "' AND 
                        `status` <> 0";

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
            $inWarehouse = $data[$i]["inWarehouse"];
            $inTransaction = $data[$i]["inTransaction"];
            $inRemark = $data[$i]["inRemark"];

            // detail
            $inDidx = $data[$i]["inDidx"];
            $inDgoods = $data[$i]["inDgoods"];
            $inDqty = $data[$i]["inDqty"];
            $inDunitid = $data[$i]["inDunitid"];
            $inDremove = $data[$i]["inDremove"];
        }

        $curdate = date("Y-m-d H:i:s");
        $period = date("m") . date("Y");

        $transaction = "";
        $tCode = "";

        if ($inType == 1) {
            $transaction = "inv-receipt";
            $tCode = "RCP";
        } else if ($inType == 2) {
            $transaction = "inv-in";
            $tCode = "IN";
        } else if ($inType == 3) {
            $transaction = "inv-out";
            $tCode = "OUT";
        } else if ($inType == 4) {
            $transaction = "inv-return";
            $tCode = "RTR";
        } else if ($inType == 5) {
            $transaction = "inv-adjIn";
            $tCode = "ADI";
        } else if ($inType == 6) {
            $transaction = "inv-adjOut";
            $tCode = "ADO";
        }

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

            $inventory_id = $tCode . "/" . $period . "/" . $counter;

            // header
            $data3 = array(
                'id' => '',
                'inventory_id' => $inventory_id,
                'date' => $inDate,
                'inventory_type_id' => $inType,
                'warehouse_id' => $inWarehouse,
                'transaction_id' => $inTransaction,
                'remark' => $inRemark,
                'created_by' => $_SESSION['user_id']
            );

            $this->db->db_debug = false;

            if ($this->db->insert('t_inventory', $data3)) {
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

            if (!empty($inDgoods)) {
                for ($i = 0; $i < count($inDgoods); $i++) {

                    $data4 = array(
                        'id' => '',
                        'inventory_id' => $inventory_id,
                        'goods_id' => $inDgoods[$i],
                        'qty' => $inDqty[$i],
                        'unit_id' => $inDunitid[$i],
                        'created_by' => $_SESSION['user_id']
                    );

                    $this->db->db_debug = false;

                    if ($this->db->insert('t_inventory_detail', $data4)) {
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
                'inventory_type_id' => $inType,
                'warehouse_id' => $inWarehouse,
                'transaction_id' => $inTransaction,
                'remark' => $inRemark,
                'log_by' => $_SESSION['user_id'],
                'log_at' => date("Y-m-d H:i:s")
            );

            $this->db->db_debug = false;

            $where2 = array(
                'id' => $inIdx,
                'inventory_id' => $inId
            );

            $this->db->where($where2);

            if ($this->db->update("t_inventory", $data2)) {
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

            if (!empty($inDgoods)) {
                for ($i = 0; $i < count($inDgoods); $i++) {
                    if (isset($inDidx[$i]) && $inDidx[$i] != "") {
                        $data3 = array(
                            'goods_id' => $inDgoods[$i],
                            'qty' => $inDqty[$i],
                            'unit_id' => $inDunitid[$i],
                            'log_by' => $_SESSION['user_id'],
                            'log_at' => date("Y-m-d H:i:s")
                        );

                        $this->db->db_debug = false;

                        $where3 = array(
                            'id' => $inDidx[$i],
                            'inventory_id' => $inId
                        );

                        $this->db->where($where3);

                        if ($this->db->update("t_inventory_detail", $data3)) {
                            $res['res'] = 'success';
                        } else {
                            $res['res'] =  $this->db->error();
                            $res['res'] = $data['res']['message'];
                            return $res;
                        }
                    } else {
                        $data3 = array(
                            'id' => '',
                            'inventory_id' => $inId,
                            'goods_id' => $inDgoods[$i],
                            'qty' => $inDqty[$i],
                            'unit_id' => $inDunitid[$i],
                            'created_by' => $_SESSION['user_id']
                        );

                        $this->db->db_debug = false;

                        if ($this->db->insert('t_inventory_detail', $data3)) {
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
                            'inventory_id' => $inId
                        );

                        $this->db->where($where4);

                        if ($this->db->update("t_inventory_detail", $data4)) {
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
                'inventory_id' => $datax[1]
            );

            $this->db->where($where1);

            if ($this->db->update("t_inventory", $data1)) {
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
                'inventory_id' => $datax[1]
            );

            $this->db->where($where2);

            if ($this->db->update("t_inventory_detail", $data2)) {
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
