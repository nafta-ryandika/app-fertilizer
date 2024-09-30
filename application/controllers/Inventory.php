<?php
defined('BASEPATH') or exit('No direct script access allowed');

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class Inventory extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        checkLogin();
        $this->load->model("Inventory_M");
    }

    public function index()
    {
        $data['title'] = 'Inventory';
        $data['user'] = $this->db->get_where('m_user', ['user_id' => $this->session->userdata('user_id')])->row_array();

        $this->load->view('templates/header', $data);
        $this->load->view('templates/sidebar', $data);
        $this->load->view('templates/topbar', $data);
        $this->load->view('inventory/index', $data);
        $this->load->view('templates/footer');
        $this->load->view('templates/script', $data);
    }

    public function viewData()
    {
        $inWhere = $this->input->post('inWhere');

        $sql = "SELECT 
                dt1.*, 
                (SELECT `type` FROM m_inventory_type WHERE id = dt1.inventory_type_id) AS `type`,
                (SELECT warehouse FROM m_warehouse WHERE id = dt1.warehouse_id) AS warehouse,
                GROUP_CONCAT((SELECT goods FROM m_goods WHERE id = goods_id),' ') AS goods,
                DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`
                FROM 
                (
                    SELECT id, inventory_id, date, inventory_type_id, warehouse_id, transaction_id, remark, created_by, created_at 
                    FROM t_inventory 
                    WHERE `status` = 1
                )dt1 
                JOIN 
                (
                    SELECT id, inventory_id, goods_id, qty, unit_id
                    FROM t_inventory_detail
                    WHERE `status` = 1
                )dt2 
                ON dt1.inventory_id = dt2.inventory_id 
                WHERE 1  " . $inWhere . " 
                GROUP BY dt1.id 
                ORDER BY dt1.created_at DESC";

        $data['inventory'] = $this->db->query($sql)->result_array();

        $this->load->view('inventory/view_data', $data);
    }

    public function get()
    {
        $param = $this->input->post('param');
        $obj = $this->input->post('obj');
        $datax = $this->input->post('data');

        if ($param == "input") {
            $sql = "SELECT id, `type` FROM m_inventory_type a WHERE `status` = 1  ORDER BY `id` ASC";
            $data['type'] = $this->db->query($sql)->result_array();

            $this->load->view('inventory/input', $data);
        } elseif ($param == "edit") {
            $data['data'] = $this->Sales_M->get($param, $obj);
            $data['param'] = $param;

            $sql = "SELECT 
                    id, goods ,unit_id, 
                    (SELECT unit FROM m_unit WHERE id = unit_id AND `status` = 1) AS unit
                    FROM m_goods 
                    WHERE 
                    `status` = '1' AND 
                    goods_type_id = '2' 
                    ORDER BY goods ASC";
            $data['goods'] = $this->db->query($sql)->result_array();

            $sql3 = "SELECT id, currency FROM m_currency a WHERE `status` = 1  ORDER BY `currency` ASC";
            $data['currency'] = $this->db->query($sql3)->result_array();

            $data['html'] = $this->load->view('sales/input', $data);
            // echo (json_encode($data));
        } else {
            $data = $this->Inventory_M->get($param, $obj, $datax);

            echo (json_encode($data));
        }
    }

    public function save()
    {
        $param = $this->input->post('param');
        $obj = $this->input->post('obj');
        $datax = $this->input->post('data');

        if ($param == 'data') {
            $data = $this->Inventory_M->save($param, $obj, $datax);
        }

        echo (json_encode($data));
    }

    public function remove()
    {
        $param = $this->input->post('param');
        $obj = $this->input->post('obj');

        $data = $this->Sales_M->remove($param, $obj);

        echo (json_encode($data));
    }

    public function report()
    {
        $param = $this->input->get('param');
        $obj = $this->input->get('obj');
        $datax = explode("|", $obj);
        $where = $this->input->get('where');

        if ($param == "print") {
            $data = $this->Sales_M->get("detail", $obj);

            $id = $data["header"]["id"];
            $sales_id = $data["header"]["sales_id"];
            $date = $data["header"]["date"];
            $customer_id = $data["header"]["customer_id"];
            $due_date = $data["header"]["due_date"];
            $remark = $data["header"]["remark"];
            $currency = $data["header"]["currency"];
            $discount = $data["header"]["discount"];
            $tax_type = $data["header"]["tax_type"];
            $tax = $data["header"]["tax"];
            $total = $data["header"]["total"];
            $customer = $data["header"]["customer"];

            $query1 = "SELECT 
                        id, customer, pic, phone, `address`, remark 
                        FROM m_customer 
                        WHERE 
                        id = '" . $customer_id . "' AND
                        `status` = 1 ";

            $data1 =  $this->db->query($query1)->row_array();

            $pic = $data1["pic"];
            $phone = $data1["phone"];
            $address = $data1["address"];

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
                                                    <b style='font-size: 15px;'>PT AGRI MAKMUR MEGA PERKASA INDO</b><br/>
                                                    <b style='font-size: 14px;'>Dsn. Gudang Ds. Cengkrong</b><br/>
                                                    <b style='font-size: 14px;'>Paserpan, Pasuruan</b><br/>
                                                    <b style='font-size: 12px;'>Telp. 082245536228</b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style=\"width: 45%; vertical-align: top; text-align: right;\">
                                        <h2>SALES ORDER</h2>
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
                                                <td style=\"text-align: left;\">Sales No</td>
                                                <td>:</td>
                                                <td>" . $sales_id . "</td>
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
                                            <b style='font-size: 15px;'>" . $customer . "</b><br/>
                                            <b style='font-size: 12px;'>" . $address . " </b><br/>
                                            <b style='font-size: 12px;'>" . $pic . " <b/><br/>
                                            <b style='font-size: 11px;'>" . $phone . " <b/><br/>
                                        </div>
                                    </td>
                                    <td style=\"text-align: right; vertical-align: top;\">
                                        <div class=\"col-6\">
                                            <b style='font-size: 15px;'>PT AGRI MAKMUR MEGA PERKASA INDO</b><br/>
                                            <b style='font-size: 12px;'>Dsn. Gudang Ds. Cengkrong</b><br/>
                                            <b style='font-size: 12px;'>Paserpan, Pasuruan</b><br/>
                                            <b style='font-size: 11px;'>Telp. 082245536228</b>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>";

            $mpdf->SetHTMLHeader($header);

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

            $html = $this->load->view('report/sales/print', $data, true);

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
                    (SELECT customer FROM m_customer WHERE id = a.customer_id) AS customer,
                    (SELECT goods FROM m_goods WHERE id = b.goods_id) AS goods, 
                    (SELECT unit FROM m_unit WHERE id = b.unit_id) AS unit,
                    (SELECT currency FROM m_currency WHERE id = a.currency_id) AS currency,
                    (a.discount) AS discount,
                    (b.discount) AS discount_detail,
                    (IF(a.tax_type = 1, 'Include', 'Exclude')) AS tax_type
                    FROM 
                        (
                        SELECT 
                            id, sales_id, `date`, customer_id, due_date,remark, currency_id,  discount, tax_type, tax, total, created_at
                    FROM t_sales
                    WHERE `status` = 1 " . $where . "
                        )a 
                    INNER JOIN 
                        (
                        SELECT 
                        id, sales_id, goods_id, qty, unit_id, price, discount, subtotal, qty_shipped 
                        FROM t_sales_detail 
                        WHERE `status` = 1
                        )b
                    ON a.sales_id = b.sales_id	 
                    ORDER BY a.created_at DESC";

            $data = $this->db->query($sql)->result_array();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();
            $fileName = 'Report Data Sales - ' . date("Y-m-d H:i:s");

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
            $sheet->setCellValue('B' . $numrow + 1, "Dsn. Gudang Ds. Cengkrong");
            $sheet->setCellValue('B' . $numrow + 2, "Paserpan, Pasuruan");
            $sheet->setCellValue('B' . $numrow + 3, "Telp. 082245536228");

            $sheet->getStyle('D' . $numrow . ':D' . $numrow + 4)->getFont()->setBold(true);

            $numrow = $numrow + 5;

            $sheet->setCellValue('A' . $numrow, "Report Data Sales");
            $sheet->mergeCells('A' . $numrow . ':P' . $numrow);
            $sheet->getStyle('A' . $numrow)->getFont()->setBold(true);
            $sheet->getStyle('A' . $numrow)->getAlignment()->setHorizontal('center');

            $numrow = $numrow + 2;

            $sheet->setCellValue('A' . $numrow, "Sales Id");
            $sheet->setCellValue('B' . $numrow, "Date");
            $sheet->setCellValue('C' . $numrow, "Customer");
            $sheet->setCellValue('D' . $numrow, "Due Date");
            $sheet->setCellValue('E' . $numrow, "Currency");
            $sheet->setCellValue('F' . $numrow, "Discount (%)");
            $sheet->setCellValue('G' . $numrow, "Tax Type");
            $sheet->setCellValue('H' . $numrow, "Tax (%)");
            $sheet->setCellValue('I' . $numrow, "Total");
            $sheet->setCellValue('J' . $numrow, "Goods");
            $sheet->setCellValue('K' . $numrow, "Qty");
            $sheet->setCellValue('L' . $numrow, "Unit");
            $sheet->setCellValue('M' . $numrow, "Price");
            $sheet->setCellValue('N' . $numrow, "Discount Item (%)");
            $sheet->setCellValue('O' . $numrow, "Subtotal");
            $sheet->setCellValue('P' . $numrow, "Qty Shipped");

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
            $sheet->getStyle('P' . $numrow)->applyFromArray($style_col);


            $i = 1;
            $numrow = $numrow + 1;
            foreach ($data as $data_sales) {
                $sheet->setCellValue('A' . $numrow, $data_sales['sales_id']);
                $sheet->setCellValue('B' . $numrow, $data_sales['date']);
                $sheet->setCellValue('C' . $numrow, $data_sales['customer']);
                $sheet->setCellValue('D' . $numrow, $data_sales['due_date']);
                $sheet->setCellValue('E' . $numrow, $data_sales['currency']);
                $sheet->setCellValue('F' . $numrow, $data_sales['discount']);
                $sheet->setCellValue('G' . $numrow, $data_sales['tax_type']);
                $sheet->setCellValue('H' . $numrow, $data_sales['tax']);
                $sheet->setCellValue('I' . $numrow, $data_sales['total']);
                $sheet->setCellValue('J' . $numrow, $data_sales['goods']);
                $sheet->setCellValue('K' . $numrow, $data_sales['qty']);
                $sheet->setCellValue('L' . $numrow, $data_sales['unit']);
                $sheet->setCellValue('M' . $numrow, $data_sales['price']);
                $sheet->setCellValue('N' . $numrow, $data_sales['discount_detail']);
                $sheet->setCellValue('O' . $numrow, $data_sales['subtotal']);
                $sheet->setCellValue('P' . $numrow, $data_sales['qty_shipped']);

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
                $sheet->getStyle('P' . $numrow)->applyFromArray($style_row);


                $i++;
                $numrow++;
            }

            foreach (range('A', 'P') as $columnID) {
                $sheet->getColumnDimension($columnID)->setAutoSize(true);
            }
            $sheet->getDefaultRowDimension()->setRowHeight(-1);
            $sheet->getPageSetup()->setOrientation(\PhpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE);

            $sheet->setTitle("Report Data Sales");
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
                    (SELECT customer FROM m_customer WHERE id = a.customer_id) AS customer,
                    (SELECT goods FROM m_goods WHERE id = b.goods_id) AS goods, 
                    (SELECT unit FROM m_unit WHERE id = b.unit_id) AS unit,
                    (SELECT currency FROM m_currency WHERE id = a.currency_id) AS currency,
                    (a.discount) AS discount,
                    (b.discount) AS discount_detail,
                    (IF(a.tax_type = 1, 'Include', 'Exclude')) AS tax_type
                    FROM 
                        (
                        SELECT 
                            id, sales_id, `date`, customer_id, due_date, remark, currency_id,  discount, tax_type, tax, total, created_at
                    FROM t_sales
                    WHERE `status` = 1 " . $where . "
                        )a 
                    INNER JOIN 
                        (
                        SELECT 
                        id, sales_id, goods_id, qty, unit_id, price, discount, subtotal, qty_shipped 
                        FROM t_sales_detail 
                        WHERE `status` = 1
                        )b
                    ON a.sales_id = b.sales_id	 
                    ORDER BY a.created_at DESC";

            $data["sales"] = $this->db->query($sql)->result_array();

            $fileName = 'Report Data Sales - ' . date("Y-m-d H:i:s");
            $data['title_pdf'] = $fileName;

            $mpdf = new \Mpdf\Mpdf(['format' => 'Legal']);

            $mpdf->SetTitle($fileName);

            $header =   "<table>
                            <tr>
                                <td>
                                    <img src='" . base_url() . "assets/img/icon-small.png'> 
                                </td>
                                <td>
                                    <b style='font-size: 18px;'>PT AGRI MAKMUR MEGA PERKASA INDO</b><br/>
                                    <b style='font-size: 14px;'>Dsn. Gudang Ds. Cengkrong</b><br/>
                                    <b style='font-size: 14px;'>Paserpan, Pasuruan</b><br/>
                                    <b style='font-size: 12px;'>Telp. 082245536228</b>
                                </td>
                            </tr>
                        </table>
                        <div style='text-align:center'>
                            <h3>Report Data Sales</h3>
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

            $html = $this->load->view('report/sales/pdf', $data, true);

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
