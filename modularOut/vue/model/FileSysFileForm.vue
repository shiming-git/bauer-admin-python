<template>
  <el-form
    :model="model"
    :rules="rules"
    label-width="80px"
    size="small"
    ref="form"
  >
    <el-row>
        <el-col :span="24">
    <el-form-item :label-width="labelWidth" label="创建人" prop="created_by">
        <el-input v-model="model.created_by" show-word-limit maxlength="255" placeholder="请输入创建人"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="创建时间" prop="created_date">
        <el-input v-model="model.created_date" show-word-limit maxlength="0" placeholder="请输入创建时间"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="文件格式" prop="file_format">
        <el-input v-model="model.file_format" show-word-limit maxlength="50" placeholder="请输入文件格式"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="文件名" prop="file_name">
        <el-input v-model="model.file_name" show-word-limit maxlength="255" placeholder="请输入文件名"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="文件原始名" prop="file_original_name">
        <el-input v-model="model.file_original_name" show-word-limit maxlength="255" placeholder="请输入文件原始名"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="文件大小" prop="file_size">
        <el-input v-model="model.file_size" show-word-limit maxlength="0" placeholder="请输入文件大小"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="文件路径" prop="file_url">
        <el-input v-model="model.file_url" show-word-limit maxlength="255" placeholder="请输入文件路径"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="ID " prop="id">
        <el-input v-model="model.id" show-word-limit maxlength="36" placeholder="请输入ID "></el-input>
    </el-form-item>
</el-col>
    </el-row>
  </el-form>
</template>
<script>
import http from "@/http/http";

export default {
  name: "FileSysFileForm",
  data() {
    return {
      labelWidth: "100px",
      model: {},
      rules: {},
      url: {
        add: "/file/sys_file",
        eidt: "/file/sys_file",
        one: "/file/sys_file/one",
      },
    };
  },
  created() {
    //备份model原始值
    this.modelDefault = JSON.parse(JSON.stringify(this.model));
  },
  methods: {
    add() {
      this.model = Object.assign({}, this.modelDefault);
    },
    edit(record) {
      if (record.id) {
        this.getDataInfo(record.id);
      }
    },

    submitForm() {
      this.$refs.form.validate((valid) => {
        if (!valid) {
          this.$emit("err");
          return false;
        }
        if (this.model.id) {
          http.put(this.url.eidt, this.model).then((res) => {
            if (res.code != "00000") {
              this.$message.error(res.message);
              this.$emit("err")
              return;
            }
            this.$message({
              message: "操作成功",
              type: "success",
            });
            this.$emit("ok");
          });
        } else {
          http.post(this.url.add, this.model).then((res) => {
            if (res.code != "00000") {
              this.$message.error(res.message);
              this.$emit("err")
              return;
            }
            this.$message({
              message: "操作成功",
              type: "success",
            });
            this.$emit("ok");
          });
        }
      });
    },
    getDataInfo(id) {
      http.get(this.url.one, { id: id }).then((res) => {
        if (res.code != "00000") {
          this.$message.error(res.message);
          return;
        }
        this.model = res.data;
      });
    },
  },
};
</script>
<style lang="scss" scoped>
</style>