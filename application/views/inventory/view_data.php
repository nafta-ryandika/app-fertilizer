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
            <th scope="col" style="text-align: center !important;">Warehouse</th>
            <th scope="col" style="text-align: center !important;">Transaction ID</th>
            <th scope="col" style="text-align: center !important;">Goods</th>
            <th scope="col" style="text-align: center !important;">Action</th>
        </tr>
    </thead>
    <tbody>
        <?php
        $i = 1;
        foreach ($inventory as $data_inventory) :
            $status = $data_inventory['status'];
            $type = $data_inventory['type'];
            $disabled = "";

            if ($status == 2 && $type == "Receipt") {
                $disabled = "disabled";
            }
        ?>
            <tr>
                <td scope="row"><?= $i ?></td>
                <td><?= $data_inventory['inventory_id']; ?></td>
                <td style="text-align: center !important;"><?= $data_inventory['date']; ?></td>
                <td><?= $data_inventory['type']; ?></td>
                <td style="text-align: center !important;"><?= $data_inventory['warehouse']; ?></td>
                <td style="text-align: center !important;"><?= $data_inventory['transaction_id']; ?></td>
                <td style="text-align: center !important;"><?= $data_inventory['goods']; ?></td>
                <td style="text-align: center !important;">
                    <a class="btn btn-info m-1" id="btnDetail" title="Detail" onclick="get('detail','<?= $data_inventory['id'] . '|' . $data_inventory['inventory_id']; ?>','')"><i class="fas fa-fw fa-solid fa-eye m-1"></i></a>
                    <a class="btn btn-warning m-1" id="btnEdit" title="Edit" onclick="get('edit','<?= $data_inventory['id']; ?>','')"><i class="fas fa-fw fa-solid fa-pen-to-square m-1"></i></a>
                    <a class="btn btn-danger m-1 <?= $disabled ?>" id="btnDelete" title="Delete" onclick="remove('data','<?= $data_inventory['id'] . '|' . $data_inventory['inventory_id']; ?>')"><i class="fas fa-fw fa-solid fa-square-xmark m-1"></i></a>
                    <a class="btn btn-primary m-1" id="btnPrint" title="Print" onclick="report('print','<?= $data_inventory['id'] . '|' . $data_inventory['inventory_id']; ?>')"><i class="fas fa-fw fa-solid fa-print m-1"></i></a>
                </td>
            </tr>
        <?php
            $i++;
        endforeach;
        ?>
    </tbody>
</table>