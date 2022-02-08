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
    <el-form-item :label-width="labelWidth" label="用户头像" prop="avatarUrl">
        <el-input v-model="model.avatarUrl" show-word-limit maxlength="255" placeholder="请输入用户头像"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="登录时间" prop="loginDate">
        <el-input v-model="model.loginDate" show-word-limit maxlength="0" placeholder="请输入登录时间"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="登录状态" prop="loginState">
        <el-input v-model="model.loginState" show-word-limit maxlength="0" placeholder="请输入登录状态"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="创建时间" prop="newDate">
        <el-input v-model="model.newDate" show-word-limit maxlength="0" placeholder="请输入创建时间"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="用户密码" prop="passWord">
        <el-input v-model="model.passWord" show-word-limit maxlength="255" placeholder="请输入用户密码"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="用户名称" prop="realName">
        <el-input v-model="model.realName" show-word-limit maxlength="32" placeholder="请输入用户名称"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="用户的性别" prop="sex">
        <el-input v-model="model.sex" show-word-limit maxlength="0" placeholder="请输入用户的性别"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="状态" prop="state">
        <el-input v-model="model.state" show-word-limit maxlength="0" placeholder="请输入状态"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="用户ID" prop="userID">
        <el-input v-model="model.userID" show-word-limit maxlength="50" placeholder="请输入用户ID"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="用户账号" prop="userName">
        <el-input v-model="model.userName" show-word-limit maxlength="32" placeholder="请输入用户账号"></el-input>
    </el-form-item>
</el-col>
<el-col :span="24">
    <el-form-item :label-width="labelWidth" label="绑定微信" prop="weixinUser">
        <el-input v-model="model.weixinUser" show-word-limit maxlength="50" placeholder="请输入绑定微信"></el-input>
    </el-form-item>
</el-col>
    </el-row>
  </el-form>
</template>
<script>
import http from "@/http/http";

export default {
  name: "SysSysUsersForm",
  data() {
    return {
      labelWidth: "100px",
      model: {},
      rules: {},
      url: {
        add: "/sys/sys_users",
        eidt: "/sys/sys_users",
        one: "/sys/sys_users/one",
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
        this.tableMode = res.data
      });
    },
  },
};
</script>
<style lang="scss" scoped>
</style>