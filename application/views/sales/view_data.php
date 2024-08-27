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
            <th scope="col" style="text-align: center !important;">Customer</th>
            <th scope="col" style="text-align: center !important;">Due Date</th>
            <th scope="col" style="text-align: center !important;">Currency</th>
            <th scope="col" style="text-align: center !important;">Total</th>
            <th scope="col" style="text-align: center !important;">Action</th>
        </tr>
    </thead>
    <tbody>
        <?php
        $i = 1;
        foreach ($sales as $data_sales) :
        ?>
            <tr>
                <td scope="row"><?= $i ?></td>
                <td><?= $data_sales['sales_id']; ?></td>
                <td style="text-align: center !important;"><?= $data_sales['date']; ?></td>
                <td><?= $data_sales['customer']; ?></td>
                <td style="text-align: center !important;"><?= $data_sales['due_date']; ?></td>
                <td style="text-align: center !important;"><?= $data_sales['currency']; ?></td>
                <td style="text-align: right !important;"><?= number_format($data_sales['total'], 2, ",", "."); ?></td>
                <td style="text-align: center !important;">
                    <a class="btn btn-info m-1" id="btnDetail" title="Detail" onclick="get('detail','<?= $data_sales['id'] . '|' . $data_sales['sales_id']; ?>','')"><i class="fas fa-fw fa-solid fa-eye m-1"></i></a>
                    <a class="btn btn-warning m-1" id="btnEdit" title="Edit" onclick="get('edit','<?= $data_sales['id']; ?>','')"><i class="fas fa-fw fa-solid fa-pen-to-square m-1"></i></a>
                    <a class="btn btn-danger m-1" id="btnDelete" title="Delete" onclick="remove('data','<?= $data_sales['id'] . '|' . $data_sales['sales_id']; ?>')"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>
                    <a class="btn btn-primary m-1" id="btnPrint" title="Delete" onclick="report('print','<?= $data_sales['id'] . '|' . $data_sales['sales_id']; ?>')"><i class="fas fa-fw fa-solid fa-print m-1"></i></a>
                </td>
            </tr>
        <?php
            $i++;
        endforeach;
        ?>
    </tbody>
</table>