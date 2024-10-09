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
                    WHERE `status` <> 0
                )dt1 
                JOIN 
                (
                    SELECT id, inventory_id, goods_id, qty, unit_id
                    FROM t_inventory_detail
                    WHERE `status`  <> 0
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
            $sql = "SELECT id, `type` FROM m_inventory_type a WHERE `status`  <> 0  ORDER BY `id` ASC";
            $data['type'] = $this->db->query($sql)->result_array();

            $this->load->view('inventory/input', $data);
        } elseif ($param == "edit") {
            $data['data'] = $this->Inventory_M->get($param, $obj, "");
            $data['param'] = $param;

            $sql = "SELECT 
                    id, goods ,unit_id, 
                    (SELECT unit FROM m_unit WHERE id = unit_id AND `status`  <> 0) AS unit
                    FROM m_goods 
                    WHERE 
                    `status` = '1' 
                    ORDER BY goods ASC";

            $data['goods'] = $this->db->query($sql)->result_array();

            $sql2 = "SELECT id, `type` FROM m_inventory_type a WHERE `status`  <> 0  ORDER BY `id` ASC";
            $data['type'] = $this->db->query($sql2)->result_array();

            $data['html'] = $this->load->view('inventory/input', $data);
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

        $data = $this->Inventory_M->remove($param, $obj);

        echo (json_encode($data));
    }

    public function report()
    {
        $param = $this->input->get('param');
        $obj = $this->input->get('obj');
        $datax = explode("|", $obj);
        $where = $this->input->get('where');

        if ($param == "print") {
            $data = $this->Inventory_M->get("detail", $obj, "");

            $id = $data["header"]["id"];
            $inventory_id = $data["header"]["inventory_id"];
            $date = $data["header"]["date"];
            $inventory_type_id = $data["header"]["inventory_type_id"];
            $warehouse_id = $data["header"]["warehouse_id"];
            $transaction_id = $data["header"]["transaction_id"];
            $remark = $data["header"]["remark"];
            $type = $data["header"]["type"];
            $warehouse = $data["header"]["warehouse"];

            $fileName = $datax[1];
            $data['title_pdf'] = $fileName;

            $mpdf = new \Mpdf\Mpdf(['format' => 'A5']);

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
                                        <h2>Inventory</h2><br/>
                                        <h4>" . $type . "</h4>
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
                                        <table style=\"width: 100%; table-layout: fixed;\">
                                            <tr>
                                                <td>
                                                    Inventory ID 
                                                </td>
                                                <td>
                                                    : 
                                                </td>
                                                <td>
                                                    " . $inventory_id . "
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Date 
                                                </td>
                                                <td>
                                                    : 
                                                </td>
                                                <td>
                                                    " . $date . "
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style=\"vertical-align: top;\">
                                    <table style=\"width: 100%; table-layout: fixed;\">
                                    <tr>
                                        <td>
                                            Warehouse 
                                        </td>
                                        <td>
                                            : 
                                        </td>
                                        <td>
                                            " . $warehouse . "
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Transaction ID 
                                        </td>
                                        <td>
                                            : 
                                        </td>
                                        <td>
                                            " . $transaction_id . "
                                        </td>
                                    </tr>
                                </table>
                                    </td>
                                </tr>
                            </table>
                        </div>";

            $mpdf->SetHTMLHeader($header);

            $footer = "<table style=\"border-collapse: collapse; border-spacing: 0;display: flex;
            flex-wrap: wrap;\" width=\"100%\" border=\"1\">
                            <tr>
                                <td width=\"70%\" style=\"text-align: left; vertical-align: top;\">
                                    <div>
                                        <table>
                                            <tr>
                                                <td style=\"vertical-align: top;\">Remark</td>
                                                <td style=\"vertical-align: top;\"> : </td>
                                                <td  style=\"vertical-align: top;\">
                                                    " . $remark . "
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br/>
                        <table style=\"border-collapse: collapse; border-spacing: 0;\" width=\"100%\" border=\"1\">
                            <tr>
                                <td width=\"33%\" align=\"center\">Prepared By</td>
                                <td width=\"33%\" align=\"center\">Approved By</td>
                                <td width=\"33%\" align=\"center\">Received By</td>
                            </tr>
                            <tr>
                                <td width=\"33%\" height=\"40\" align=\"center\">
                                    &nbsp;
                                    &nbsp;
                                </td>
                                <td width=\"33%\" align=\"center\">
                                    &nbsp;
                                    &nbsp;
                                </td>
                                <td width=\"33%\" align=\"center\">
                                    &nbsp;
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width=\"33%\" align=\"center\">( ............... )</td>
                                <td width=\"33%\" align=\"center\">( ............... )</td>
                                <td width=\"33%\" align=\"center\">( ............... )</td>
                            </tr>
                        </table>
                        <table width=\"100%\">
                            <tr>
                                <td width=\"33%\">" . $this->session->userdata['name'] . " - {DATE d-m-Y H:i:s}</td>
                                <td width=\"33%\" align=\"center\">{PAGENO}/{nbpg}</td>
                                <td width=\"33%\" style=\"text-align: right;\">" . $inventory_id . "</td>
                            </tr>
                        </table>";

            $mpdf->SetHTMLFooter($footer);

            $html = $this->load->view('report/inventory/print', $data, true);

            $mpdf->AddPage(
                'L', // L - landscape, P - portrait 
                '',
                '',
                '',
                '',
                5, // margin_left
                5, // margin right
                45, // margin top
                45, // margin bottom
                0, // margin header
                1 // margin footer
            );
            $mpdf->showImageErrors = true;
            $mpdf->WriteHTML($html);
            $mpdf->Output($fileName . ".pdf", 'I');
        } else if ($param == "excel") {
            $sql = "SELECT 
                    *, 
                    (SELECT `type` FROM m_inventory_type WHERE id = dt1.inventory_type_id) AS `type`,
                    (SELECT warehouse FROM m_warehouse WHERE id = dt1.warehouse_id) AS warehouse,
                    DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`,
                    (SELECT goods FROM m_goods WHERE id = goods_id) AS goods,
                    (SELECT unit FROM m_unit WHERE id = unit_id) AS unit
                    FROM 
                    (
                        SELECT id, inventory_id, date, inventory_type_id, warehouse_id, transaction_id, remark, created_by, created_at 
                        FROM t_inventory 
                        WHERE `status`  <> 0
                    )dt1 
                    JOIN 
                    (
                        SELECT id, inventory_id, goods_id, qty, unit_id
                        FROM t_inventory_detail
                        WHERE `status`  <> 0
                    )dt2 
                    ON dt1.inventory_id = dt2.inventory_id 
                    WHERE 1  " . $where . " 
                    ORDER BY dt1.created_at DESC";

            $data = $this->db->query($sql)->result_array();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();
            $fileName = 'Report Data Inventory - ' . date("Y-m-d H:i:s");

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

            $sheet->setCellValue('A' . $numrow, "Report Data Inventory");
            $sheet->mergeCells('A' . $numrow . ':I' . $numrow);
            $sheet->getStyle('A' . $numrow)->getFont()->setBold(true);
            $sheet->getStyle('A' . $numrow)->getAlignment()->setHorizontal('center');

            $numrow = $numrow + 2;

            $sheet->setCellValue('A' . $numrow, "Inventory ID");
            $sheet->setCellValue('B' . $numrow, "Date");
            $sheet->setCellValue('C' . $numrow, "Type");
            $sheet->setCellValue('D' . $numrow, "Warehouse");
            $sheet->setCellValue('E' . $numrow, "Transaction ID");
            $sheet->setCellValue('F' . $numrow, "Remark");
            $sheet->setCellValue('G' . $numrow, "Goods");
            $sheet->setCellValue('H' . $numrow, "Qty");
            $sheet->setCellValue('I' . $numrow, "Unit");

            $sheet->getStyle('A' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('B' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('C' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('D' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('E' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('F' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('G' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('H' . $numrow)->applyFromArray($style_col);
            $sheet->getStyle('I' . $numrow)->applyFromArray($style_col);

            $i = 1;
            $numrow = $numrow + 1;
            foreach ($data as $data_inventory) {
                $sheet->setCellValue('A' . $numrow, $data_inventory['inventory_id']);
                $sheet->setCellValue('B' . $numrow, $data_inventory['date']);
                $sheet->setCellValue('C' . $numrow, $data_inventory['type']);
                $sheet->setCellValue('D' . $numrow, $data_inventory['warehouse']);
                $sheet->setCellValue('E' . $numrow, $data_inventory['transaction_id']);
                $sheet->setCellValue('F' . $numrow, $data_inventory['remark']);
                $sheet->setCellValue('G' . $numrow, $data_inventory['goods']);
                $sheet->setCellValue('H' . $numrow, $data_inventory['qty']);
                $sheet->setCellValue('I' . $numrow, $data_inventory['unit']);

                $sheet->getStyle('A' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('B' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('C' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('D' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('E' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('F' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('G' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('H' . $numrow)->applyFromArray($style_row);
                $sheet->getStyle('I' . $numrow)->applyFromArray($style_row);

                $i++;
                $numrow++;
            }

            foreach (range('A', 'I') as $columnID) {
                $sheet->getColumnDimension($columnID)->setAutoSize(true);
            }
            $sheet->getDefaultRowDimension()->setRowHeight(-1);
            $sheet->getPageSetup()->setOrientation(\PhpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE);

            $sheet->setTitle("Report Data Inventory");
            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment; filename="' . $fileName . '.xlsx"'); // Set nama file excel nya
            header('Cache-Control: max-age=0');
            $writer = new Xlsx($spreadsheet);
            $writer->save('php://output');
        } else if ($param == "pdf") {
            $sql = "SELECT 
                    *, 
                    (SELECT `type` FROM m_inventory_type WHERE id = dt1.inventory_type_id) AS `type`,
                    (SELECT warehouse FROM m_warehouse WHERE id = dt1.warehouse_id) AS warehouse,
                    DATE_FORMAT(`date`, '%d-%m-%Y ') AS `date`,
                    (SELECT goods FROM m_goods WHERE id = goods_id) AS goods,
                    (SELECT unit FROM m_unit WHERE id = unit_id) AS unit
                    FROM 
                    (
                        SELECT id, inventory_id, date, inventory_type_id, warehouse_id, transaction_id, remark, created_by, created_at 
                        FROM t_inventory 
                        WHERE `status`  <> 0
                    )dt1 
                    JOIN 
                    (
                        SELECT id, inventory_id, goods_id, qty, unit_id
                        FROM t_inventory_detail
                        WHERE `status`  <> 0
                    )dt2 
                    ON dt1.inventory_id = dt2.inventory_id 
                    WHERE 1  " . $where . " 
                    ORDER BY dt1.created_at DESC";

            $data["inventory"] = $this->db->query($sql)->result_array();

            $fileName = 'Report Data Inventory - ' . date("Y-m-d H:i:s");
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
                            <h3>Report Data Inventory</h3>
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

            $html = $this->load->view('report/inventory/pdf', $data, true);

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
