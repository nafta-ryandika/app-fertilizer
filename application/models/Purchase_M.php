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

    public function check($param, $obj)
    {
        $res = array();
        if ($param == "inId") {
            $query = "SELECT user_id FROM m_user WHERE user_id = '" . $obj . "'";
            $row = $this->db->query($query)->num_rows();

            $res['res'] = $row;
        }

        return $res;
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
                        WHERE `status` = '1' 
                        ORDER BY goods";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "inRole") {
            $query = "SELECT id, role FROM m_role";
            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->result_array();
            } else {
                return FALSE;
            }
        } else if ($param == "edit") {

            $query = "SELECT 
                        id, user_id, name, email, image, company_id, department_id, division_id, role_id, `status` 
                        FROM m_user 
                        WHERE 
                        id = '" . $obj . "'";

            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->row_array();
            } else {
                return FALSE;
            }
        } else if ($param == "detail") {

            $query = "SELECT 
                        id, user_id, name, email, image, company_id, department_id, division_id, role_id, created_by,
                        DATE_FORMAT(created_at, '%d-%m-%Y %H:%i:%s') as created_at,
                        IF(`status` = 1, 'Active', 'Not Active') as `status`,
                        (SELECT department FROM m_department WHERE id = department_id) AS department,
                        (SELECT division FROM m_division WHERE id = division_id) AS division,
                        (SELECT `role` FROM m_role WHERE id = role_id) AS `role`
                        FROM m_user 
                        WHERE 
                        id = '" . $obj . "'";

            $row = $this->db->query($query)->num_rows();

            if ($row > 0) {
                $data["res"] = $this->db->query($query)->row_array();
            } else {
                return FALSE;
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
            $inId = $data[$i]["inId"];
            $inDate = $data[$i]["inDate"];
            $inType = $data[$i]["inType"];
            $inSupplier = $data[$i]["inSupplier"];
            $inDuedate = $data[$i]["inDuedate"];
            $inRemark = $data[$i]["inRemark"];
            $inDiscount = $data[$i]["inDiscount"];
            $inTax = $data[$i]["inTax"];
            $inTotal = $data[$i]["inTotal"];

            // detail
            $inDgoods = $data[$i]["inDgoods"];
            $inDqty = $data[$i]["inDqty"];
            $inDunitid = $data[$i]["inDunitid"];
            $inDprice = $data[$i]["inDprice"];
            $inDdiscount = $data[$i]["inDdiscount"];
            $inDsubtotal = $data[$i]["inDsubtotal"];
        }

        $period = date("m") . date("Y");
        $transaction = "purchase";
        $counter = 0;

        $query1 = "SELECT `counter` From m_counter WHERE `transaction` = '" . $transaction . "' `period` = '" . $period . " AND `status` = 1'";
        $row = $this->db->query($query1)->num_rows();

        if ($row > 0) {
            $data1 = array(
                'counter' => $counter++,
                'created_by' => $_SESSION['user_id'],
                'created_at' => ,
            );

            $this->db->db_debug = false;

            $this->db->where("id", $inIdx);

            if ($this->db->update("m_user", $data)) {
                $res['res'] = 'success';
            } else {
                $res['res'] =  $this->db->error();
                $res['res'] = $data['res']['message'];
            }
        } else {
            $data1 = array(
                'id' => '',
                'transaction' => $transaction,
                'counter' => $counter++,
                'period' => $period,
                'created_by' => $_SESSION['user_id']
            );

            $this->db->db_debug = false;

            if ($this->db->insert('m_counter', $data1)) {
                $res['res'] = 'success';
            } else {
                $res['err'] =  $this->db->error();
                $res['err'] = $res['err']['message'];
                return $res;
            }
        }

        $data = array(
            'id' => '',
            'user_id' => $inId,
            'name' => $inName,
            'email' => $inEmail,
            'image' => "default.png",
            'password' => addslashes($inPassword),
            'company_id' => '1',
            'department_id' => $inDepartment,
            'division_id' => $inDivision,
            'role_id' => $inRole,
            'status' => $inStatus,
            'created_by' => $_SESSION['user_id']
        );

        $this->db->db_debug = false;

        if ($this->db->insert('m_user', $data)) {
            $res['res'] = 'success';
        } else {
            $res['err'] =  $this->db->error();
            $res['err'] = $res['err']['message'];
        }

        var_dump($period);
        die();
        if ($param == 'data') {
            if ($inMode == "add") {
            } else if ($inMode == "edit") {
                $data = array(
                    'user_id' => $inId,
                    'name' => $inName,
                    'email' => $inEmail,
                    'image' => "default.png",
                    'company_id' => '1',
                    'department_id' => $inDepartment,
                    'division_id' => $inDivision,
                    'role_id' => $inRole,
                    'status' => $inStatus,
                    'created_by' => $_SESSION['user_id'],
                    'created_at' => date('Y-m-d H:i:s')
                );

                $this->db->db_debug = false;

                $this->db->where("id", $inIdx);

                if ($this->db->update("m_user", $data)) {
                    $res['res'] = 'success';
                } else {
                    $res['res'] =  $this->db->error();
                    $res['res'] = $data['res']['message'];
                }
            }
        }

        return $res;
    }

    public function remove($param, $obj)
    {
        $res = array();

        if ($param == "data") {
            $this->db->db_debug = false;
            $this->db->where('id', $obj);

            if ($this->db->delete('m_user')) {
                $res['res'] = 'success';
            } else {
                $res['res'] = $this->db->error();
                $res['res'] = $res['res']['message'];
            }
        } else if ($param == "password") {
            $length = 6;
            $inPassword =  substr(str_shuffle('0123456789'), 1, $length);

            $data = array(
                'password' => addslashes(password_hash($inPassword, PASSWORD_DEFAULT)),
                'created_by' => $_SESSION['user_id'],
                'created_at' => date('Y-m-d H:i:s')
            );

            $this->db->db_debug = false;

            $this->db->where("id", $obj);

            if ($this->db->update("m_user", $data)) {
                $res['res'] = 'success';
                $res['password'] = $inPassword;
            } else {
                $res['res'] =  $this->db->error();
                $res['res'] = $data['res']['message'];
            }
        }

        return $res;
    }
}
