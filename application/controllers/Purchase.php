<?php
defined('BASEPATH') or exit('No direct script access allowed');

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

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
                (SELECT supplier FROM m_supplier WHERE id = a.supplier_id) AS supplier,
                (SELECT currency FROM m_currency WHERE id = a.currency_id) AS currency
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

            $sql2 = "SELECT id, currency FROM m_currency a WHERE `status` = 1  ORDER BY `currency` ASC";
            $data['currency'] = $this->db->query($sql2)->result_array();

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

            $sql3 = "SELECT id, currency FROM m_currency a WHERE `status` = 1  ORDER BY `currency` ASC";
            $data['currency'] = $this->db->query($sql3)->result_array();

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

    public function report()
    {
        $param = $this->input->get('param');
        $obj = $this->input->get('obj');
        $datax = explode("|", $obj);
        $where = $this->input->get('where');

        if ($param == "print") {
            $data = $this->Purchase_M->get("detail", $obj);

            $id = $data["header"]["id"];
            $purchase_id = $data["header"]["purchase_id"];
            $date = $data["header"]["date"];
            $purchase_type_id = $data["header"]["purchase_type_id"];
            $supplier_id = $data["header"]["supplier_id"];
            $due_date = $data["header"]["due_date"];
            $remark = $data["header"]["remark"];
            $currency = $data["header"]["currency"];
            $discount = $data["header"]["discount"];
            $tax = $data["header"]["tax"];
            $total = $data["header"]["total"];
            $type = $data["header"]["type"];
            $supplier = $data["header"]["supplier"];

            $query1 = "SELECT 
                        id, supplier, pic, phone, `address`, remark 
                        FROM m_supplier 
                        WHERE 
                        id = '" . $supplier_id . "' AND
                        `status` = 1 ";

            $data1 =  $this->db->query($query1)->row_array();

            $pic = $data1["pic"];
            $phone = $data1["phone"];
            $address = $data1["address"];

            // $data['exit_permit'] = $this->db->query($sql_exit_permit)->result_array();

            $fileName = $datax[1];
            $data['title_pdf'] = $fileName;

            $mpdf = new \Mpdf\Mpdf();

            $mpdf->SetTitle($fileName);

            $header =   "<br/>
                        <div class=\"row col-12\">
                            <table style=\"width: 100%; table-layout: fixed;\">
                                <tr>
                                    <td style=\"width: 55%; vertical-align: top;\">
                                        <table style=\"width: 100%; table-layout: fixed;\">
                                            <tr>
                                                <td>
                                                    <img src='" . base_url() . "assets/img/icon-small.png'>
                                                </td>
                                                <td style=\"vertical-align: top;\">
                                                    <h4>
                                                        PT AGRI MAKMUR MEGA PERKASA INDO<br/>
                                                    </h4>
                                                    <h5>
                                                        Pasuruan Indonesia
                                                    </h5>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style=\"width: 45%; vertical-align: top; text-align: right;\">
                                        <h2>PURCHASE ORDER</h2>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style=\"vertical-align: top; text-align: right;\">
                                        <table>
                                            <tr>
                                                <td style=\"text-align: left;\">Date</td>
                                                <td>:</td>
                                                <td>" . $date . "</td>
                                            </tr>
                                            <tr>
                                                <td style=\"text-align: left;\">Purchase No</td>
                                                <td>:</td>
                                                <td>" . $purchase_id . "</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan=\"2\"><hr></td>
                                </tr>
                                <tr>
                                    <td style=\"vertical-align: top;\">
                                    </td>
                                </tr>
                                <tr>
                                    <td style=\"vertical-align: top;\">
                                        <div class=\"col-6\">
                                            <h4>
                                                " . $supplier . "
                                            </h4>
                                            " . $address . " <br/>
                                            " . $pic . " <br/>
                                            " . $phone . " <br/>
                                        </div>
                                    </td>
                                    <td style=\"text-align: right; vertical-align: top;\">
                                        <div class=\"col-6\">
                                            <h4>
                                                PT AGRI MAKMUR MEGA PERKASA INDO
                                            </h4>
                                            Pasuruan Indonesia<br/>
                                            (0343) xxxxx<br/>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>";

            $mpdf->SetHTMLHeader($header);

            $footer1 = "<table width=\"100%\" border=\"1\">
                            <tr>
                                <td width=\"70%\" style=\"text-align: left; vertical-align: top;\">
                                    Due Date : " . $due_date . "<br/>
                                    Currency : " . $currency . "<br/>
                                    Remark : " . $remark . " <br/>
                                </td>
                                <td width=\"30%\" style=\"text-align: center; vertical-align: top;\">
                                    <table style=\"text-align: center;\" border=\"0\">
                                        <tr>
                                            <td width=\"33%\" style=\"text-align: center;\">
                                                Approved By    
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td><u>Purchase</u></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width=\"100%\">
                            <tr>
                                <td width=\"33%\">" . $this->session->userdata['name'] . " - {DATE d-m-Y H:i:s}</td>
                                <td width=\"33%\" align=\"center\">{PAGENO}/{nbpg}</td>
                                <td width=\"33%\" style=\"text-align: right;\">" . $purchase_id . "</td>
                            </tr>
                        </table>";

            $footer = "<table style=\"border-collapse: collapse;\" width=\"100%\" border=\"1\">
                            <tr>
                                <td width=\"70%\" style=\"text-align: left; vertical-align: top;\">
                                    <div>
                                        <table>
                                            <tr>
                                                <td style=\"vertical-align: top;\">Due date</td>
                                                <td style=\"vertical-align: top;\">:</td>
                                                <td>" . $due_date . "</td>
                                            </tr>
                                            <tr>
                                                <td style=\"vertical-align: top;\">Currency</td>
                                                <td style=\"vertical-align: top;\">:</td>
                                                <td>" . $currency . "</td>
                                            </tr>
                                            <tr>
                                                <td style=\"vertical-align: top;\">Remark</td>
                                                <td style=\"vertical-align: top;\">:</td>
                                                <td>" . $remark . "</td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td width=\"30%\" style=\"text-align: center; vertical-align: top;  border: 1px solid;\">
                                    <table style=\"text-align: center;\" border=\"0\">
                                        <tr>
                                            <td width=\"33%\" style=\"text-align: center;\">
                                                Approved By    
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td><u>Purchase</u></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width=\"100%\">
                            <tr>
                                <td width=\"33%\">" . $this->session->userdata['name'] . " - {DATE d-m-Y H:i:s}</td>
                                <td width=\"33%\" align=\"center\">{PAGENO}/{nbpg}</td>
                                <td width=\"33%\" style=\"text-align: right;\">" . $purchase_id . "</td>
                            </tr>
                        </table>";

            $mpdf->SetHTMLFooter($footer);

            $html = $this->load->view('report/purchase/print', $data, true);

            $mpdf->AddPage(
                'P', // L - landscape, P - portrait 
                '',
                '',
                '',
                '',
                5, // margin_left
                5, // margin right
                70, // margin top
                70, // margin bottom
                0, // margin header
                1 // margin footer
            );
            $mpdf->showImageErrors = true;
            $mpdf->WriteHTML($html);
            $mpdf->Output($fileName . ".pdf", 'I');
        } else if ($param == "excel") {
            $sql = "SELECT 
                    *, 
                    DATE_FORMAT(a.`date`, '%d-%m-%Y ') AS `date`,
                    DATE_FORMAT(a.due_date, '%d-%m-%Y ') AS `due_date`,
                    (SELECT `type` FROM m_purchase_type WHERE id = a.purchase_type_id) AS `type`,
                    (SELECT supplier FROM m_supplier WHERE id = a.supplier_id) AS supplier,
                    (SELECT goods FROM m_goods WHERE id = b.goods_id) AS goods, 
                    (SELECT unit FROM m_unit WHERE id = b.unit_id) AS unit
                    FROM 
                        (
                        SELECT 
                            id, purchase_id, `date`, purchase_type_id, supplier_id, due_date,remark, discount, tax, total, created_at
                    FROM t_purchase
                    WHERE `status` = 1 " . $where . "
                        )a 
                    INNER JOIN 
                        (
                        SELECT 
                        id, purchase_id, goods_id, qty, unit_id, price, discount, subtotal, qty_received 
                        FROM t_purchase_detail 
                        WHERE `status` = 1
                        )b
                    ON a.purchase_id = b.purchase_id	 
                    ORDER BY a.created_at DESC";

            $data = $this->db->query($sql)->result_array();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();
            $fileName = 'Report Data Purchase - ' . date("Y-m-d H:i:s");

            $style_col = [
                'font' => ['bold' => true], // Set font nya jadi bold
                'alignment' => [
                    'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER, // Set text jadi ditengah secara horizontal (center)
                    'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER // Set text jadi di tengah secara vertical (middle)
                ],
                'borders' => [
                    'top' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN], // Set border top dengan garis tipis
                    'right' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN],  // Set border right dengan garis tipis
                    'bottom' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN], // Set border bottom dengan garis tipis
                    'left' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN] // Set border left dengan garis tipis
                ]
            ];

            $style_row = [
                'alignment' => [
                    'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER // Set text jadi di tengah secara vertical (middle)
                ],
                'borders' => [
                    'top' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN], // Set border top dengan garis tipis
                    'right' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN],  // Set border right dengan garis tipis
                    'bottom' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN], // Set border bottom dengan garis tipis
                    'left' => ['borderStyle'  => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN] // Set border left dengan garis tipis
                ]
            ];

            $numrow = 1;
            $drawing = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
            $drawing->setPath("assets/img/icon-small.png");
            $drawing->setCoordinates('A' . $numrow);
            $drawing->setWorksheet($spreadsheet->getActiveSheet());

            $sheet->setCellValue('B' . $numrow, "PT AGRI MAKMUR MEGA PERKASA INDO");
            $sheet->setCellValue('B' . $numrow + 1, "Pasuruan Indonesia");
            $sheet->setCellValue('B' . $numrow + 2, "Telp. (0343) xxxxxx");

            $sheet->getStyle('D' . $numrow . ':D' . $numrow + 3)->getFont()->setBold(true);

            $numrow = $numrow + 4;

            $sheet->setCellValue('A' . $numrow, "Report Data Purchase");
            $sheet->mergeCells('A' . $numrow . ':O' . $numrow);
            $sheet->getStyle('A' . $numrow)->getFont()->setBold(true);
            $sheet->getStyle('A' . $numrow)->getAlignment()->setHorizontal('center');

            $numrow = $numrow + 2;

            $sheet->setCellValue('A' . $numrow, "Purchase Id");
            $sheet->setCellValue('B' . $numrow, "Date");
            $sheet->setCellValue('C' . $numrow, "Type");
            $sheet->setCellValue('D' . $numrow, "Supplier");
            $sheet->setCellValue('E' . $numrow, "Due Date");
            $sheet->setCellValue('F' . $numrow, "Discount");
            $sheet->setCellValue('G' . $numrow, "Tax");
            $sheet->setCellValue('H' . $numrow, "Total");
            $sheet->setCellValue('I' . $numrow, "Goods");
            $sheet->setCellValue('J' . $numrow, "Qty");
            $sheet->setCellValue('K' . $numrow, "Unit");
            $sheet->setCellValue('L' . $numrow, "Price");
            $sheet->setCellValue('M' . $numrow, "Discount");
            $sheet->setCellValue('N' . $numrow, "Subtotal");
            $sheet->setCellValue('O' . $numrow, "Qty Received");

            $sheet->getStyle('A' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('B' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('C' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('D' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('E' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('F' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('G' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('H' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('I' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('J' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('K' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('L' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('M' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('N' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('O' . $numrow)->applyFromArray($style_col);


            $i = 1;
            $numrow = $numrow + 1;
            foreach ($data as $data_purchase) {
                $sheet->setCellValue('A' . $numrow, $data_purchase['purchase_id']);
                $sheet->setCellValue('B' . $numrow, $data_purchase['date']);
                $sheet->setCellValue('C' . $numrow, $data_purchase['type']);
                $sheet->setCellValue('D' . $numrow, $data_purchase['supplier']);
                $sheet->setCellValue('E' . $numrow, $data_purchase['due_date']);
                $sheet->setCellValue('F' . $numrow, $data_purchase['discount']);
                $sheet->setCellValue('G' . $numrow, $data_purchase['tax']);
                $sheet->setCellValue('H' . $numrow, $data_purchase['total']);
                $sheet->setCellValue('I' . $numrow, $data_purchase['goods']);
                $sheet->setCellValue('J' . $numrow, $data_purchase['qty']);
                $sheet->setCellValue('K' . $numrow, $data_purchase['unit']);
                $sheet->setCellValue('L' . $numrow, $data_purchase['price']);
                $sheet->setCellValue('M' . $numrow, $data_purchase['discount']);
                $sheet->setCellValue('N' . $numrow, $data_purchase['subtotal']);
                $sheet->setCellValue('O' . $numrow, $data_purchase['qty_received']);

                $sheet->getStyle('A' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('B' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('C' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('D' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('E' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('F' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('G' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('H' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('I' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('J' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('K' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('L' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('M' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('N' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('O' . $numrow)->applyFromArray($style_row);


                $i++;
                $numrow++;
            }

            foreach (range('A', 'O') as $columnID) {
                $sheet->getColumnDimension($columnID)->setAutoSize(true);
            }
            $sheet->getDefaultRowDimension()->setRowHeight(-1);
            $sheet->getPageSetup()->setOrientation(\PhpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE);

            $sheet->setTitle("Report Data Purchase");
            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment; filename="' . $fileName . '.xlsx"'); // Set nama file excel nya
            header('Cache-Control: max-age=0');
            $writer = new Xlsx($spreadsheet);
            $writer->save('php://output');
        } else if ($param == "pdf") {
            $sql = "SELECT 
                    *, 
                    DATE_FORMAT(a.`date`, '%d-%m-%Y ') AS `date`,
                    DATE_FORMAT(a.due_date, '%d-%m-%Y ') AS `due_date`,
                    (SELECT `type` FROM m_purchase_type WHERE id = a.purchase_type_id) AS `type`,
                    (SELECT supplier FROM m_supplier WHERE id = a.supplier_id) AS supplier,
                    (SELECT goods FROM m_goods WHERE id = b.goods_id) AS goods, 
                    (SELECT unit FROM m_unit WHERE id = b.unit_id) AS unit
                    FROM 
                        (
                        SELECT 
                            id, purchase_id, `date`, purchase_type_id, supplier_id, due_date,remark, discount, tax, total, created_at
                    FROM t_purchase
                    WHERE `status` = 1 " . $where . "
                        )a 
                    INNER JOIN 
                        (
                        SELECT 
                        id, purchase_id, goods_id, qty, unit_id, price, discount, subtotal, qty_received 
                        FROM t_purchase_detail 
                        WHERE `status` = 1
                        )b
                    ON a.purchase_id = b.purchase_id	 
                    ORDER BY a.created_at DESC";

            $data["purchase"] = $this->db->query($sql)->result_array();

            $fileName = 'Report Data Purchase - ' . date("Y-m-d H:i:s");
            $data['title_pdf'] = $fileName;

            $mpdf = new \Mpdf\Mpdf(['format' => 'Legal']);

            $mpdf->SetTitle($fileName);

            $header =   "<table>
                            <tr>
                                <td>
                                    <img src='" . base_url() . "assets/img/icon-small.png'> 
                                </td>
                                <td>
                                    <b style='font-size: 20px;'>PT AGRI MAKMUR MEGA PERKASA INDO</b><br/>
                                    <b>Pasuruan Indonesia</b><br/>
                                    Telp. (0343) xxxxxx
                                </td>
                            </tr>
                        </table>
                        <div style='text-align:center'>
                            <h3>Report Data Purchase</h3>
                        </div>";

            $mpdf->SetHTMLHeader($header);

            $footer = "<table width=\"100%\">
                            <tr>
                                <td width=\"33%\">" . $this->session->userdata['name'] . " - {DATE d-m-Y H:i:s}</td>
                                <td width=\"33%\"></td>
                                <td width=\"33%\" style=\"text-align: right;\">{PAGENO}/{nbpg}</td>
                            </tr>
                        </table>";

            $mpdf->SetHTMLFooter($footer);

            $html = $this->load->view('report/purchase/pdf', $data, true);

            $mpdf->AddPage(
                'L', // L - landscape, P - portrait 
                '',
                '',
                '',
                '',
                5, // margin_left
                5, // margin right
                30, // margin top
                5, // margin bottom
                0, // margin header
                1 // margin footer
            );
            $mpdf->showImageErrors = true;
            $mpdf->WriteHTML($html);
            $mpdf->Output($fileName . ".pdf", 'I');
        }
    }
}
