<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Purchase extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        checkLogin();
        $this->load->model("Purchase_M");
    }

    public function index()
    {
        $data['title'] = 'Purchase';
        $data['user'] = $this->db->get_where('m_user', ['user_id' => $this->session->userdata('user_id')])->row_array();

        $this->load->view('templates/header', $data);
        $this->load->view('templates/sidebar', $data);
        $this->load->view('templates/topbar', $data);
        $this->load->view('purchase/index', $data);
        $this->load->view('templates/footer');
        $this->load->view('templates/script', $data);
    }

    public function viewData()
    {
        $inWhere = $this->input->post('inWhere');

        $sql = "SELECT 
                id, purchase_id, purchase_type_id, supplier_id, due_date, remark, discount, tax, total, `status`, created_by, created_at, log_by, log_at,
                DATE_FORMAT(a.`date`, '%d-%m-%Y ') AS `date`,
                DATE_FORMAT(a.due_date, '%d-%m-%Y ') AS `due_date`,
                (SELECT `type` FROM m_purchase_type WHERE id = a.purchase_type_id) AS `type`,
                (SELECT supplier FROM m_supplier WHERE id = a.supplier_id) AS supplier
                FROM t_purchase a 
                WHERE `status` = 1  " . $inWhere . " 
                ORDER BY created_at DESC";
        $data['purchase'] = $this->db->query($sql)->result_array();

        $this->load->view('purchase/view_data', $data);
    }

    public function get()
    {
        $param = $this->input->post('param');
        $obj = $this->input->post('obj');

        if ($param == "input") {
            $sql = "SELECT id, `type` FROM m_purchase_type a WHERE `status` = 1  ORDER BY `type` ASC";
            $data['type'] = $this->db->query($sql)->result_array();
            $this->load->view('purchase/input', $data);
        } elseif ($param == "edit") {
            $data['data'] = $this->Purchase_M->get($param, $obj);
            $data['param'] = $param;

            $sql = "SELECT id, `type` FROM m_purchase_type a WHERE `status` = 1  ORDER BY `type` ASC";
            $data['type'] = $this->db->query($sql)->result_array();

            $sql2 = "SELECT 
                    id, goods ,unit_id, 
                    (SELECT unit FROM m_unit WHERE id = unit_id AND `status` = 1) AS unit
                    FROM m_goods 
                    WHERE `status` = 1  
                    ORDER BY goods ASC";
            $data['goods'] = $this->db->query($sql2)->result_array();

            $data['html'] = $this->load->view('purchase/input', $data);
            // echo (json_encode($data));
        } else {
            $data = $this->Purchase_M->get($param, $obj);

            echo (json_encode($data));
        }
    }

    public function save()
    {
        $param = $this->input->post('param');
        $obj = $this->input->post('obj');
        $datax = $this->input->post('data');

        if ($param == 'data') {
            $data = $this->Purchase_M->save($param, $obj, $datax);
        }

        echo (json_encode($data));
    }

    public function remove()
    {
        $param = $this->input->post('param');
        $obj = $this->input->post('obj');

        $data = $this->Purchase_M->remove($param, $obj);

        echo (json_encode($data));
    }
}
