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
    <el-form-item :label-width="labelWidth" label="排序" prop="sort">
        <el-input v-model="model.sort" show-word-limit maxlength="None" placeholder="请输入排序"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="编码" prop="code">
        <el-input v-model="model.code" show-word-limit maxlength="255" placeholder="请输入编码"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="创建时间" prop="create_time">
        <el-input v-model="model.create_time" show-word-limit maxlength="None" placeholder="请输入创建时间"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="名称" prop="table">
        <el-input v-model="model.table" show-word-limit maxlength="255" placeholder="请输入名称"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="更新人" prop="updata_user">
        <el-input v-model="model.updata_user" show-word-limit maxlength="50" placeholder="请输入更新人"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="主键" prop="id">
        <el-input v-model="model.id" show-word-limit maxlength="50" placeholder="请输入主键"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="字典编码" prop="dict_code">
        <el-input v-model="model.dict_code" show-word-limit maxlength="255" placeholder="请输入字典编码"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="创建人" prop="create_user">
        <el-input v-model="model.create_user" show-word-limit maxlength="50" placeholder="请输入创建人"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="更新时间" prop="updata_time">
        <el-input v-model="model.updata_time" show-word-limit maxlength="None" placeholder="请输入更新时间"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="描述" prop="describe">
        <el-input v-model="model.describe" show-word-limit maxlength="65535" placeholder="请输入描述"></el-input>
    </el-form-item>
</el-col>
    </el-row>
  </el-form>
</template>
<script>
import http from "@/http/http";

export default {
  name: "OnlOnlDictFieldForm",
  data() {
    return {
      labelWidth: "100px",
      model: {},
      rules: {},
      url: {
        add: "/onl/onl_dict_field",
        eidt: "/onl/onl_dict_field",
        one: "/onl/onl_dict_field/one",
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