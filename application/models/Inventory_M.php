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

            $data["inType"] = $inType;

            if ($inType == 1) {
                if ($inTransaction != "") {
                    $query = "SELECT 
                                *,
                                (SELECT goods FROM m_goods WHERE id = goods_id) AS goods, 
                                (SELECT unit FROM m_unit WHERE id = unit_id) AS unit 
                                FROM t_purchase_detail 
                                WHERE 
                                purchase_id = '" . $inTransaction . "' AND 
                                `status` <> 0 AND 
                                (qty_received IS NULL OR qty > qty_received) 
                                ORDER BY id DESC";

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
                                    JOIN ( 
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
                            // $data["status"] = 2;
                            return FALSE;
                        }
                    }
                } else {
                    $query3 = "SELECT  
                                    t1.purchase_id, 
                                    DATE_FORMAT(t1.`date`, '%d-%m-%Y ') AS `date`,
                                    DATE_FORMAT(t1.due_date, '%d-%m-%Y ') AS `due_date`,
                                    (SELECT `type` FROM m_purchase_type WHERE id = t1.purchase_type_id) AS `type`,
                                (SELECT supplier FROM m_supplier WHERE id = t1.supplier_id) AS supplier,
                                (SELECT goods FROM m_goods WHERE id = t2.goods_id) AS goods, 
                                    (SELECT unit FROM m_unit WHERE id = t2.unit_id) AS unit, 
                                    t2.qty
                                FROM 
                                (
                                    SELECT id, purchase_id, `date`, purchase_type_id, supplier_id, due_date, `status` 
                                    FROM t_purchase 
                                    WHERE `status` <> 0
                                )t1 
                                JOIN 
                                (
                                    SELECT id, purchase_id, goods_id, qty, unit_id, price, discount, subtotal, qty_received, `status` 
                                    FROM t_purchase_detail
                                    WHERE `status` <> 0 AND 
                                    (qty_received IS NULL OR qty > qty_received)
                                )t2 
                                ON t1.purchase_id = t2.purchase_id 
                                ORDER BY t1.date DESC";

                    $row3 = $this->db->query($query3)->num_rows();

                    if ($row3) {
                        $data["status"] = 0;
                        $data["res"] = $this->db->query($query3)->result_array();
                    } else {
                        // $data["status"] = 2;
                        return FALSE;
                    }
                }
            } else if ($inType == 2) {
                if ($inTransaction != "") {
                    $query = "SELECT 
                                t1.*,
                                t2.*, 
                                (SELECT goods FROM m_goods WHERE id = t2.goods_id) AS goods,
                                (SELECT unit FROM m_unit WHERE id = unit_id) AS unit,
                                IF(t2.qty_taken IS NULL, t2.qty, t2.qty - t2.qty_taken) AS qty,
                                IF(t3.qty_received IS NULL, IF(((t2.qty - COALESCE(t2.qty_taken, 0)) <= t3.qty), (t2.qty-COALESCE(t2.qty_taken, 0)), t3.qty), IF((t3.qty - t3.qty_received) <= (t2.qty - COALESCE(t2.qty_taken, 0)), (t3.qty - t3.qty_received), (t2.qty - COALESCE(t2.qty_taken, 0)))) AS qty_max
                                FROM (
                                    SELECT 
                                        id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, `status` 
                                    FROM t_inventory 
                                    WHERE 
                                    `status` <> 0 AND 
                                    inventory_type_id IN(1, 3) AND 
                                    inventory_id = '" . $inTransaction . "'
                                )t1 JOIN (
                                    SELECT id, inventory_id, goods_id, qty, unit_id, qty_taken, `status` 
                                    FROM t_inventory_detail
                                    WHERE 
                                    `status` <> 0 AND 
                                    inventory_id = '" . $inTransaction . "'
                                )t2
                                ON t1.inventory_id = t2.inventory_id 
                                JOIN (
                                    SELECT 
                                        purchase_id, goods_id, qty, qty_received 
                                    FROM t_purchase_detail 
                                    WHERE 
                                    `status` <> 0 AND 
                                    (qty_received IS NULL OR qty > qty_received)
                                )t3 
                                ON t1.transaction_id = t3.purchase_id AND t2.goods_id = t3.goods_id
                                ORDER BY t1.date DESC";

                    $row = $this->db->query($query)->num_rows();

                    if ($row) {
                        $data["status"] = 1;
                        $data["res"] = $this->db->query($query)->result_array();
                    } else {
                        $data["res"] = [];

                        $query2 = "SELECT 
                                    t1.*,
                                    t2.*,  
                                    (SELECT `type` FROM m_inventory_type WHERE id = t1.inventory_type_id) AS `type`,
                                    (SELECT warehouse FROM m_warehouse WHERE id = t1.warehouse_id) AS warehouse,
                                    (SELECT goods FROM m_goods WHERE id = t2.goods_id) AS goods,
                                    (SELECT unit FROM m_unit WHERE id = unit_id) AS unit,
                                    IF(t2.qty_taken IS NULL, t2.qty, t2.qty - t2.qty_taken) AS qty,
                                    IF(t3.qty_received IS NULL, IF(((t2.qty - COALESCE(t2.qty_taken, 0)) <= t3.qty), (t2.qty-COALESCE(t2.qty_taken, 0)), t3.qty), IF((t3.qty - t3.qty_received) <= (t2.qty - COALESCE(t2.qty_taken, 0)), (t3.qty - t3.qty_received), (t2.qty - COALESCE(t2.qty_taken, 0)))) AS qty_max
                                    FROM (
                                        SELECT 
                                            id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, `status` 
                                        FROM t_inventory 
                                        WHERE 
                                        `status` <> 0 AND 
                                        inventory_type_id IN (1, 3) AND 
                                        inventory_id LIKE '%" . $inTransaction . "%'
                                    )t1 JOIN (
                                        SELECT id, inventory_id, goods_id, qty, unit_id, qty_taken, `status` 
                                        FROM t_inventory_detail
                                        WHERE 
                                        `status` <> 0 AND 
                                        inventory_id LIKE '%" . $inTransaction . "%'
                                    )t2
                                    ON t1.inventory_id = t2.inventory_id 
                                    JOIN (
                                        SELECT 
                                            purchase_id, goods_id, qty, qty_received 
                                        FROM t_purchase_detail 
                                        WHERE 
                                        `status` <> 0 AND 
                                        (qty_received IS NULL OR qty > qty_received)
                                    )t3 ON t1.transaction_id = t3.purchase_id AND t2.goods_id = t3.goods_id
                                    ORDER by t1.`date` DESC";

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
                                t1.*,
                                t2.*, 
                                (SELECT `type` FROM m_inventory_type WHERE id = t1.inventory_type_id) AS `type`,
                                (SELECT warehouse FROM m_warehouse WHERE id = t1.warehouse_id) AS warehouse,
                                (SELECT goods FROM m_goods WHERE id = t2.goods_id) AS goods,
                                (SELECT unit FROM m_unit WHERE id = unit_id) AS unit,
                                DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`,
                                IF(t2.qty_taken IS NULL, t2.qty, t2.qty - t2.qty_taken) AS qty,
                                IF(t3.qty_received IS NULL, IF(((t2.qty - COALESCE(t2.qty_taken, 0)) <= t3.qty), (t2.qty-COALESCE(t2.qty_taken, 0)), t3.qty), IF((t3.qty - t3.qty_received) <= (t2.qty - COALESCE(t2.qty_taken, 0)), (t3.qty - t3.qty_received), (t2.qty - COALESCE(t2.qty_taken, 0)))) AS qty_max
                                FROM (
                                    SELECT 
                                        id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, `status` 
                                    FROM t_inventory 
                                    WHERE 
                                    `status` <> 0 AND 
                                    inventory_type_id IN (1, 3) 
                                )t1 JOIN (
                                    SELECT id, inventory_id, goods_id, qty, unit_id, qty_taken, `status` 
                                    FROM t_inventory_detail
                                    WHERE 
                                    `status` <> 0 
                                )t2
                                ON t1.inventory_id = t2.inventory_id 
                                JOIN (
                                    SELECT 
                                        purchase_id, goods_id, qty, qty_received 
                                    FROM t_purchase_detail 
                                    WHERE 
                                    `status` <> 0 AND 
                                    (qty_received IS NULL OR qty > qty_received)
                                )t3 ON t1.transaction_id = t3.purchase_id AND t2.goods_id = t3.goods_id
                                ORDER by t1.`date` DESC";


                    $row3 = $this->db->query($query3)->num_rows();

                    if ($row3) {
                        $data["status"] = 0;
                        $data["res"] = $this->db->query($query3)->result_array();
                    } else {
                        // $data["status"] = 2;
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
                        id, inventory_id, `date`, inventory_type_id, warehouse_id, transaction_id, remark, created_by, created_at, `status`
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
            $inStatus = $data[$i]["inStatus"];

            // detail
            $inDidx = $data[$i]["inDidx"];
            $inDgoods = $data[$i]["inDgoods"];
            $inDqty = $data[$i]["inDqty"];
            $inDunitid = $data[$i]["inDunitid"];
            $inDremove = $data[$i]["inDremove"];
            $inDstatus = $data[$i]["inDstatus"];
        }

        $curdate = date("Y-m-d H:i:s");
        $year = date("Y");
        $month = date("m");
        $period = $month . $year;

        $transaction = "";
        $tCode = "";

        if ($inType == 1) {
            $transaction = "inv-receipt";
            $tCode = "RCP";
        } else if ($inType == 2) {
            $transaction = "inv-goodsReceipt";
            $tCode = "GRC";
        } else if ($inType == 3) {
            $transaction = "inv-in";
            $tCode = "TIN";
        } else if ($inType == 4) {
            $transaction = "inv-out";
            $tCode = "TOT";
        } else if ($inType == 5) {
            $transaction = "inv-return";
            $tCode = "RTR";
        } else if ($inType == 6) {
            $transaction = "inv-adjIn";
            $tCode = "ADI";
        } else if ($inType == 7) {
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

                    if (($inType != 1) && ($inDqty[$i] > 0)) {
                        // t_stockcard
                        $data5  = array(
                            'id' => '',
                            'transaction_id' => $inventory_id,
                            'warehouse_id' => $inWarehouse,
                            'date' => $inDate,
                            'inventory_type_id' => $inType,
                            'goods_id' => $inDgoods[$i],
                            'qty' => $inDqty[$i],
                            'unit_id' => $inDunitid[$i],
                            'created_by' => $_SESSION['user_id']
                        );

                        $this->db->db_debug = false;

                        if ($this->db->insert('t_stock_card', $data5)) {
                            $res['res'] = 'success';
                        } else {
                            $res['err'] =  $this->db->error();
                            $res['err'] = $res['err']['message'];
                            return $res;
                        }

                        // t_stock 
                        $query6 = "SELECT 
                                    id 
                                    FROM t_stock 
                                    WHERE 
                                    `year` = '" . $year . "' AND 
                                    `month` = '" . $month . "' AND 
                                    warehouse_id  = '" . $inWarehouse . "' AND 
                                    goods_id = '" . $inDgoods[$i] . "'";

                        $row6 = $this->db->query($query6)->num_rows();
                        $data6 = $this->db->query($query6)->row_array();

                        if ($row6 > 0) {
                            $id6 = $data6['id'];

                            if ($inType == 2 || $inType == 5) {
                                $this->db->set('qty_in', 'qty_in +' . $inDqty[$i], FALSE);
                                $this->db->set('qty_balance', 'qty_balance +' . $inDqty[$i], FALSE);
                            } else if ($inType == 3 || $inType == 4 || $inType == 6) {
                                $this->db->set('qty_out', 'qty_out +' . $inDqty[$i], FALSE);
                                $this->db->set('qty_balance', 'qty_balance -' . $inDqty[$i], FALSE);
                            }

                            $this->db->set('log_by', $_SESSION['user_id']);
                            $this->db->set('log_at', $curdate);

                            $this->db->db_debug = false;

                            $this->db->where('id', $id6);

                            if ($this->db->update("t_stock")) {
                                $res['res'] = 'success';
                            } else {
                                $res['res'] =  $this->db->error();
                                $res['res'] = $data['res']['message'];
                                return $res;
                            }
                        } else {
                            $month2 = $month;
                            $year2 = $year;

                            if ($month == 1) {
                                $month2 == 12;
                            } else {
                                $month2 = $month - 1;
                                $year2 = $year - 1;
                            }

                            $query7 = "SELECT 
                                    id 
                                    FROM t_stock 
                                    WHERE 
                                    `year` = '" . $year2 . "' AND 
                                    `month` = '" . $month2 . "' AND 
                                    warehouse_id  = '" . $inWarehouse . "' AND 
                                    goods_id = '" . $inDgoods[$i] . "'";

                            $row7 = $this->db->query($query7)->num_rows();
                            $data7 = $this->db->query($query7)->row_array();

                            if ($row7 > 0) {
                                $qty_in7 = $data7["qty_in"];
                                $qty_out7 = $data7["qty_out"];
                                $qty_balance7 = $data7["qty_balance"];
                            } else {
                                $qty_in7 = 0;
                                $qty_out7 = 0;
                                $qty_balance7 = 0;
                            }

                            if ($inType == 2 || $inType == 5) {
                                $data7  = array(
                                    'id' => '',
                                    'warehouse_id' => $inWarehouse,
                                    'year' => $year,
                                    'month' => $month,
                                    'goods_id' => $inDgoods[$i],
                                    'qty_in' => ($qty_balance7 +  $inDqty[$i]),
                                    'qty_balance' => ($qty_balance7 + $inDqty[$i]),
                                    'created_by' => $_SESSION['user_id']
                                );
                            } else if ($inType == 3 || $inType == 4 || $inType == 6) {
                                $data7  = array(
                                    'id' => '',
                                    'warehouse_id' => $inWarehouse,
                                    'year' => $year,
                                    'month' => $month,
                                    'goods_id' => $inDgoods[$i],
                                    'qty_in' => $qty_balance7,
                                    'qty_out' => $inDqty[$i],
                                    'qty_balance' => ($qty_balance7 - $inDqty[$i]),
                                    'created_by' => $_SESSION['user_id']
                                );
                            }

                            $this->db->db_debug = false;

                            if ($this->db->insert('t_stock', $data7)) {
                                $res['res'] = 'success';
                            } else {
                                $res['err'] =  $this->db->error();
                                $res['err'] = $res['err']['message'];
                                return $res;
                            }
                        }

                        // update receipt detail
                        if ($inType == 2) {
                            $query8 = "UPDATE t_inventory_detail 
                                        SET 
                                        qty_taken = IF(qty_taken IS NULL, " . $inDqty[$i] . ", qty_taken + " . $inDqty[$i] . "),
                                        `status` = 2,
                                        log_by = '" . $_SESSION['user_id'] . "',
                                        log_at = '" . $curdate . "' 
                                        WHERE 
                                        inventory_id = '" . $inTransaction . "' AND 
                                        goods_id = '" . $inDgoods[$i] . "'";

                            $this->db->db_debug = false;

                            if ($this->db->query($query8)) {
                                $res['res'] = 'success';
                            } else {
                                $res['res'] =  $this->db->error();
                                $res['res'] = $data['res']['message'];
                                return $res;
                            }

                            // update qty received in purchase order
                            $query9 = "UPDATE t_purchase_detail 
                                        SET 
                                        qty_received = IF(qty_received IS NULL, " . $inDqty[$i] . ", qty_received + " . $inDqty[$i] . "),
                                        log_by = '" . $_SESSION['user_id'] . "',
                                        log_at = '" . $curdate . "' 
                                        WHERE 
                                        purchase_id = (SELECT transaction_id FROM t_inventory WHERE inventory_id = '" . $inTransaction . "') AND 
                                        goods_id = '" . $inDgoods[$i] . "'";

                            // echo $query9;

                            $this->db->db_debug = false;

                            if ($this->db->query($query9)) {
                                $res['res'] = 'success';
                            } else {
                                $res['res'] =  $this->db->error();
                                $res['res'] = $data['res']['message'];
                                return $res;
                            }
                        }
                    }
                }

                if ($inType == 2) {
                    // update receipt header
                    $data10 = array(
                        'status' => 2,
                        'log_by' => $_SESSION['user_id'],
                        'log_at' => $curdate
                    );

                    $this->db->db_debug = false;

                    $where10 = array(
                        'inventory_id' => $inTransaction
                    );

                    $this->db->where($where10);

                    if ($this->db->update("t_inventory", $data10)) {
                        $res['res'] = 'success';
                    } else {
                        $res['res'] =  $this->db->error();
                        $res['res'] = $data['res']['message'];
                        return $res;
                    }
                }
            }
        } else if ($inMode == "edit") {
            // header
            if (($inType == 1 && $inStatus == 2) || $inType == 2) {
                $data2 = array(
                    'remark' => $inRemark,
                    'log_by' => $_SESSION['user_id'],
                    'log_at' => date("Y-m-d H:i:s")
                );
            } else {
                $data2 = array(
                    'inventory_type_id' => $inType,
                    'warehouse_id' => $inWarehouse,
                    'transaction_id' => $inTransaction,
                    'remark' => $inRemark,
                    'log_by' => $_SESSION['user_id'],
                    'log_at' => date("Y-m-d H:i:s")
                );
            }


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

            if (($inType != 1 && $inStatus != 2) || $inType != 2) {
                if (!empty($inDgoods)) {
                    for ($i = 0; $i < count($inDgoods); $i++) {
                        if ($inDstatus[$i] != 2) {
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
        }

        return $res;
    }

    public function remove($param, $obj)
    {
        $curdate = date("Y-m-d H:i:s");
        $curyear = date("Y");
        $curmonth = date("m");
        $res = array();

        if ($param == "data") {
            $datax = explode("|", $obj);

            $id = $datax[0];
            $inventory_id = $datax[1];
            $inventory_type_id = $datax[2];
            $warehouse_id = $datax[3];
            $transaction_id = $datax[4];

            if ($inventory_type_id == 1) {
            } else if ($inventory_type_id == 2) {
                $status = true;

                $query = "SELECT 
                            goods_id, qty, 
                            YEAR(created_at) AS `year`, 
                            MONTH(created_at) AS `month` 
                            FROM t_inventory_detail 
                            WHERE 
                            inventory_id = '" . $inventory_id . "'";

                $row = $this->db->query($query)->num_rows();

                if ($row > 0) {
                    $res = $this->db->query($query)->result_array();

                    foreach ($res as $data) {
                        $goods_id = $data["goods_id"];
                        $qty = $data["qty"];
                        $year = $data["year"];
                        $month = $data["month"];

                        // check stock
                        $query1 = "SELECT 
                                    qty_balance
                                    FROM t_stock 
                                    WHERE 
                                    `year` = '" . $year . "' AND 
                                    `month` = '" . $month . "' AND 
                                    warehouse_id = '" . $warehouse_id . "' AND 
                                    goods_id = '" . $goods_id . "'";

                        $row1 = $this->db->query($query1)->num_rows();

                        if ($row1 > 0) {
                            $res1 = $this->db->query($query1)->result_array();

                            foreach ($res1 as $data1) {
                                $qty_balance = $data1["qty_balance"];

                                if (($qty_balance - $qty) > 0) {
                                    // t_inventory_details
                                    $data2 = array(
                                        'status' => 0,
                                        'log_by' => $_SESSION['user_id'],
                                        'log_at' => date("Y-m-d H:i:s")
                                    );

                                    $this->db->db_debug = false;

                                    $where2 = array(
                                        'inventory_id' => $inventory_id,
                                        'goods_id ' => $goods_id
                                    );

                                    $this->db->where($where2);

                                    if ($this->db->update("t_inventory_detail", $data2)) {
                                        $res['res'] = 'success';
                                    } else {
                                        $res['res'] =  $this->db->error();
                                        $res['res'] = $data2['res']['message'];
                                        return $res;
                                    }

                                    // t_stock_card
                                    $data3 = array(
                                        'status' => 0,
                                        'log_by' => $_SESSION['user_id'],
                                        'log_at' => date("Y-m-d H:i:s")
                                    );

                                    $this->db->db_debug = false;

                                    $where3 = array(
                                        'transaction_id' => $inventory_id,
                                        'warehouse_id' => $warehouse_id,
                                        'inventory_type_id' => $inventory_type_id,
                                        'goods_id' => $goods_id
                                    );

                                    $this->db->where($where3);

                                    if ($this->db->update("t_stock_card", $data3)) {
                                        $res['res'] = 'success';
                                    } else {
                                        $res['res'] =  $this->db->error();
                                        $res['res'] = $data3['res']['message'];
                                        return $res;
                                    }

                                    // t_stock
                                    if ($inventory_type_id == 2 || $inventory_type_id == 5) {
                                        $this->db->set('qty_in', 'qty_in -' . $qty, FALSE);
                                        $this->db->set('qty_balance', 'qty_balance -' . $qty, FALSE);
                                    } else if ($inventory_type_id == 3 || $inventory_type_id == 4 || $inventory_type_id == 6) {
                                        $this->db->set('qty_out', 'qty_out -' . $qty, FALSE);
                                        $this->db->set('qty_balance', 'qty_balance +' . $qty, FALSE);
                                    }

                                    $this->db->set('log_by', $_SESSION['user_id']);
                                    $this->db->set('log_at', $curdate);

                                    $this->db->db_debug = false;

                                    $where4 = array(
                                        'warehouse_id' => $warehouse_id,
                                        'year' => $year,
                                        'month' => $month,
                                        'goods_id' => $goods_id
                                    );

                                    $this->db->where($where4);

                                    if ($this->db->update("t_stock")) {
                                        $res['res'] = 'success';
                                    } else {
                                        $res['res'] =  $this->db->error();
                                        $res['res'] = $data['res']['message'];
                                        return $res;
                                    }

                                    // update receipt details
                                    $query5 = "UPDATE t_inventory_detail
                                                SET 
                                                qty_taken = (qty_taken - " . $qty . "),
                                                `status` = IF(qty_taken > 0, 2, 1),
                                                log_by = '" . $_SESSION['user_id'] . "',
                                                log_at = '" . date("Y-m-d H:i:s") . "'
                                                WHERE 
                                                inventory_id = '" . $transaction_id . "' AND 
                                                goods_id = '" . $goods_id . "'";

                                    $this->db->db_debug = false;

                                    if ($this->db->query($query5)) {
                                        $res['res'] = 'success';
                                    } else {
                                        $res['res'] =  $this->db->error();
                                        $res['res'] = $data['res']['message'];
                                        return $res;
                                    }
                                } else {
                                    $status = false;
                                }
                            }

                            if ($status) {
                                // update t_inventory
                                $data6 = array(
                                    'status' => 0,
                                    'log_by' => $_SESSION['user_id'],
                                    'log_at' => date("Y-m-d H:i:s")
                                );

                                $this->db->db_debug = false;

                                $where6 = array(
                                    'id' => $datax[0],
                                    'inventory_id' => $datax[1]
                                );

                                $this->db->where($where6);

                                if ($this->db->update("t_inventory", $data6)) {
                                    $res['res'] = 'success';
                                } else {
                                    $res['res'] =  $this->db->error();
                                    $res['res'] = $data6['res']['message'];
                                    return $res;
                                }
                            }
                        }
                    }
                }
            }
        }

        return $res;
    }
}
