<style>
    td.nowrap-column {
        white-space: nowrap
    }
</style>

<table class="table table-hover" id="dataTable">
    <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col" style="text-align: center !important;">ID</th>
            <th scope="col" style="text-align: center !important;">Date</th>
            <th scope="col" style="text-align: center !important;">Type</th>
            <th scope="col" style="text-align: center !important;">Supplier</th>
            <th scope="col" style="text-align: center !important;">Due Date</th>
            <th scope="col" style="text-align: center !important;">Currency</th>
            <th scope="col" style="text-align: center !important;">Total</th>
            <th scope="col" style="text-align: center !important;">Action</th>
        </tr>
    </thead>
    <tbody>
        <?php
        $i = 1;
        foreach ($purchase as $data_purchase) :
        ?>
            <tr>
                <td scope="row"><?= $i ?></td>
                <td><?= $data_purchase['purchase_id']; ?></td>
                <td style="text-align: center !important;"><?= $data_purchase['date']; ?></td>
                <td style="text-align: center !important;"><?= $data_purchase['type']; ?></td>
                <td><?= $data_purchase['supplier']; ?></td>
                <td style="text-align: center !important;"><?= $data_purchase['due_date']; ?></td>
                <td style="text-align: center !important;"><?= $data_purchase['currency']; ?></td>
                <td style="text-align: right !important;"><?= number_format($data_purchase['total'], 2, ",", "."); ?></td>
                <td style="text-align: center !important;">
                    <a class="btn btn-info m-1" id="btnDetail" title="Detail" onclick="get('detail','<?= $data_purchase['id'] . '|' . $data_purchase['purchase_id']; ?>','')"><i class="fas fa-fw fa-solid fa-eye m-1"></i></a>
                    <a class="btn btn-warning m-1" id="btnEdit" title="Edit" onclick="get('edit','<?= $data_purchase['id']; ?>','')"><i class="fas fa-fw fa-solid fa-pen-to-square m-1"></i></a>
                    <a class="btn btn-danger m-1" id="btnDelete" title="Delete" onclick="remove('data','<?= $data_purchase['id'] . '|' . $data_purchase['purchase_id']; ?>')"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>
                    <a class="btn btn-primary m-1" id="btnPrint" title="Print" onclick="report('print','<?= $data_purchase['id'] . '|' . $data_purchase['purchase_id']; ?>')"><i class="fas fa-fw fa-solid fa-print m-1"></i></a>
                </td>
            </tr>
        <?php
            $i++;
        endforeach;
        ?>
    </tbody>
</table>