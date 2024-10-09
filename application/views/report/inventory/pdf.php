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
                <th scope="col">Inventory Id</th>
                <th scope="col">Date</th>
                <th scope="col">Type</th>
                <th scope="col">Warehouse</th>
                <th scope="col">Transaction ID</th>
                <th scope="col">Goods</th>
                <th scope="col">Qty</th>
                <th scope="col">Unit</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $i = 1;

            foreach ($inventory as $data_inventory) {
                echo '<tr>';
                echo '<td style="text-align: center;">' . $i . '</td>';
                echo '<td style="text-align: center;">' . $data_inventory['inventory_id'] . '</td>';
                echo '<td style="text-align: center;">' . $data_inventory['date'] . '</td>';
                echo '<td style="text-align: center;">' . $data_inventory['type'] . '</td>';
                echo '<td style="text-align: center;">' . $data_inventory['warehouse'] . '</td>';
                echo '<td style="text-align: center;">' . $data_inventory['transaction_id'] . '</td>';
                echo '<td style="text-align: center;">' . $data_inventory['goods'] . '</td>';
                echo '<td style="text-align: center;">' . number_format($data_inventory['qty'], 2, ",", ".") . '</td>';
                echo '<td style="text-align: center;">' . $data_inventory['unit'] . '</td>';
                echo '</tr>';
                $i++;
            }
            ?>
        </tbody>
    </table>
</body>

</html>