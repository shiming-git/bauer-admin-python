<template>
  <div>
    <div class="x-table-top">
      <el-row>
        <el-button type="primary" size="small" icon="el-icon-circle-plus" @click="addHandle()">
          添加
        </el-button>
        <el-button type="danger" size="mini" icon="el-icon-delete" v-if="multipleSelection.length > 0"  @click="batchdeleteHandle">
          批量删除
        </el-button>
      </el-row>
    </div>
    <x-table
      rowKey="id"
      :tableColumn="tableColumn"
      :tableData="tableData"
      :loading="loading"
      :pagination="ipagination"
      isSelection
      isNumber
      v-model="multipleSelection"
      @onpage="handlePage"
    >

      <template v-slot:modify="{ txt, row, index }">
        <el-button type="text" size="small" @click="editHandle(row)">编辑</el-button>
        <el-divider direction="vertical"></el-divider>
        <el-dropdown size="small">
          <el-button type="text" size="small"> 更多 </el-button>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item icon="el-icon-delete"  @click.native="deleteHandle(row.id)">
              删除
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </template>
    </x-table>

    <readTableModel ref="model" @ok="submitForm"></readTableModel>
  </div>
</template>
<script>
import { pageMiXin } from "@/mixins/pageMiXin";
import readTableModel from "./model/OnlOnlDictFieldModel";

export default {
  name: "OnlOnlDictFieldList",
  mixins: [pageMiXin],
  components: { readTableModel},
  data() {
    return {
      table_describe:"字典字段",
      table_name: "onl_dict_field",
      config: {
        setting_button: true,
      },

      url: {
        list: "/onl/onl_dict_field",
        edit: "/onl/onl_dict_field",
        delete: "/onl/onl_dict_field",
      },
    };
  },
  created() {},
  methods: {

  },
};
</script>
<style lang="less" scoped>
</style>