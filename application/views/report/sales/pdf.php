<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $title_pdf; ?></title>
    <style>
        table {
            border-collapse: collapse;
        }

        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
            background-color: transparent;
        }

        .table th,
        .table td {
            padding: 0.75rem;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }

        .table thead th {
            vertical-align: bottom;
            border-bottom: 2px solid #dee2e6;
        }

        .table tbody+tbody {
            border-top: 2px solid #dee2e6;
        }

        .table-bordered {
            border: 1px solid #dee2e6;
        }

        .table-bordered th,
        .table-bordered td {
            border: 1px solid #dee2e6;
        }

        .table-bordered thead th,
        .table-bordered thead td {
            border-bottom-width: 2px;
        }

        .table-bordered th,
        .table-bordered td {
            border: 1px solid #dee2e6 !important;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.05);
        }

        header {
            position: fixed;
            left: 0px;
            right: 0px;
            height: 60px;
            margin-top: 60px;
        }

        /* footer{
        position: fixed;
        left: 0px;
        right: 0px;
        height: 50px;
        margin-bottom: -50px;
      } */
    </style>
</head>

<body>
    <table class="table table-bordered table-striped" style="page-break-inside: auto !important;">
        <thead>
            <tr>
                <th scope="col">No</th>
                <th scope="col">Sales Id</th>
                <th scope="col">Date</th>
                <th scope="col">Customer</th>
                <th scope="col">Due Date</th>
                <th scope="col">Currency</th>
                <th scope="col">Discount (%)</th>
                <th scope="col">Tax Type</th>
                <th scope="col">Tax (%)</th>
                <th scope="col">Total</th>
                <th scope="col">Goods</th>
                <th scope="col">Qty</th>
                <th scope="col">Unit</th>
                <th scope="col">Price</th>
                <th scope="col">Discount Item (%)</th>
                <th scope="col">Subtotal</th>
                <th scope="col">Qty Shipped</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $i = 1;

            foreach ($sales as $data_sales) {
                echo '<tr>';
                echo '<td style="text-align: center;">' . $i . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['sales_id'] . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['date'] . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['customer'] . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['due_date'] . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['currency'] . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['discount'] . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['tax_type'] . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['tax'] . '</td>';
                echo '<td style="text-align: center;">' . number_format($data_sales['total'], 2, ",", ".") . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['goods'] . '</td>';
                echo '<td style="text-align: center;">' . number_format($data_sales['qty'], 2, ",", ".") . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['unit'] . '</td>';
                echo '<td style="text-align: center;">' . number_format($data_sales['price'], 2, ",", ".") . '</td>';
                echo '<td style="text-align: center;">' . $data_sales['discount_detail'] . '</td>';
                echo '<td style="text-align: center;">' . number_format($data_sales['subtotal'], 2, ",", ".") . '</td>';
                echo '<td style="text-align: center;">' . number_format($data_sales['qty_shipped'], 2, ",", ".") . '</td>';
                echo '</tr>';
                $i++;
            }
            ?>
        </tbody>
    </table>
</body>

</html>