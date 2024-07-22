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
                <th scope="col">Goods</th>
                <th scope="col">Qty</th>
                <th scope="col">Unit</th>
                <th scope="col">Price</th>
                <th scope="col">Discount</th>
                <th scope="col">total</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $i = 1;
            $subtotal = 0;
            foreach ($detail as $data_detail) {
                echo '<tr>';
                echo '<td style="text-align: center;">' . $i . '</td>';
                echo '<td style="text-align: center;">' . $data_detail['goods'] . '</td>';
                echo '<td style="text-align: right;">' . number_format($data_detail['qty'], 2, ",", ".") . '</td>';
                echo '<td style="text-align: center;">' . $data_detail['unit'] . '</td>';
                echo '<td style="text-align: right;">' . number_format($data_detail['price'], 2, ",", ".") . '</td>';
                echo '<td style="text-align: center;">' . $data_detail['discount'] . '</td>';
                echo '<td style="text-align: right;">Rp ' . number_format($data_detail['subtotal'], 2, ",", ".") . '</td>';
                echo '</tr>';
                $i++;
                $subtotal += $data_detail['subtotal'];

                $discount = $header["discount"];
                $discount = ($discount / 100) * $discount;

                $tax = $header["tax"];
                $tax = ($tax / 100) * $tax;

                $total = $subtotal - $discount + $tax;
            }
            ?>
            <tr>
                <td colspan="7"></td>
            </tr>
            <tr>
                <td colspan="5"></td>
                <td style="text-align: center;">Subtotal</td>
                <td style="text-align: right;"> Rp <?= number_format($subtotal, 2, ",", "."); ?></td>
            </tr>
            <tr>
                <td colspan="5"></td>
                <td style="text-align: center;">Discount</td>
                <td style="text-align: right;"> Rp <?= number_format($discount, 2, ",", "."); ?></td>
            </tr>
            <tr>
                <td colspan="5"></td>
                <td style="text-align: center;">Tax</td>
                <td style="text-align: right;"> Rp <?= number_format($tax, 2, ",", "."); ?></td>
            </tr>
            <tr>
                <td colspan="5"></td>
                <td style="text-align: center;">Total</td>
                <td style="text-align: right;"> Rp <?= number_format($total, 2, ",", "."); ?></td>
            </tr>
        </tbody>
    </table>
</body>

</html>